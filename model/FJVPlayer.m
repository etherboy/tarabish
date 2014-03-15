//
//  Player.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import "FJVPlayer.h"
#import "FJVTarabishMatch.h"
#import "FJVHand.h"

const int MAX_CARDS_IN_HAND = 9;
const int MAX_CARDS_IN_KITTY = 3;

@interface FJVPlayer ()
{
    NSMutableArray* _hand;
	NSMutableArray* _kitty;
	FJVTarabishMatch* _game;
    
    NSArray* _runs;
	NSArray* _bella;
}

@end

@implementation FJVPlayer

- (instancetype)initWithName: (NSString*)name game: (FJVTarabishMatch*)game
{
	self = [super init];
	
	if(self!=nil)
	{
		_name = name;
		_hand = [[NSMutableArray alloc] init];
		_kitty = [[NSMutableArray alloc] init];
		_game = game;
		_avatar = nil;
	}
	
	return self;
}

-(NSArray*)hand
{
    return [_hand copy];
}

- (BOOL)acceptCard: (FJVCard*)card
{
	[_hand addObject: card];
	
	BOOL moreCards = [_hand count] < MAX_CARDS_IN_HAND;

	if(_avatar)
	{
		if(!moreCards)
		{
			int i = 0;
			//Select Kitty
			for(i = 0; i < MAX_CARDS_IN_KITTY; i++)
			{
				int cardIndex = rand()%[_hand count];
				[_kitty addObject: [_hand objectAtIndex: cardIndex]];
				[_hand removeObjectAtIndex: cardIndex];
			}
			
			[_avatar handChanged];
		}
	}
	
	return moreCards;
}

- (void)clearHand
{
	[_hand removeAllObjects];
	[_kitty removeAllObjects];
}

-(void)callTrumpOpen: (BOOL)forced
{
	[_avatar callTrumpOpen: forced];
}

-(void)callTrumpClose: (TCardSuit)trump
{
	[[_game currentHand] trumpCalled: trump];
}

-(void)trumpCalled
{
	[_hand addObjectsFromArray: _kitty];
	[_avatar handChanged];
}

-(void)playCardOpen
{
}

-(void)analyzeHand;
{
	
}

@end
