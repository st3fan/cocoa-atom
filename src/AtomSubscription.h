// AtomSubscription.h

#import <Foundation/Foundation.h>

@class AtomFeed;

@interface AtomSubscription : NSObject {
  @private
	NSURL* url_;
	NSString* name_;
	AtomFeed* feed_;
}

@property (nonatomic,retain) NSURL* url;
@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain) AtomFeed* feed;

+ (id) subscriptionWithURL: (NSURL*) url name: (NSString*) name;
- (id) initWithURL: (NSURL*) url name: (NSString*) name;

@end
















#if 0
// Create a repository
AtomRepository* repository = [[AtomRepository repositoryAtPath: ...] retain];

// Create a new subscription

AtomSubscription* subscription = [AtomSubscription subscriptionWithName: ... URL: ...];
[repository addSubscription: subscription];

// Get a unique identifier for the subscription that we can store in the prefs
NSString* subscriptionIdentifier = subscription.identifier;

// Reload the repository, only feeds that need a reload
[repository reload];

// List of feeds
NSArray* feeds = [repository feeds];

// Display each feed and it's unread count
for (AtomFeed* feed in feeds) {
	NSLog(@"Feed '%@' has %d unread items", feed.name, feed.unreadCount);
}

// List items in a feed
for (AtomEntry* entry in feed.entries) {
	NSLog(@" - %@", entry.title);
}

// Mark an entry read
entry.read = YES;
#endif
