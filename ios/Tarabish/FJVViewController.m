//
//  FJVViewController.m
//  Tarabish
//
//  Created by Fritz Vander Heide on 2014-03-10.
//  Copyright (c) 2014 AppleTrek. All rights reserved.
//

#import "FJVViewController.h"
#import "FJVCardView.h"
#import "FJVDeck.h"
#import "FJVCard.h"

@interface FJVViewController ()
{
    FJVDeck* _deck;
}

@property (weak, nonatomic) IBOutlet UISlider *cardSelect;
@property (weak, nonatomic) IBOutlet FJVCardView *card;

@end

@implementation FJVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _deck = [[FJVDeck alloc] init];
    _card.rank = [_deck cardAtIndex:0].rank;
    _card.suit = [_deck cardAtIndex:0].suit;
    _card.faceUp = YES;
    
    _cardSelect.maximumValue = _deck.cardCount - 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)flip:(id)sender
{
    _card.faceUp = !_card.faceUp;
}

- (IBAction)sizer:(UISlider *)sender
{
    CGRect aCardBounds = _card.bounds;
    _card.bounds = CGRectMake(aCardBounds.origin.x, aCardBounds.origin.y, 50*sender.value, 70*sender.value);
}

- (IBAction)selector:(UISlider *)sender
{
    FJVCard* aCard = [_deck cardAtIndex: (int)sender.value];
    _card.rank = aCard.rank;
    _card.suit = aCard.suit;
}
@end
