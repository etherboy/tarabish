/*
 *  MasterMind.h
 *  Tarabish
 *
 *  Created by Fritz Vander Heide on 11/11/07.
 *  Copyright 2007 Grimlock Tech. All rights reserved.
 *
 */

#import "Card.h"

@class Player;
@class Deck;


@interface TrumpCallRule : NSObject
{
	unsigned short requiredTrumpMask;
	int requiredTrumpCount;
	int additionalTrump;
	unsigned short requiredPrimaryOutsideMask;
	int requiredPrimaryOutsideCount;
	int additionalPrimaryOutside;
	unsigned short requiredSecondaryOutsideMask;
	int requiredSecondaryOutsideCount;
	int totalOutsidePoints;
}
	
-(id)initWithRequiredTrump: (NSString*)reqTrump 
		   additionalTrump: (int)addTrump
	requiredPrimaryOutside: (NSString*)reqPrimary
  additionalPrimaryOutside: (int)addPrimary
  requiredSecondaryOutside: (NSString*)reqSecondary
		totalOutsidePoints: (int)outsidePoints;

@property(readonly) unsigned short requiredTrumpMask;
@property(readonly) int requiredTrumpCount;
@property(readonly) int additionalTrump;
@property(readonly) unsigned short requiredPrimaryOutsideMask;
@property(readonly) int requiredPrimaryOutsideCount;
@property(readonly) int additionalPrimaryOutside;
@property(readonly) unsigned short requiredSecondaryOutsideMask;
@property(readonly) int requiredSecondaryOutsideCount;
@property(readonly) int totalOutsidePoints;

@end


@interface MasterMind : NSObject
{
	Deck* deck;
	NSArray* trumpCallRules;
}

-(id)initWithDeck:(Deck*)aDeck trumpCallRules:(NSArray*)aRuleCollection;
-(void)dealloc;

-(TCardSuit)callTrumpForPlayer:(Player*)player forced:(BOOL)forced;

@end

