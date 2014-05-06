//
//  SetCardViewController.m
//  GraphicalSet
//
//  Created by Kevin Yang on 4/30/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetCard.h"

@interface SetCardViewController ()

@end

static const int SET_CARD_GAME = 1;

@implementation SetCardViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (UIView *)makeCardView:(Grid *)grid atRow:(int)r atColumn:(int)c
{
    return [[SetCardView alloc] initWithFrame:[grid frameOfCellAtRow:r inColumn:c]];
}

- (UIView *)makeCardView {
    return [[SetCardView alloc] init];
}

- (void)drawCardView:(UIView *)cardView withCard:(Card *)card
{
    SetCardView *setCardView = (SetCardView *)cardView;
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        setCardView.symbol = setCard.symbol;
        setCardView.number = setCard.number;
        setCardView.shading = setCard.shading;
        setCardView.color = setCard.color;
    }
}

- (void)animateCardView:(UIView *)cardView withCard:(Card *)card
{
    SetCardView *setCardView = (SetCardView *)cardView;
    if(setCardView.lastState != card.isChosen) {
        [UIView transitionWithView:setCardView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCurlDown
                        animations:^{
                            if (card.isChosen) {
                                setCardView.chosen = true;
                            }else{
                                setCardView.chosen = false;
                            }
                        }
                        completion:nil];
    }
    setCardView.lastState = card.isChosen;
}

- (void)animateCardRemoval:(UIView *)cardView withCard:(Card *)card {
    SetCardView *setCardView = (SetCardView *)cardView;
    [UIView transitionWithView:setCardView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{setCardView.alpha = 0;} completion:nil];
}

- (void)setGameMode:(CardMatchingGame *)game
{
    game.gameMode = SET_CARD_GAME;
}

- (int)defaultNumCards {
    return 12;
}

@end
