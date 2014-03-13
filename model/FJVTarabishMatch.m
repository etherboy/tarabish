//
//  TarabishMatch.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import "FJVTarabishMatch.h"


@implementation FJVTarabishMatch

- (id)init
{
	self = [super init];
	
	if(self!=nil)
	{
		deck = [[FJVDeck alloc] init];
		
		players = [[NSArray alloc] initWithObjects: 
				   [[FJVPlayer alloc] initWithName: @"Fred" game: self],
				   [[FJVPlayer alloc] initWithName: @"Mary" game: self],
				   [[FJVPlayer alloc] initWithName: @"Mike" game: self],
				   [[FJVPlayer alloc] initWithName: @"Lucy" game: self],
				   nil];
		
		hands = [[NSMutableArray alloc] init];
		
		NSArray* rawRules = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] 
											 pathForResource: @"TrumpRules" ofType: @"plist"] ]; 
		
		NSMutableArray* cookedRules = [NSMutableArray array];
		
		for(NSDictionary* rawRule in rawRules)
		{
			FJVTrumpCallRule* rule = [[FJVTrumpCallRule alloc] initWithRequiredTrump: [rawRule objectForKey: @"RequiredTrump"]
															   additionalTrump: [[rawRule objectForKey: @"AdditionalTrump"] intValue]
														requiredPrimaryOutside: [rawRule objectForKey: @"RequiredPrimaryOutside"]
													  additionalPrimaryOutside: [[rawRule objectForKey: @"AdditionalPrimaryOutside"] intValue]
													  requiredSecondaryOutside: [rawRule objectForKey: @"RequiredSecondaryOutside"]
															totalOutsidePoints: [[rawRule objectForKey: @"TotalOutsidePoints"] intValue]];
			
			[cookedRules addObject: rule];
		}
		
		mind = [[FJVMasterMind alloc] initWithDeck: deck trumpCallRules: cookedRules];
		
		srand((unsigned int)time(0));
	}
	
	return self;
}

- (void)beginHand
{
	[players makeObjectsPerformSelector: @selector(clearHand)];
	FJVHand* newHand = [[FJVHand alloc] initWithPlayers: players deck: deck];
	
	int dealerIndex = 0;
	
	if([hands count] != 0)
	{
		dealerIndex = ([[hands objectAtIndex: [hands count] - 1] dealerIndex]+1)%[players count];
	}
	
	[newHand initiateHand: dealerIndex]; 
	[hands addObject: newHand];
}

- (FJVHand*)currentHand
{
	return [hands objectAtIndex: [hands count] - 1];
}

- (NSArray*)players
{
	return [NSArray arrayWithArray: players];
}

- (FJVMasterMind*)masterMind
{
	return mind;
}

@end
