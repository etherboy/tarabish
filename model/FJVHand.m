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

@interface FJVHand ()
{
    TCardSuit _trump;
	int _dealerIndex;
	int _trumpCallerIndex;
	int _activePlayerIndex;
	NSArray* _players;
	FJVDeck* _deck;
}

@end

@implementation FJVHand

-(instancetype)initWithPlayers: (NSArray*)players deck: (FJVDeck*)deck
{
	self = [super init];
	
	if(self!=nil)
	{
		_trump = NONE;
		_dealerIndex = -1;
		_trumpCallerIndex = -1;
		_activePlayerIndex = -1;
		_players = players;
		_deck = deck;
	}
	
	return self;
}

-(void)initiateHand: (int)inDealerIndex
{
	_dealerIndex = inDealerIndex;
	
	[self dealCards];
	
	_activePlayerIndex = (_dealerIndex+1)%[_players count];
	[[_players objectAtIndex: _activePlayerIndex] callTrumpOpen: NO];
}

-(void)dealCards
{
	NSUInteger i = 0;
	NSMutableArray* eligablePlayers = [NSMutableArray arrayWithArray: _players];
	
	NSUInteger cardCount = [_deck cardCount];
	
	for(i = 0; i < cardCount; i++)
	{
		int luckyIndex = rand() % [eligablePlayers count];		
		FJVPlayer* luckyPlayer = [eligablePlayers objectAtIndex: luckyIndex];
		if(![luckyPlayer acceptCard: [_deck cardAtIndex: i]])
		{
			[eligablePlayers removeObjectAtIndex: luckyIndex];
		}
	}
}

-(void)trumpCalled: (TCardSuit)aTrump
{
	if(aTrump != NONE)
	{
		_trump = aTrump;
		_trumpCallerIndex = _activePlayerIndex;
		
		[_players makeObjectsPerformSelector: @selector(trumpCalled)];
		
		_activePlayerIndex = (_dealerIndex+1)%[_players count];
		
		//		m_rPlayers[m_iActivePlayerIndex].PlayCardOpen();
	}
	else
	{
		_activePlayerIndex = (_activePlayerIndex+1)%[_players count];
		
		[[_players objectAtIndex: _activePlayerIndex] callTrumpOpen: _activePlayerIndex == _dealerIndex];
	}
}

-(int)dealerIndex
{
	return _dealerIndex;
}

@end
