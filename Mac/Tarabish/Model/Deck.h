//
//  Deck.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Card.h"

@interface Deck : NSObject 
{
@private
	NSArray* cards;
}

-(id)init;
-(Card*)cardAtIndex: (int)index;
-(Card*)cardWithRank:(TCardRank)rank suit:(TCardSuit)suit;
-(int)cardCount;
-(void)dealloc;

@end
