//
//  TarabishMatch.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Player.h"
#import "Deck.h"
#import "Hand.h"
#import "MasterMind.h"


@interface TarabishMatch : NSObject 
{
	Deck* deck;
	NSArray* players;
	NSMutableArray* hands;
	MasterMind* mind;
}

- (id)init;
- (void)dealloc;

- (void)beginHand;
- (Hand*)currentHand;

- (NSArray*)players;
- (MasterMind*)masterMind;
@end
