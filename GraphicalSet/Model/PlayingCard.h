//
//  PlayingCard.h
//  Matchismo2
//
//  Created by Kevin Yang on 4/3/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank; //NSUInteger is a 64 bit integer on an iPhone 5, but 32 bit in the iPhone4

+(NSArray *)validSuits;
+ (NSUInteger)maxRank;


@end
