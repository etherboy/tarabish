//
//  Hand.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

@import Foundation;
#import "FJVCard.h"

@class FJVDeck;

@interface FJVHand : NSObject 

-(instancetype)initWithPlayers: (NSArray*)players deck: (FJVDeck*)deck ;
-(void)dealCards;
-(void)trumpCalled: (TCardSuit)trump;
-(void)initiateHand: (int)aDealerIndex;

@property (nonatomic, readonly) int dealerIndex;

@end
