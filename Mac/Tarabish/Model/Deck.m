//
//  Deck.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "Deck.h"

@implementation Deck

-(id)init
{
	self = [super init];
	
	if(self!= nil)
	{
		NSMutableArray* temp = [NSMutableArray array];
		
		int i = 0;
		for(i = 0; i < 36; i++)
		{
			[temp addObject: [[Card alloc] initCardWithRank:(TCardRank)i%9+4 suit:(TCardSuit)i/9]];
		}
		
		cards = [[NSArray arrayWithArray: temp] retain];
	}
	
	return self;
}

-(Card*)cardAtIndex: (int)index
{
	return [cards objectAtIndex: index];
}

-(Card*)cardWithRank:(TCardRank)rank suit:(TCardSuit) suit
{
	return [cards objectAtIndex: suit/9+rank%9];
}

-(int)cardCount
{
	return [cards count];
}

-(void)dealloc
{
	[cards release];
	
	[super dealloc];
}

@end
