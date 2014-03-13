//
//  Hand.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FJVCard.h"

@class FJVPlayer;
@class FJVDeck;


@interface FJVHand : NSObject 
{
	TCardSuit trump;
	int dealerIndex;
	int trumpCallerIndex;
	int activePlayerIndex;
	NSArray* players;
	FJVDeck* deck;
}

-(id)initWithPlayers: (NSArray*)aPlayers deck: (FJVDeck*)aDeck ;
-(void)dealCards;
-(void)trumpCalled: (TCardSuit)trump;
-(void)initiateHand: (int)aDealerIndex;
-(int)dealerIndex;

@end
