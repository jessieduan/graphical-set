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


#define CELL_ASPECT_RATIO 0.666666666667
#define NUM_CARDS 20


- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (UIView *)makeCardView:(Grid *)grid atRow:(int)r atColumn:(int)c
{
    return [[SetCardView alloc] initWithFrame:[grid frameOfCellAtRow:r inColumn:c]];
}

- (void)setGridProperties:(Grid *)grid withWindow:(UIView *)window
{
    grid.size = CGSizeMake(window.bounds.size.width,window.bounds.size.height);
    grid.cellAspectRatio = CELL_ASPECT_RATIO;
    grid.minimumNumberOfCells = NUM_CARDS;
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
    /*
    SetCard *setCardView = (SetCard *)cardView;
    if(setCardView.lastState != card.isChosen) {
        [UIView transitionWithView:playingCardView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            if (card.isChosen) {
                                playingCardView.faceUp = true;
                            }else{
                                playingCardView.faceUp = false;
                            }
                        }
                        completion:nil];
    }
    playingCardView.lastState = card.isChosen;
     */
}

- (void)setGameMode:(CardMatchingGame *)game
{
    game.gameMode = SET_CARD_GAME;
}



@end
