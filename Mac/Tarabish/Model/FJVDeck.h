//
//  Deck.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FJVCard.h"

@interface FJVDeck : NSObject 
{
@private
	NSArray* cards;
}

-(id)init;
-(FJVCard*)cardAtIndex: (int)index;
-(FJVCard*)cardWithRank:(TCardRank)rank suit:(TCardSuit)suit;
-(NSUInteger)cardCount;

@end
