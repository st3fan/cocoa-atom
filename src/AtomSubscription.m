// AtomSubscription.m

#import "AtomFeed.h"
#import "AtomSubscription.h"

@implementation AtomSubscription

@synthesize url = url_;
@synthesize name = name_;
@synthesize feed = feed_;

+ (id) subscriptionWithURL: (NSURL*) url name: (NSString*) name
{
	return [[[self alloc] initWithURL: url name: name] autorelease];
}

- (id) initWithURL: (NSURL*) url name: (NSString*) name
{
	if ((self = [super init]) != nil) {
		url_ = [url retain];
		name_ = [name retain];
	}
	return self;
}

- (void) dealloc
{
	[url_ release];
	[name_ release];
	[feed_ release];
	[super dealloc];
}

@end