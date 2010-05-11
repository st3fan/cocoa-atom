// AtomEntry.h

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AtomContent;

@interface AtomEntry : NSObject {
  @private
	NSString* title_;
	NSString* summary_;
	NSString* identifier_;
	NSMutableSet* links_;
	NSDate* published_;
	NSDate* updated_;
	AtomContent* content_;
}

@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* summary;
@property (nonatomic,retain) NSString* identifier;
@property (nonatomic,retain) NSSet* links;
@property (nonatomic,retain) NSDate* published;
@property (nonatomic,retain) NSDate* updated;
@property (nonatomic,retain) AtomContent* content;

- (void) setPublishedFromString: (NSString*) string;
- (void) setUpdatedFromString: (NSString*) string;

- (NSSet*) linksWithRelationType: (NSString*) rel;

@end