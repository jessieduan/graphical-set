//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jessie Duan on 4/8/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "PlayingCard.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(int)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)resetWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

@property (nonatomic, readonly) int score;
@property (nonatomic) int numMatch;
@property (nonatomic) NSArray *matchedCards;
@property (nonatomic) NSMutableArray *historyCards;
@property (nonatomic) NSMutableArray *historyPoints;

@end
