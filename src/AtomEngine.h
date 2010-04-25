// AtomEngine.h

@class AtomSubscription;

@interface AtomEngine : NSObject {
  @private
	NSMutableArray* subscriptions_;
	NSOperationQueue* operationQueue_;
}

+ (id) sharedEngine;

- (NSArray*) subscriptions;
- (AtomSubscription*) subscriptionWithURL: (NSURL*) url;
- (void) addSubscription: (AtomSubscription*) subscription;

- (void) refreshAllSubscriptions;
- (void) refreshSubscription: (AtomSubscription*) subscription;

@end