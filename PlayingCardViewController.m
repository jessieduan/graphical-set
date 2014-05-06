//
//  PlayingCardViewController.m
//  GraphicalSet
//
//  Created by Kevin Yang on 4/28/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"
#import "Grid.h"

@interface PlayingCardViewController ()

@end

static const int PLAYING_CARD_GAME = 0;

@implementation PlayingCardViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (UIView *)makeCardView {
    return [[PlayingCardView alloc] init];
}

- (UIView *)makeCardView:(Grid *)grid atRow:(int)r atColumn:(int)c
{
    return [[PlayingCardView alloc] initWithFrame:[grid frameOfCellAtRow:r inColumn:c]];
}

- (void)drawCardView:(UIView *)cardView withCard:(Card *)card
{
    PlayingCardView *playingCardView = (PlayingCardView *)cardView;
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        playingCardView.rank = playingCard.rank;
        playingCardView.suit = playingCard.suit;
    }
}

- (void)animateCardView:(UIView *)cardView withCard:(Card *)card
{
    PlayingCardView *playingCardView = (PlayingCardView *)cardView;
    if(playingCardView.lastState != card.isChosen) {
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
}

- (void)setGameMode:(CardMatchingGame *)game
{
    game.gameMode = PLAYING_CARD_GAME;
}

- (int)defaultNumCards {
    return 20;
}


@end
