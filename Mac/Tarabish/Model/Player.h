//
//  Player.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 Blitzwing Technologies. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Card.h"
#import "PlayerAvatar.h"

@class TarabishMatch;

@interface Player : NSObject 
{
@private
	NSString* name;
	NSMutableArray* hand;
	NSMutableArray* kitty;
	TarabishMatch* game;
	BTPlayerAvatar* avatar;
	
	NSArray* runs;
	NSArray* bella;
}

-(id)initWithName: (NSString*)aName game: (TarabishMatch*)aGame;
-(void)setAvatar: (BTPlayerAvatar*)anAvatar;
-(BOOL)acceptCard: (Card*)aCard;
-(void)clearHand;
-(NSString*)name;
-(NSArray*)hand;

-(void)callTrumpOpen: (BOOL)forced;
-(void)callTrumpClose: (TCardSuit)trump;
-(void)trumpCalled;
-(void)playCardOpen;

- (void)dealloc;

@end
