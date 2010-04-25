// AtomRefreshOperation.h

@class AtomSubscription;

@interface AtomRefreshSubscriptionOperation : NSOperation {
  @private
	AtomSubscription* subscription_;
  @private
	NSURLConnection* connection_;
	NSMutableData* data_;
	NSInteger statusCode_;
	BOOL executing_;
	BOOL finished_;
}

- (id) initWithSubscription: (AtomSubscription*) subscription;

@end