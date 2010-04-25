// AtomFeed.m

#import "AtomEntry.h"
#import "AtomFeed.h"

@implementation AtomFeed

@synthesize identifier = identifier_;
@synthesize entries = entries_;
@synthesize title = title_;
@synthesize subtitle = subtitle_;
@synthesize updated = updated_;

- (id) init
{
	if ((self = [super init]) != nil) {
		entries_ = [NSMutableArray new];
	}
	return self;
}

- (void) dealloc
{
	[identifier_ release];
	[title_ release];
	[subtitle_ release];
	[entries_ release];
	[updated_ release];
	[super dealloc];
}

- (void) setUpdatedFromString: (NSString*) string
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter new] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    self.updated = [dateFormatter dateFromString: string];
}

- (AtomEntry*) entryWithIdentifier: (NSString*) identifier
{
	for (AtomEntry* entry in entries_) {
		if ([entry.identifier isEqualToString: identifier]) {
			return entry;
		}
	}
	return nil;
}

@end