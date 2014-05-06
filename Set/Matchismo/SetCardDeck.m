//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Jessie Duan on 4/22/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSNumber *shading in [SetCard validShadings]) {
                for (NSUInteger color = 0; color < [SetCard maxColor]; color++) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.shading = shading;
                        card.number = number;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end