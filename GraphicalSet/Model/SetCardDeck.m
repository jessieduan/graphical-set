//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Kevin Yang on 4/17/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if(self){
        for(int symbol = 1; symbol <= [SetCard maxNumber]; symbol++){
            for (int number = 1; number <= [SetCard maxNumber]; number++) {
                for (int shading = 1; shading <= [SetCard maxNumber]; shading++) {
                    for(int color = 1; color <= [SetCard maxNumber]; color++){
                        SetCard *card= [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.number = number;
                        card.shading = shading;
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
