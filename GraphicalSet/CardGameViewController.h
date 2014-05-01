//
//  GraphicalSetViewController.h
//  GraphicalSet
//
//  Created by Kevin Yang on 4/27/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "Grid.h"

@interface CardGameViewController : UIViewController
- (Deck *)createDeck;
- (void)drawCardView:(UIView *)cardView withCard:(Card *)card;
- (void)animateCardView:(UIView *)cardView withCard:(Card *)card;
- (void)setGameMode:(CardMatchingGame *)game;
- (void)setGridProperties:(Grid *)grid withWindow:(UIView *)window;
- (UIView *)makeCardView:(Grid *)grid atRow:(int)r atColumn:(int)c;

@end
