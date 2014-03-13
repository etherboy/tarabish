//
//  TarabishMatch.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FJVPlayer.h"
#import "FJVDeck.h"
#import "FJVHand.h"
#import "FJVMasterMind.h"


@interface FJVTarabishMatch : NSObject 
{
	FJVDeck* deck;
	NSArray* players;
	NSMutableArray* hands;
	FJVMasterMind* mind;
}

- (id)init;

- (void)beginHand;
- (FJVHand*)currentHand;

- (NSArray*)players;
- (FJVMasterMind*)masterMind;
@end
