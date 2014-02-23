//
//  Card.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 27/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "Card.h"

static NSString* cardRankDesc[13] = {
	@"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine",
	@"Ten", @"Jack", @"Queen", @"King", @"Ace" };

static NSString* cardSuitDesc[5] = {
	@"Diamonds", @"Spades", @"Hearts", @"Clubs", @"None"};

static char cardRankDescShort[13] = { '2', '3', '4', '5', '6', '7', '8', '9', 'X', 'J', 'Q', 'K', 'A'  };
static char cardSuitDescShort[5] = { 'D', 'S', 'H', 'C', 'N' };

static int cardValue[13] =		{ 0,0,0,0,0,0,0,0,10,2,3,4,11 };
static int cardTrumpValue[13] = { 0,0,0,0,0,0,0,14,10,20,3,4,11 };

const unsigned short cardMask[13] = {	0x1000,
										0x0800,
										0x0400,
										0x0200,
										0x0100,
										0x0080,
										0x0040,
										0x0020,
										0x0010,
										0x0008,
										0x0004,
										0x0002,
										0x0001 };


@implementation Card

- (id)initCardWithRank: (TCardRank)inRank suit: (TCardSuit)inSuit
{
	self = [super init];
	
	if(self != nil)
	{
		rank = inRank;
		suit = inSuit;
	}
	
	return self;
}

- (TCardRank)rank
{
	return rank;
}

- (TCardSuit)suit
{
	return suit;
}

- (int)value: (BOOL)trump
{
	return trump ? cardTrumpValue[rank] : cardValue[rank]; 
}

- (NSString*)description
{
	NSMutableString* temp = [NSMutableString string];
	[temp appendFormat: @"%c%c", cardRankDescShort[rank], cardSuitDescShort[suit]];
		
	return temp;	
}

+(NSString*)suitDescription: (TCardSuit)aSuit
{
	return cardSuitDesc[aSuit];
}

+(TCardRank)rankFromCharacter: (char)aCharacter
{
	TCardRank rank = ACE;
	
	switch (aCharacter) 
	{
		case 'A':
		case 'K':
			--rank;
		case 'Q':
			--rank;
		case 'J':
			--rank;
		case 'X':
			--rank;
		case '9':
			--rank;
		case '8':
			--rank;
		case '7':
			--rank;
		case '6':
			--rank;
		case '5':
			--rank;
		case '4':
			--rank;
		case '3':
			--rank;
		case '2':
			--rank;
			break;
		default:
			break;
	}
	
	return rank;
}

+(TCardSuit)suitFromCharacter: (char)aCharacter
{
	TCardSuit suit = NONE;
	switch (aCharacter)
	{
		case 'N':
		case 'C':
			--suit;
		case 'H':
			--suit;
		case 'S':
			--suit;
		case 'D':
			--suit;
			break;
		default:
			break;
	}
	
	return suit;
}

@end
