//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jessie Duan on 4/3/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (instancetype)init {
    self = [super init];
    self.numToMatch = 2;
    return self;
}

+ (BOOL)isSuitMatchfirst:(PlayingCard *)card1 second:(PlayingCard *)card2 {
    return [card1.suit isEqualToString:card2.suit];
}

+ (BOOL)isRankMatchfirst:(PlayingCard *)card1 second:(PlayingCard *)card2 {
    return card1.rank == card2.rank;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    if ([otherCards count] == 2) {
        id card = [otherCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = [otherCards firstObject];
            if ([PlayingCard isRankMatchfirst:self second:otherCard]) score = 4;
            else if ([PlayingCard isSuitMatchfirst:self second:otherCard]) score = 1;
        }
    }
    return score;
}

- (NSString *)cardArrayToString:(NSArray *)cardArray {
    NSString *result = [[NSString alloc] initWithString:[self contents]];
    for (id elem in cardArray) {
        if ([elem isKindOfClass:[PlayingCard class]]) {
            PlayingCard *card = (PlayingCard *)elem;
            result = [result stringByAppendingString:[card contents]];
            
        }
    }
    return result;
}

- (NSString *)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSArray *)validSuits {
    return @[@"♠︎",@"♥︎",@"♣︎",@"♦︎"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

@end
