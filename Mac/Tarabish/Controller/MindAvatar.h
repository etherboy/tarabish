//
//  MindAvatar.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 12/04/08.
//  Copyright 2008 Grimlock Tech. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PlayerAvatar.h"
#import "MasterMind.h"


@interface BTMindAvatar : BTPlayerAvatar 
{
	MasterMind* mind;
}

- (id)init;
- (void)setMind:(MasterMind*) aMind;

- (void)callTrumpOpen:(BOOL) forced;
- (void)callTrumpClose:(id) sender;
- (void)playTrickOpen;
- (void)playTrickClose;

//- (void)playCardOpen;
//- (void)playCardClose:(const CCard* const) card;

- (void)dealloc;

@end
