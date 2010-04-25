// AtomContent.h

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface AtomContent : NSObject {
	NSString* text_;
	NSString* type_;
}

@property (nonatomic,retain) NSString* text;
@property (nonatomic,retain) NSString* type;

@end