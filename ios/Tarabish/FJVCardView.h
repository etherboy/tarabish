//
//  FJVCardView.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 2014-03-15.
//  Copyright (c) 2014 AppleTrek. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "FJVCardDefs.h"

@interface FJVCardView : UIView

@property (nonatomic) TCardRank rank;
@property (nonatomic) TCardSuit suit;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;

@end
