//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jessie Duan on 4/8/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)historyPoints {
    if (!_historyPoints) _historyPoints = [[NSMutableArray alloc] init];
    return _historyPoints;
}

- (NSMutableArray *)historyCards {
    if (!_historyCards) _historyCards = [[NSMutableArray alloc] init];
    return _historyCards;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(int)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *chosenCards = [NSMutableArray array];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                }
            }
            [chosenCards addObject:card];
            self.matchedCards = chosenCards;
            if ([chosenCards count] == card.numToMatch) {
                int matchScore = [card match:chosenCards];
                [self.historyPoints addObject:[[NSNumber alloc] initWithInt:matchScore * MATCH_BONUS]];
                [self.historyCards addObject:chosenCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *chosenCard in chosenCards) {
                        chosenCard.matched = YES;
                    }
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *chosenCard in chosenCards) {
                        chosenCard.chosen = NO;
                    }
                }
            }
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
        }
    }
}

- (instancetype)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
    }

    return self;
}

- (void)resetWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    [self.cards removeAllObjects];
    for (int i = 0; i < cardCount; i++) {
        Card *card = [deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
        } else {
            break;
        }
    }
    
    [self.historyCards removeAllObjects];
    [self.historyPoints removeAllObjects];

    self.score = 0;
}

- (instancetype)init {
    return nil;
}

@end
