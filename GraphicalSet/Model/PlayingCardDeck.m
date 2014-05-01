//
//  PlayingCardDeck.m
//  Matchismo2
//
//  Created by Kevin Yang on 4/3/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@implementation PlayingCardDeck

- (instancetype)init        //(instancetype)  because this inherited NSObject with already returns an NSObject*
{
    self = [super init];    //done so that if any initializer cannot initialize, it will return nil
    
    if(self){
        for(NSString *suit in [PlayingCard validSuits]){
            for(NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *card= [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
