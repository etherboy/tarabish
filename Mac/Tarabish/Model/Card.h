//
//  Card.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 27/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {	TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK,
				QUEEN, KING, ACE } TCardRank;

typedef enum { DIAMOND, SPADE, HEART, CLUB, NONE } TCardSuit;

const unsigned short cardMask[13]; 

@interface Card : NSObject 
{
@private
	TCardRank rank;
	TCardSuit suit;
}

- (id)initCardWithRank: (TCardRank)inRank suit: (TCardSuit)inSuit;
- (TCardRank)rank;
- (TCardSuit)suit;
- (int)value: (BOOL)trump;
- (NSString*)description;

+(NSString*)suitDescription: (TCardSuit)aSuit;
+(TCardRank)rankFromCharacter: (char)aCharacter;
+(TCardSuit)suitFromCharacter: (char)aCharacter;

@end
