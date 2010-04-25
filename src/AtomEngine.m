//  AtomEngine.m

#import "AtomRefreshSubscriptionOperation.h"
#import "AtomSubscription.h"
#import "AtomEngine.h"

@implementation AtomEngine

+ (id) sharedEngine
{
	static AtomEngine* atomEngineSingleton = nil;

	@synchronized (self) {
		if (atomEngineSingleton == nil) {
			atomEngineSingleton = [self new];
		}
	}
	
	return atomEngineSingleton;
}

#pragma mark -

- (id) init
{
	if ((self = [super init]) != nil) {
		subscriptions_ = [NSMutableArray new];
		operationQueue_ = [NSOperationQueue new];
		[operationQueue_ setMaxConcurrentOperationCount: 2];
	}
	
	return self;
}

- (void) dealloc
{
	[subscriptions_ release];
	[operationQueue_ release];
	[super dealloc];
}

#pragma mark -

- (NSArray*) subscriptions
{
	return [subscriptions_ copy];
}

- (AtomSubscription*) subscriptionWithURL: (NSURL*) url
{
	for (AtomSubscription* subscription in subscriptions_) {
		if ([subscription.url isEqual: url]) {
			return subscription;
		}
	}
	return nil;
}

- (void) addSubscription: (AtomSubscription*) subscription
{
	if ([self subscriptionWithURL: subscription.url]) {
		return;
	}
	
	[subscriptions_ addObject: subscription];
}

#pragma mark -

- (void) refreshAllSubscriptions
{
	for (AtomSubscription* subscription in subscriptions_) {
		[self refreshSubscription: subscription];
	}
}

- (void) refreshSubscription: (AtomSubscription*) subscription
{
	AtomRefreshSubscriptionOperation* operation = [[AtomRefreshSubscriptionOperation alloc] initWithSubscription: subscription];
	if (operation != nil) {
		[operationQueue_ addOperation: operation];
		[operation release];
	}
}

@end