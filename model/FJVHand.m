//
//  Hand.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import "FJVHand.h"
#import "FJVDeck.h"
#import "FJVPlayer.h"

@implementation FJVHand

-(id)initWithPlayers: (NSArray*)aPlayers deck: (FJVDeck*)aDeck
{
	self = [super init];
	
	if(self!=nil)
	{
		trump = NONE;
		dealerIndex = -1;
		trumpCallerIndex = -1;
		activePlayerIndex = -1;
		players = aPlayers;
		deck = aDeck;
	}
	
	return self;
}

-(void)initiateHand: (int)inDealerIndex
{
	dealerIndex = inDealerIndex;
	
	[self dealCards];
	
	activePlayerIndex = (dealerIndex+1)%[players count];
	[[players objectAtIndex: activePlayerIndex] callTrumpOpen: NO];
}

-(void)dealCards
{
	NSUInteger i = 0;
	NSMutableArray* eligablePlayers = [NSMutableArray arrayWithArray: players];
	
	NSUInteger cardCount = [deck cardCount];
	
	for(i = 0; i < cardCount; i++)
	{
		int luckyIndex = rand() % [eligablePlayers count];		
		FJVPlayer* luckyPlayer = [eligablePlayers objectAtIndex: luckyIndex];
		if(![luckyPlayer acceptCard: [deck cardAtIndex: i]])
		{
			[eligablePlayers removeObjectAtIndex: luckyIndex];
		}
	}
}

-(void)trumpCalled: (TCardSuit)aTrump
{
	if(aTrump != NONE)
	{
		trump = aTrump;
		trumpCallerIndex = activePlayerIndex;
		
		[players makeObjectsPerformSelector: @selector(trumpCalled)];
		
		activePlayerIndex = (dealerIndex+1)%[players count];
		
		//		m_rPlayers[m_iActivePlayerIndex].PlayCardOpen();
	}
	else
	{
		activePlayerIndex = (activePlayerIndex+1)%[players count];
		
		[[players objectAtIndex: activePlayerIndex] callTrumpOpen: activePlayerIndex == dealerIndex];
	}
}

-(int)dealerIndex
{
	return dealerIndex;
}

@end
