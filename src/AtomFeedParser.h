// AtomFeedParser.h

#import <Foundation/Foundation.h>

@class AtomFeed;

@interface AtomFeedParser : NSObject {

}

+ (AtomFeed*) parseAtomFeedFromData: (NSData*) data;
+ (AtomFeed*) parseAtomFeedFromURL: (NSURL*) url;
+ (AtomFeed*) parseAtomFeedFromFile: (NSString*) path;

@end