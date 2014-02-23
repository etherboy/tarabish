//
//  Trick.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 03/07/07.
//  Copyright 2007 Grimlock Tech. All rights reserved.
//

//#import "Trick.h"
//
//const int MAX_PLAYS_PER_TRICK = 4;
//
//typedef struct PlayTag
//{
//	Card* aCard;
//	Player* aPlayer;
//} PLAY;
//
//@implementation Trick
//
//- (id)init
//{
//	self = [super init];
//	
//	if(self != nil)
//	{
//		plays = [[NSMutableArray alloc] initWithCapacity: MAX_PLAYS_PER_TRICK];
//	}
//	
//	return self;
//}
//
//- (BOOL)addCard: (Card*)aCard forPlayer: (Player*)aPlayer
//{
//	BOOL status = NO;
///*	
//	if((aCard != nil) && (aPlayer != nil) && ([plays count] < MAX_PLAYS_PER_TRICK))
//	{
//		PLAY aPlay = {aCard, aPlayer};
//		[plays addObject: aPlay];
//		status = YES;
//	}
//*/	
//	return status;
//}
//
//- (Card*)cardPlayedBy: (Player*)aPlayer
//{
///*	int playCount = [plays count];
//	int i = 0;
//	
//	Card* foundCard = nil;
//	
//	for(i = 0; i < playCount; i++)
//	{
//		if([plays objectAtIndex: i].aPlayer == aPlayer)
//	}
//*/
//	return nil;
//}
//
//- (Player*)playerAtTurn: (int)turn
//{
//	return nil;
//}
//
//- (void)dealloc
//{
//	[plays release];
//	[super dealloc];
//}
//
//@end
