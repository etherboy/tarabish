//
//  Player.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "TarabishMatch.h";

const int MAX_CARDS_IN_HAND = 9;
const int MAX_CARDS_IN_KITTY = 3;

@implementation Player

- (id)initWithName: (NSString*)aName game: (TarabishMatch*)aGame
{
	self = [super init];
	
	if(self!=nil)
	{
		name = [aName retain];
		hand = [[NSMutableArray alloc] init];
		kitty = [[NSMutableArray alloc] init];
		game = aGame;
		avatar = nil; 
	}
	
	return self;
}

-(void)setAvatar: (BTPlayerAvatar*)anAvatar
{
	avatar = anAvatar;
}

- (BOOL)acceptCard: (Card*)aCard
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

- (void)dealloc
{
	[name release];
	[hand release];
	[kitty release];
	
	[super dealloc];
}

@end
