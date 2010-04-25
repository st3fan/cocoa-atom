// AtomContent.m

#import "AtomContent.h"

@implementation AtomContent

@synthesize text = text_;
@synthesize type = type_;

- (void) dealloc
{
	[text_ release];
	[type_ release];
	[super dealloc];
}

@end