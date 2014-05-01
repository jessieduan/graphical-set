//
//  Card.m
//  Matchismo2
//
//  Created by Kevin Yang on 4/3/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for(Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}


@end
