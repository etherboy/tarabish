//
//  FJVCardView.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 2014-03-15.
//  Copyright (c) 2014 AppleTrek. All rights reserved.
//

#import "FJVCardView.h"

static NSString* rankChars[] = {@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X",@"J",@"Q",@"K",@"A"};
static NSString* suitChars[] = {@"♦️",@"♠️",@"♥️",@"♣️",@" "};

const CGFloat kFJVStandardCornerRadius = 10.0;
const CGFloat kFJVStandardHeight = 100.0;

@interface FJVCardView ()
{
    UIBezierPath* _shape;
    UIBezierPath* _backShape;
    UIColor* _cardColor;
    UIColor* _backColor;
    UIFont* _labelFont;
    NSAttributedString* _label;
}

@end

@implementation FJVCardView

#pragma mark - initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [self setup];
}

-(void)setup
{
    self.opaque = NO;
    self.backgroundColor = nil;
    self.contentMode = UIViewContentModeRedraw;
    
    if(!_shape)
    {
        _shape = [UIBezierPath bezierPathWithRoundedRect: self.bounds cornerRadius: [self radius]];
    }
    
    if(!_cardColor)
    {
        _cardColor = [UIColor whiteColor];
    }
    
    if(!_backShape)
    {
        CGPoint aInset = [self offset];
        
        _backShape = [UIBezierPath bezierPathWithRoundedRect: CGRectInset(self.bounds, aInset.x, aInset.y) cornerRadius: [self radius]];
    }
    
    if(!_backColor)
    {
        _backColor = [UIColor colorWithRed: 0.2 green: 0.4 blue: 0.1 alpha: 1.0];
    }
    
    if(!_labelFont)
    {
        _labelFont = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
        _labelFont = [_labelFont fontWithSize: _labelFont.pointSize * [self scale]];
    }
    
    if(!_label)
    {
        NSString* aLabel = [NSString stringWithFormat: @"%@\n%@", rankChars[_rank], suitChars[_suit]];
        
        NSMutableParagraphStyle* aParaStyle = [[NSMutableParagraphStyle alloc] init];
        aParaStyle.alignment = NSTextAlignmentCenter;
        
        _label = [[NSAttributedString alloc] initWithString: aLabel attributes: @{ NSFontAttributeName : _labelFont, NSParagraphStyleAttributeName : aParaStyle }];
    }
    
    [self setNeedsDisplay];
}

#pragma mark - Accessors

-(void)setSuit:(TCardSuit)suit
{
    if(_suit != suit)
    {
        _suit = suit;
        _label = nil;
        [self setup];
    }
}

-(void)setRank:(TCardRank)rank
{
    if(_rank != rank)
    {
        _rank = rank;
        _label = nil;
        [self setup];
    }
}

-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

-(void)setBounds:(CGRect)bounds
{
    [super setBounds: bounds];
    
    _shape = nil;
    _backShape = nil;
    _label = nil;
    _labelFont = nil;
    
    [self setup];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [_shape addClip];
    [_cardColor setFill];
    [_shape fill];
    
    if(self.faceUp)
    {
        [_label drawAtPoint: [self offset]];
    
        CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
        CGContextRotateCTM(context, M_PI);
    
        [_label drawAtPoint: [self offset]];
    }
    else
    {
        [_backColor setFill];
        [_backShape fill];
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - Positioning

-(CGFloat)scale
{
    return self.bounds.size.height / kFJVStandardHeight;
}

-(CGFloat)radius
{
    return [self scale] * kFJVStandardCornerRadius;
}

-(CGPoint)offset
{
    CGFloat aOffset = [self radius] / 3.0;
    return CGPointMake(aOffset, aOffset);
}

@end
