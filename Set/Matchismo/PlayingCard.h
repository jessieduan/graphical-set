//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jessie Duan on 4/3/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
+ (BOOL)isSuitMatchfirst:(PlayingCard *)card1 second:(PlayingCard *)card2;
+ (BOOL)isRankMatchfirst:(PlayingCard *)card1 second:(PlayingCard *)card2;
- (NSString *)cardArrayToString:(NSArray *)cardArray;

@end
