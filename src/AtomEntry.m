// AtomEntry.m

#import "AtomEntry.h"
#import "AtomContent.h"

@implementation AtomEntry

@synthesize title = title_;
@synthesize summary = summary_;
@synthesize identifier = identifier_;
@synthesize published = published_;
@synthesize updated = updated_;
@synthesize content = content_;

- (void) dealloc
{
	[title_ release];
	[summary_ release];
	[identifier_ release];
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

@end