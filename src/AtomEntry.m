// AtomEntry.m

#import "AtomEntry.h"
#import "AtomLink.h"
#import "AtomContent.h"

@implementation AtomEntry

@synthesize title = title_;
@synthesize summary = summary_;
@synthesize identifier = identifier_;
@synthesize links = links_;
@synthesize published = published_;
@synthesize updated = updated_;
@synthesize content = content_;

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
	NSDateFormatter* dateFormatter = [[NSDateFormatter new] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    self.published = [dateFormatter dateFromString: string];
}

- (void) setUpdatedFromString: (NSString*) string
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter new] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    self.updated = [dateFormatter dateFromString: string];
}

- (NSSet*) linksWithRelationType: (NSString*) rel
{
	return [links_ filteredSetUsingPredicate: [NSPredicate predicateWithFormat: @"self.rel = %@", rel]];
}

@end