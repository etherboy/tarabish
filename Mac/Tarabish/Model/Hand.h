//
//  Hand.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Card.h"

@class Player;
@class Deck;


@interface Hand : NSObject 
{
	TCardSuit trump;
	int dealerIndex;
	int trumpCallerIndex;
	int activePlayerIndex;
	NSArray* players;
	Deck* deck;
}

-(id)initWithPlayers: (NSArray*)aPlayers deck: (Deck*)aDeck ;
-(void)dealCards;
-(void)trumpCalled: (TCardSuit)trump;
-(void)initiateHand: (int)aDealerIndex;
-(int)dealerIndex;
-(void)dealloc;

@end
