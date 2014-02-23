//
//  TarabishMatch.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "TarabishMatch.h"


@implementation TarabishMatch

- (id)init
{
	self = [super init];
	
	if(self!=nil)
	{
		deck = [[Deck alloc] init];
		
		players = [[NSArray alloc] initWithObjects: 
				   [[[Player alloc] initWithName: @"Fred" game: self] autorelease],
				   [[[Player alloc] initWithName: @"Mary" game: self] autorelease],
				   [[[Player alloc] initWithName: @"Mike" game: self] autorelease],
				   [[[Player alloc] initWithName: @"Lucy" game: self] autorelease],
				   nil];
		
		hands = [[NSMutableArray alloc] init];
		
		NSArray* rawRules = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] 
											 pathForResource: @"TrumpRules" ofType: @"plist"] ]; 
		
		NSMutableArray* cookedRules = [NSMutableArray array];
		
		for(NSDictionary* rawRule in rawRules)
		{
			TrumpCallRule* rule = [[TrumpCallRule alloc] initWithRequiredTrump: [rawRule objectForKey: @"RequiredTrump"]
															   additionalTrump: [[rawRule objectForKey: @"AdditionalTrump"] intValue]
														requiredPrimaryOutside: [rawRule objectForKey: @"RequiredPrimaryOutside"]
													  additionalPrimaryOutside: [[rawRule objectForKey: @"AdditionalPrimaryOutside"] intValue]
													  requiredSecondaryOutside: [rawRule objectForKey: @"RequiredSecondaryOutside"]
															totalOutsidePoints: [[rawRule objectForKey: @"TotalOutsidePoints"] intValue]];
			
			[cookedRules addObject: rule];
			[rule release];
		}
		
		mind = [[MasterMind alloc] initWithDeck: deck trumpCallRules: cookedRules];
		
		srand(time(0));
	}
	
	return self;
}

- (void)dealloc
{
	[deck release];
	[players release];
	[hands release];
	[mind release];
	
	[super dealloc];
}

- (void)beginHand
{
	[players makeObjectsPerformSelector: @selector(clearHand)];
	Hand* newHand = [[Hand alloc] initWithPlayers: players deck: deck];
	
	int dealerIndex = 0;
	
	if([hands count] != 0)
	{
		dealerIndex = ([[hands objectAtIndex: [hands count] - 1] dealerIndex]+1)%[players count];
	}
	
	[newHand initiateHand: dealerIndex]; 
	[hands addObject: newHand];
	[newHand release];
}

- (Hand*)currentHand
{
	return [hands objectAtIndex: [hands count] - 1];
}

- (NSArray*)players
{
	return [NSArray arrayWithArray: players];
}

- (MasterMind*)masterMind
{
	return mind;
}

@end
