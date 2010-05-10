// AtomFeedParser.m

#import "XMLDigester.h"

#import "AtomFeed.h"
#import "AtomEntry.h"
#import "AtomContent.h"

#import "AtomFeedParser.h"

@implementation AtomFeedParser

+ (AtomFeed*) parseAtomFeedFromData: (NSData*) data
{
	AtomFeed* atomFeed = nil;
	
	if (data != nil)
	{
		XMLDigester* digester = [XMLDigester digesterWithData: data];
		if (digester != nil)
		{
			[digester addRule:
				[XMLDigesterObjectCreateRule objectCreateRuleWithClass: [AtomFeed class]]
					forPattern: @"feed"];

			[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setTitle:)]
				forPattern: @"feed/title"];

			[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setSubtitle:)]
				forPattern: @"feed/subtitle"];

						// TODO: This should use some converter instead of setFooFromString:

						[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setUpdatedFromString:)]
							forPattern: @"feed/updated"];

			[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setIdentifier:)]
				forPattern: @"feed/id"];
			
			[digester addRule:
				[XMLDigesterObjectCreateRule objectCreateRuleWithClass: [AtomEntry class]]
					forPattern: @"feed/entry"];
			
			[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setTitle:)]
				forPattern: @"feed/entry/title"];

			[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setIdentifier:)]
				forPattern: @"feed/entry/id"];
				
			[digester addRule: [XMLDigesterCallMethodWithAttributeRule callMethodWithAttributeRuleWithSelector: @selector(setLink:) attribute: @"href"]
				forPattern: @"feed/entry/link"];

			[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setSummary:)]
				forPattern: @"feed/entry/summary"];

					// TODO: This should use some converter instead of setFooFromString:

					[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setPublishedFromString:)]
						forPattern: @"feed/entry/published"];

					[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setUpdatedFromString:)]
						forPattern: @"feed/entry/updated"];

			[digester addRule:
				[XMLDigesterObjectCreateRule objectCreateRuleWithClass: [AtomContent class]]
					forPattern: @"feed/entry/content"];
					
			[digester addRule:
				[XMLDigesterSetPropertiesRule setPropertiesRuleWithMappings: [NSDictionary dictionaryWithObject: @"type" forKey: @"type"]]
					forPattern: @"feed/entry/content"];

			[digester addRule: [XMLDigesterCallMethodWithElementBodyRule callMethodWithElementBodyRuleWithSelector: @selector(setText:)]
				forPattern: @"feed/entry/content"];
					
			[digester addRule:
				[XMLDigesterSetNextRule setNextRuleWithSelector: @selector(setContent:)]
					forPattern: @"feed/entry/content"];

			[digester addRule:
				[XMLDigesterAddObjectRule addObjectRuleWithProperty: @"entries"]
					forPattern: @"feed/entry"];
			
			atomFeed = (AtomFeed*) [digester digest];
		}
	}
	
	return atomFeed;
}

+ (AtomFeed*) parseAtomFeedFromURL: (NSURL*) url
{
	return [self parseAtomFeedFromData: [NSData dataWithContentsOfURL: url]];
}

+ (AtomFeed*) parseAtomFeedFromFile: (NSString*) path
{
	return [self parseAtomFeedFromData: [NSData dataWithContentsOfFile: path]];
}

@end