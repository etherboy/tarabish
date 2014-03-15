/*
 *  MasterMind.m
 *  Tarabish
 *
 *  Created by Fritz Vander Heide on 11/11/07.
 *  Copyright 2007 Grimlock Tech. All rights reserved.
 *
 */

#import "FJVMasterMind.h"
#import "FJVDeck.h"
#import "FJVPlayer.h"

@implementation FJVTrumpCallRule

-(instancetype)initWithRequiredTrump: (NSString*)reqTrump
		   additionalTrump: (int)addTrump
	requiredPrimaryOutside: (NSString*)reqPrimary
  additionalPrimaryOutside: (int)addPrimary
  requiredSecondaryOutside: (NSString*)reqSecondary
		totalOutsidePoints: (int)outsidePoints
{
	self = [super init];
	
	if(self != nil)
	{
		int i = 0;
		
		for(i = 0; i < [reqTrump length]; i++)
			_requiredTrumpMask |= cardMask[[FJVCard rankFromCharacter: [reqTrump characterAtIndex: i]]];
		_requiredTrumpCount = [reqTrump length];
		_additionalTrump = addTrump;
		for(i = 0; i < [reqPrimary length]; i++)
			_requiredPrimaryOutsideMask |= cardMask[[FJVCard rankFromCharacter: [reqPrimary characterAtIndex: i]]];
		_requiredPrimaryOutsideCount = [reqPrimary length];
		_additionalPrimaryOutside = addPrimary;
		for(i = 0; i < [reqSecondary length]; i++)
			_requiredSecondaryOutsideMask |= cardMask[[FJVCard rankFromCharacter: [reqSecondary characterAtIndex: i]]];
		_requiredSecondaryOutsideCount = [reqSecondary length];
		_totalOutsidePoints = outsidePoints;
	}
	
	return self;
}

@end

@interface FJVMasterMind ()
{
    FJVDeck* _deck;
	NSArray* _trumpCallRules;
}

@end

@implementation FJVMasterMind

-(instancetype)initWithDeck:(FJVDeck*)deck trumpCallRules:(NSArray*)ruleCollection
{
	self = [super init];
	
	if(self)
	{
		_deck = deck;
		_trumpCallRules = ruleCollection;
	}
	
	return self;
}

-(TCardSuit)callTrumpForPlayer:(FJVPlayer*)player forced:(BOOL)forced
{
	struct SSuitStats
	{
		int cardCount;
		unsigned short cardRankMask;
		int value;
		int trumpValue;
	} suitStatistics[4] = {0};
	
	int i = 0;
	
	NSArray* hand = [player hand];
	
	for(i = [hand count] - 1; i >= 0; --i)
	{
		FJVCard* card = [hand objectAtIndex: i];
		int suitIndex = [card suit];
		
		++suitStatistics[suitIndex].cardCount;
		suitStatistics[suitIndex].cardRankMask |= cardMask[[card rank]];
		suitStatistics[suitIndex].value += [card value: NO];
		suitStatistics[suitIndex].trumpValue += [card value: YES];
	}
	
	int ruleMatched[4] = {-1, -1, -1, -1};
	
	for(i = 0; i < 4; ++i)
	{
		int outsidePoints = 0;
		int j = 0;
		int k = 0;
		
		for(j = 0; j < 4; ++j)
		{
			if(j != i)
			{
				outsidePoints += suitStatistics[j].value;
			}
		}
		
		for(k = 0; (ruleMatched[i] == -1) && (k < [_trumpCallRules count]); ++k)
		{
			FJVTrumpCallRule* rule = [_trumpCallRules objectAtIndex: k];
			
			if((suitStatistics[i].cardRankMask & rule.requiredTrumpMask) == rule.requiredTrumpMask)
			{
				if(suitStatistics[i].cardCount >= (rule.additionalTrump + rule.requiredTrumpCount))
				{
					if(outsidePoints >= rule.totalOutsidePoints)
					{
						BOOL primaryMatches[4] = {NO, NO, NO, NO};
						BOOL secondaryMatches[4] = {NO, NO, NO, NO};
						int m = 0;
						int n = 0;
						
						for(m = 0; (ruleMatched[i]== -1) && (m < 4); ++m)
						{
							if(m != i)
							{
								if((suitStatistics[m].cardRankMask & rule.requiredPrimaryOutsideMask) == rule.requiredPrimaryOutsideMask)
								{
									if(suitStatistics[m].cardCount >= (rule.additionalPrimaryOutside + rule.requiredPrimaryOutsideCount))
									{
										primaryMatches[m] = YES;
									}
								}
								
								if((suitStatistics[m].cardRankMask & rule.requiredSecondaryOutsideMask) == rule.requiredSecondaryOutsideMask)
								{
									secondaryMatches[m] = YES;
								}
							}
						}
								
						for(m = 0; (ruleMatched[i] == -1) && (m < 4); ++m)
						{
							for(n = 0; (ruleMatched[i] == -1) && (n < 4); ++n)
							{
								if(m != n)
								{
									if(primaryMatches[m] && secondaryMatches[n])
									{
										ruleMatched[i] = k;
									}
								}
							}
						}
					}
				}
			}
		}
	}
			
	int bestTrumpSuit = NONE;
	int bestTrumpRule = 25;
	int suitWithMostCards = 0;
			
	for(i = 0; i < 4; ++i)
	{
		if((ruleMatched[i] < bestTrumpRule) && (ruleMatched[i] > -1))
		{
			bestTrumpSuit = i;
			bestTrumpRule = ruleMatched[i];
		}
				
		if(suitStatistics[i].cardCount > suitStatistics[suitWithMostCards].cardCount)
		{
			suitWithMostCards = i;
		}
	}
			
	if((bestTrumpSuit == NONE) && forced)
	{
		bestTrumpSuit = suitWithMostCards; 
	}
								
	
	return bestTrumpSuit;
}

-(NSArray*)findBellaInHand:(NSArray*)hand trump:(TCardSuit)trump
{
	NSMutableArray* bellaCards = [[NSMutableArray alloc] init];
	
	for(FJVCard* card in hand)
	{
		if(([card suit] == trump) && (([card rank] == KING) || ([card rank] == QUEEN)))
		{
			[bellaCards addObject: card];
		}
	}
			
	if([bellaCards count] != 2)
	{
			[bellaCards removeAllObjects];
	}
	
	return bellaCards;
}

-(NSArray*)findRunsInHand:(NSArray*)hand
{
	NSMutableArray* runArray = [[NSMutableArray alloc] init];
	unsigned short binaryHand[4] = {0};
	int nextEligable[4]= {0};
	int i = 0;
	int j = 0;

	for(FJVCard* card in hand)
	{
		binaryHand[[card suit] - 1] |= cardMask[[card rank]];
	}
	
	for(i = 0; i < 10; ++i)
	{
		unsigned short fiftyMask = 0x000F << i;
		unsigned short twentyMask = 0x0007 << i;
		
		for(j = 0; j < 4; ++j)
		{
			if(i >= nextEligable[j])
			{
				if((binaryHand[j] & fiftyMask) == fiftyMask)
				{
					NSArray* run = [NSArray arrayWithObjects:	[_deck cardWithRank: i suit: j], 
																[_deck cardWithRank: i+1 suit: j],
																[_deck cardWithRank: i+2 suit: j],
																[_deck cardWithRank: i+3 suit: j], 
																nil];
					[runArray addObject: run];
					
					nextEligable[j] = i+4;
				}
				else if((binaryHand[j] & twentyMask) == twentyMask)
				{
					NSArray* run = [NSArray arrayWithObjects:	[_deck cardWithRank: i suit: j], 
																[_deck cardWithRank: i+1 suit: j],
																[_deck cardWithRank: i+2 suit: j], 
																nil];
					[runArray addObject: run];
					nextEligable[j] = i+3;
				}
			}
		}
	}
	
	return runArray;
}

@end



