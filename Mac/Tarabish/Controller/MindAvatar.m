//
//  MindAvatar.mm
//  Tarabish
//
//  Created by Fritz Vander Heide on 12/04/08.
//  Copyright 2008 Grimlock Tech. All rights reserved.
//

#import "MindAvatar.h"


@implementation BTMindAvatar

- (id)init
{
	self = [super init];
	
	if(self!=nil)
	{
		mind = nil;
	}
	
	return self;
}

- (void)setMind: (MasterMind*)aMind
{
	mind = aMind;
}

- (void)callTrumpOpen: (BOOL)forced
{
	if(mind)
	{
		[NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(callTrumpClose:) userInfo: [NSNumber numberWithBool: forced] repeats: NO];
	}
}

- (void)callTrumpClose: (id)sender
{
	NSNumber* trump = [NSNumber numberWithInt: [mind callTrumpForPlayer: player forced: [[sender userInfo] boolValue]]];
	 
	[super callTrumpClose: trump];
}

- (void)playTrickOpen
{
	if(mind)
	{
		[NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(playTrickClose) userInfo: nil repeats: NO];
	}
}

- (void)playTrickClose
{
//	mind->FindRuns(player->Hand())	
}

//- (void)playCardOpen
//{
//
//}
//
//- (void)playCardClose:(const CCard* const) card
//{
//	mind->FindRuns(player->Hand())
//}

- (void)dealloc
{	
	[super dealloc];
}

@end
