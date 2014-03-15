//
//  TarabishMatch.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 29/06/07.
//  Copyright 2007 AppleTrek. All rights reserved.
//

@import Foundation;

@class FJVMasterMind;
@class FJVHand;

@interface FJVTarabishMatch : NSObject 

- (instancetype)init;
- (void)beginHand;

@property (nonatomic, readonly) FJVHand* currentHand;
@property (nonatomic, readonly) NSArray* players;
@property (nonatomic, readonly) FJVMasterMind* mind;

@end
