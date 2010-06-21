// AtomEntry.m

#import "AtomEntry.h"
#import "AtomLink.h"
#import "AtomContent.h"

static NSMutableArray* gDateFormatters = nil;

@implementation AtomEntry

@synthesize title = title_;
@synthesize summary = summary_;
@synthesize identifier = identifier_;
@synthesize links = links_;
@synthesize published = published_;
@synthesize updated = updated_;
@synthesize content = content_;

+ (void) initialize
{
	if (gDateFormatters == nil)
	{
		gDateFormatters = [NSMutableArray new];

		// 2009-11-03T23:11:51Z
		NSDateFormatter* dateFormatter = [[NSDateFormatter new] autorelease];
		if (dateFormatter != nil) {
			[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
			[gDateFormatters addObject: dateFormatter];
		}
		
		// YouTube: 2009-11-03T23:11:51.000Z
		dateFormatter = [[NSDateFormatter new] autorelease];
		if (dateFormatter != nil) {
			[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'.000Z'"];
			[gDateFormatters addObject: dateFormatter];
		}		
	}
}

- (id) init
{
	if ((self = [super init]) != nil) {
		links_ = [NSMutableSet new];
	}
	return self;
}

- (void) dealloc
{
	[title_ release];
	[summary_ release];
	[identifier_ release];
	[links_ release];
	[published_ release];
	[updated_ release];
	[content_ release];
	[super dealloc];
}

- (void) setPublishedFromString: (NSString*) string
{
	for (NSDateFormatter* dateFormatter in gDateFormatters) {
		NSDate* date = [dateFormatter dateFromString: string];
		if (date != nil) {
			self.published = date;
			return;
		}
	}
	
	NSLog(@"AtomEntry#setPublishedFromString: Failed to parse date %@", string);
}

- (void) setUpdatedFromString: (NSString*) string
{
	for (NSDateFormatter* dateFormatter in gDateFormatters) {
		NSDate* date = [dateFormatter dateFromString: string];
		if (date != nil) {
			self.updated = date;
			return;
		}
	}
	
	NSLog(@"AtomEntry#setUpdatedFromString: Failed to parse date %@", string);
}

- (NSSet*) linksWithRelationType: (NSString*) rel
{
	return [links_ filteredSetUsingPredicate: [NSPredicate predicateWithFormat: @"self.rel = %@", rel]];
}

@end