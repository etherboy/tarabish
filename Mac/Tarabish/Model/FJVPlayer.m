//
//  Player.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import "FJVPlayer.h"
#import "FJVTarabishMatch.h"

const int MAX_CARDS_IN_HAND = 9;
const int MAX_CARDS_IN_KITTY = 3;

@implementation FJVPlayer

- (id)initWithName: (NSString*)aName game: (FJVTarabishMatch*)aGame
{
	self = [super init];
	
	if(self!=nil)
	{
		name = aName;
		hand = [[NSMutableArray alloc] init];
		kitty = [[NSMutableArray alloc] init];
		game = aGame;
		avatar = nil; 
	}
	
	return self;
}

-(void)setAvatar: (FJVPlayerAvatar*)anAvatar
{
	avatar = anAvatar;
}

- (BOOL)acceptCard: (FJVCard*)aCard
{
	[hand addObject: aCard];
	
	BOOL moreCards = [hand count] < MAX_CARDS_IN_HAND;

	if(avatar)
	{
		if(!moreCards)
		{
			int i = 0;
			//Select Kitty
			for(i = 0; i < MAX_CARDS_IN_KITTY; i++)
			{
				int cardIndex = rand()%[hand count];
				[kitty addObject: [hand objectAtIndex: cardIndex]];	
				[hand removeObjectAtIndex: cardIndex];
			}
			
			[avatar handChanged];
		}
	}
	
	return moreCards;
}

- (void)clearHand
{
	[hand removeAllObjects];
	[kitty removeAllObjects];
}

- (NSString*)name
{
	return [NSString stringWithString: name];
}

- (NSArray*)hand
{
	return [NSArray arrayWithArray: hand];
}

-(void)callTrumpOpen: (BOOL)forced
{
	[avatar callTrumpOpen: forced];
}

-(void)callTrumpClose: (TCardSuit)trump
{
	[[game currentHand] trumpCalled: trump];
}

-(void)trumpCalled
{
	[hand addObjectsFromArray: kitty];
	[avatar handChanged];
}

-(void)playCardOpen
{
}

-(void)analyzeHand;
{
	
}

@end
