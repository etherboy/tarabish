//
//  Player.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 Blitzwing Technologies. All rights reserved.
//

@import Foundation;
#import "FJVCard.h"
#import "FJVAvatar.h"

@class FJVTarabishMatch;

@interface FJVPlayer : NSObject 

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSArray* hand;
@property (nonatomic) id<FJVAvatar> avatar;

-(instancetype)initWithName: (NSString*)name game: (FJVTarabishMatch*)game;

-(BOOL)acceptCard: (FJVCard*)card;
-(void)clearHand;

-(void)callTrumpOpen: (BOOL)forced;
-(void)callTrumpClose: (TCardSuit)trump;
-(void)trumpCalled;
-(void)playCardOpen;

@end
