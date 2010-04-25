// AtomFeed.h

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AtomEntry;

@interface AtomFeed : NSObject {
  @private
	NSString* identifier_;
    NSString* title_;
    NSString* subtitle_;
	NSDate* updated_;
	NSMutableArray* entries_;
}

@property (nonatomic,retain) NSString* identifier;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* subtitle;
@property (nonatomic,retain) NSDate* updated;
@property (nonatomic,readonly) NSMutableArray* entries;

- (void) setUpdatedFromString: (NSString*) string;

- (AtomEntry*) entryWithIdentifier: (NSString*) identifier;

@end