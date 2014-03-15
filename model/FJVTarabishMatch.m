//
//  TarabishMatch.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import "FJVTarabishMatch.h"
#import "FJVDeck.h"
#import "FJVHand.h"
#import "FJVPlayer.h"
#import "FJVMasterMind.h"

@interface FJVTarabishMatch ()
{
    FJVDeck* _deck;
	NSMutableArray* _hands;
}

@end


@implementation FJVTarabishMatch

- (instancetype)init
{
	self = [super init];
	
	if(self != nil)
	{
		_deck = [[FJVDeck alloc] init];
		
		_players = @[ [[FJVPlayer alloc] initWithName: @"Fred" game: self],
                      [[FJVPlayer alloc] initWithName: @"Mary" game: self],
                      [[FJVPlayer alloc] initWithName: @"Mike" game: self],
                      [[FJVPlayer alloc] initWithName: @"Lucy" game: self]];
		
		_hands = [[NSMutableArray alloc] init];
		
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
		
		_mind = [[FJVMasterMind alloc] initWithDeck: _deck trumpCallRules: cookedRules];
		
		srand((unsigned int)time(0));
	}
	
	return self;
}

- (void)beginHand
{
	[_players makeObjectsPerformSelector: @selector(clearHand)];
	FJVHand* newHand = [[FJVHand alloc] initWithPlayers: _players deck: _deck];
	
	int dealerIndex = 0;
	
	if([_hands count] != 0)
	{
		dealerIndex = ([[_hands objectAtIndex: [_hands count] - 1] dealerIndex]+1)%[_players count];
	}
	
	[newHand initiateHand: dealerIndex]; 
	[_hands addObject: newHand];
}

- (FJVHand*)currentHand
{
	return [_hands objectAtIndex: [_hands count] - 1];
}

@end
