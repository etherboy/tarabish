//
//  Card.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 27/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

@import Foundation;

#include "FJVCardDefs.h"

const unsigned short cardMask[13]; 

@interface FJVCard : NSObject

@property (nonatomic, readonly) TCardRank rank;
@property (nonatomic, readonly) TCardSuit suit;

- (instancetype)initCardWithRank: (TCardRank)rank suit: (TCardSuit)suit;
- (int)value: (BOOL)trump;
- (NSString*)description;

+(NSString*)suitDescription: (TCardSuit)suit;
+(TCardRank)rankFromCharacter: (char)character;
+(TCardSuit)suitFromCharacter: (char)character;

@end
