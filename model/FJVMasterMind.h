/*
 *  MasterMind.h
 *  Tarabish
 *
 *  Created by Fritz Vander Heide on 11/11/07.
 *  Copyright 2007 Grimlock Tech. All rights reserved.
 *
 */

#import "FJVCard.h"

@class FJVPlayer;
@class FJVDeck;


@interface FJVTrumpCallRule : NSObject
	
-(instancetype)initWithRequiredTrump: (NSString*)reqTrump
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


@interface FJVMasterMind : NSObject

-(instancetype)initWithDeck:(FJVDeck*)deck trumpCallRules:(NSArray*)ruleCollection;

-(TCardSuit)callTrumpForPlayer:(FJVPlayer*)player forced:(BOOL)forced;

@end

