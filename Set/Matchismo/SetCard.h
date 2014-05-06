//
//  SetCard.h
//  Matchismo
//
//  Created by Jessie Duan on 4/21/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSNumber *shading;

+ (NSArray *)validSymbols;
+ (NSUInteger)maxNumber;
+ (NSUInteger)maxColor;
+ (NSArray *)validShadings;

@end