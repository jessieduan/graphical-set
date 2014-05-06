//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Jessie Duan on 4/21/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    PlayingCard *playingCard = (PlayingCard *)card;
    if (!card.isChosen) return [[NSAttributedString alloc] initWithString:@""];
    if ([playingCard.suit isEqualToString:@"♥︎"] || [playingCard.suit isEqualToString:@"♦︎"]) {
        return [[NSAttributedString alloc] initWithString:playingCard.contents attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
    }
    return [[NSAttributedString alloc] initWithString:playingCard.contents];
}

@end
