//
//  TestAppDelegate.m
//  Test
//
//  Created by Stefan Arentz on 10-05-10.
//  Copyright Arentz Consulting 2010. All rights reserved.
//

#import "TestAppDelegate.h"
#import "RootViewController.h"

#import "AtomFeed.h"
#import "AtomEntry.h"
#import "AtomLink.h"
#import "AtomFeedParser.h"

@implementation TestAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSData* data = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"LinksTest" ofType: @"xml"]];
	AtomFeed* feed = [AtomFeedParser parseAtomFeedFromData: data];
	
	
	NSLog(@"feed.title = %@", feed.title);
	for (AtomEntry* entry in feed.entries)
	{
		NSLog(@"  feed.entries[].title = %@", entry.title);
		for (AtomLink* link in entry.links) {
			NSLog(@"    feed.entry.links[] = %@", link.href);
		}
		
		NSLog(@"    feed.entry.links[] (enclosure) = %@", [entry linksWithRelationType: @"enclosure"]);
		NSLog(@"    feed.entry.links[] (alt) = %@", [entry linksWithRelationType: @"alt"]);
	}


	//
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

