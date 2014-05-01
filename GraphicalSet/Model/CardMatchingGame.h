//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Kevin Yang on 4/8/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSMutableArray *recentCardFlips;
@property (nonatomic) NSInteger addedPoints;
@property (nonatomic) NSInteger gameMode;

@end
