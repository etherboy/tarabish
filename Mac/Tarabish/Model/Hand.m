//
//  Hand.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "Hand.h"
#import "Deck.h"
#import "Player.h"

@implementation Hand

-(id)initWithPlayers: (NSArray*)aPlayers deck: (Deck*)aDeck
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
	int i = 0;
	NSMutableArray* eligablePlayers = [NSMutableArray arrayWithArray: players];
	
	int cardCount = [deck cardCount];
	
	for(i = 0; i < cardCount; i++)
	{
		int luckyIndex = rand() % [eligablePlayers count];		
		Player* luckyPlayer = [eligablePlayers objectAtIndex: luckyIndex];
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

-(void)dealloc
{
	[super dealloc];
}

@end
