//
//  Deck.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import "FJVDeck.h"

@interface FJVDeck ()
{
    NSArray* cards;
}
@end

@implementation FJVDeck

-(instancetype)init
{
	self = [super init];
	
	if(self!= nil)
	{
		NSMutableArray* temp = [NSMutableArray array];
		
		int i = 0;
		for(i = 0; i < 36; i++)
		{
			[temp addObject: [[FJVCard alloc] initCardWithRank:(TCardRank)i%9+4 suit:(TCardSuit)i/9]];
		}
    
		cards = [NSArray arrayWithArray: temp];
	}
	
	return self;
}

-(FJVCard*)cardAtIndex: (int)index
{
	return [cards objectAtIndex: index];
}

-(FJVCard*)cardWithRank:(TCardRank)rank suit:(TCardSuit) suit
{
	return [cards objectAtIndex: suit/9+rank%9];
}

-(NSUInteger)cardCount
{
	return [cards count];
}

@end
