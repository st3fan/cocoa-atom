//  AtomRefreshOperation.m

#import "AtomFeedParser.h"
#import "AtomFeed.h"
#import "AtomEntry.h"
#import "AtomSubscription.h"
#import "AtomRefreshSubscriptionOperation.h"

@implementation AtomRefreshSubscriptionOperation

- (id) initWithSubscription: (AtomSubscription*) subscription
{
	if ((self = [super init]) != nil) {
		subscription_ = [subscription retain];
		data_ = [NSMutableData new];
	}
	return self;
}

- (void) dealloc
{
	[subscription_ release];
	[super dealloc];
}

#pragma mark -

- (void) start
{
	if (![self isCancelled])
	{
		connection_ = [[NSURLConnection connectionWithRequest:
			[NSURLRequest requestWithURL: subscription_.url] delegate: self] retain];

		if (connection_ != nil) {
			[self willChangeValueForKey:@"isExecuting"];
			executing_ = YES;
			[self didChangeValueForKey:@"isExecuting"];
		} else {
			[self willChangeValueForKey:@"isExecuting"];
			finished_ = YES;
			[self didChangeValueForKey:@"isExecuting"];
		}
	}
	else
	{
		// If it's already been cancelled, mark the operation as finished.
		[self willChangeValueForKey:@"isFinished"];
		{
			finished_ = YES;
		}
		[self didChangeValueForKey:@"isFinished"];
	}
}

- (BOOL) isConcurrent
{
	return YES;
}

- (BOOL) isExecuting
{
	return executing_;
}

- (BOOL) isFinished
{
  return finished_;
}

#pragma mark NSURLConnection Delegate Methods

- (void) connection: (NSURLConnection*) connection didReceiveData: (NSData*) data
{
	[data_ appendData: data];
}

- (void)connection: (NSURLConnection*) connection didReceiveResponse: (NSHTTPURLResponse*) response
{
	statusCode_ = [response statusCode];
}

- (void) connection: (NSURLConnection*) connection didFailWithError: (NSError*) error
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
	{
		finished_ = YES;
		executing_ = NO;
	}
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];	

	//[delegate_ loadImageDataOperationDidFail: self];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
	{
		finished_ = YES;
		executing_ = NO;
	}
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];	
	
	if (statusCode_ == 200)
	{
		NSLog(@"----- %@", subscription_.name);

		AtomFeed* feed = [AtomFeedParser parseAtomFeedFromData: data_];
		if (feed != nil)
		{
			if (subscription_.feed == nil)
			{
				subscription_.feed = feed;
				for (AtomEntry* entry in subscription_.feed.entries) {
					NSLog(@"    %@", entry.title);
				}
			}
			else
			{
				// If the feed has been replaced then delete the feed we have and store the new one
				
				if ([subscription_.feed.identifier isEqualToString: feed.identifier] == NO)
				{
					NSLog(@"Reloading complete feed");
					subscription_.feed = feed;
				}
				else
				{
					for (AtomEntry* entry in feed.entries)
					{
						AtomEntry* existingEntry = [subscription_.feed entryWithIdentifier: entry.identifier];
						if (existingEntry == nil) {
							[feed.entries addObject: entry];
							NSLog(@"    %@ (NEW)", entry.title);
						}
					}
				}
			}
			
			// If this subscription did not have a name then take the name from the feed
			
			if (subscription_.name == nil && feed.title != nil) {
				subscription_.name = feed.title;
			}
		}
	}
	else
	{
		//[delegate_ loadImageDataOperationDidFail: self];
	}
}

@end
