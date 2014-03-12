//
//  Player.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 28/06/07.
//  Copyright 2007 Blitzwing Technologies. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FJVCard.h"
#import "PlayerAvatar.h"

@class FJVTarabishMatch;

@interface FJVPlayer : NSObject 
{
@private
	NSString* name;
	NSMutableArray* hand;
	NSMutableArray* kitty;
	FJVTarabishMatch* game;
	FJVPlayerAvatar* avatar;
	
	NSArray* runs;
	NSArray* bella;
}

-(id)initWithName: (NSString*)aName game: (FJVTarabishMatch*)aGame;
-(void)setAvatar: (FJVPlayerAvatar*)anAvatar;
-(BOOL)acceptCard: (FJVCard*)aCard;
-(void)clearHand;
-(NSString*)name;
-(NSArray*)hand;

-(void)callTrumpOpen: (BOOL)forced;
-(void)callTrumpClose: (TCardSuit)trump;
-(void)trumpCalled;
-(void)playCardOpen;

@end
