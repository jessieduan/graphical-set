//
//  SetCard.m
//  Matchismo
//
//  Created by Jessie Duan on 4/21/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (instancetype)init {
    self = [super init];
    self.numToMatch = 3;
    return self;
}

- (int)match:(NSArray *)otherCards {
    if ([otherCards count] == 3) {
        if ([SetCard matchesShading:otherCards] && [SetCard matchesSymbols:otherCards] && [SetCard matchesNumbers:otherCards] && [SetCard matchesColors:otherCards]) {
            return 4;
        }
    }
    return 0;
}

+ (BOOL) matchesShading:(NSArray *)otherCards {
    SetCard *firstCard = (SetCard *)[otherCards objectAtIndex:0];
    SetCard *secondCard = (SetCard *)[otherCards objectAtIndex:1];
    SetCard *thirdCard = (SetCard *)[otherCards objectAtIndex:2];
    
    if (firstCard.shading == secondCard.shading && secondCard.shading == thirdCard.shading) return YES;
    if (firstCard.shading != secondCard.shading && secondCard.shading != thirdCard.shading && firstCard.shading != thirdCard.shading) return YES;
    return NO;
}

+ (BOOL) matchesSymbols:(NSArray *)otherCards {
    SetCard *firstCard = (SetCard *)[otherCards objectAtIndex:0];
    SetCard *secondCard = (SetCard *)[otherCards objectAtIndex:1];
    SetCard *thirdCard = (SetCard *)[otherCards objectAtIndex:2];
    
    if ([firstCard.symbol isEqualToString:secondCard.symbol] && [secondCard.symbol isEqualToString:thirdCard.symbol]) return YES;
    if (![firstCard.symbol isEqualToString:secondCard.symbol] && ![secondCard.symbol isEqualToString:thirdCard.symbol] && ![firstCard.symbol isEqualToString:thirdCard.symbol]) return YES;
    return NO;
}

+ (BOOL) matchesNumbers:(NSArray *)otherCards {
    SetCard *firstCard = (SetCard *)[otherCards objectAtIndex:0];
    SetCard *secondCard = (SetCard *)[otherCards objectAtIndex:1];
    SetCard *thirdCard = (SetCard *)[otherCards objectAtIndex:2];
    
    if (firstCard.number == secondCard.number && secondCard.number == thirdCard.number) return YES;
    if (firstCard.number != secondCard.number && secondCard.number != thirdCard.number && firstCard.number != thirdCard.number) return YES;
    return NO;
}

+ (BOOL) matchesColors:(NSArray *)otherCards {
    SetCard *firstCard = (SetCard *)[otherCards objectAtIndex:0];
    SetCard *secondCard = (SetCard *)[otherCards objectAtIndex:1];
    SetCard *thirdCard = (SetCard *)[otherCards objectAtIndex:2];
    
    if (firstCard.color == secondCard.color && secondCard.color == thirdCard.color) return YES;
    if (firstCard.color != secondCard.color && secondCard.color != thirdCard.color && firstCard.color != thirdCard.color) return YES;
    return NO;
}

- (NSString *)contents {
    return nil;
}

+ (NSArray *)validSymbols {
    return @[@"●", @"◼︎", @"▴"];
}

+ (NSUInteger)maxNumber {
    return 3;
}

+ (NSUInteger)maxColor {
    return 3;
}

+ (NSArray *)validShadings {
    return @[[NSNumber numberWithFloat:0.1], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:0.75]];
}

@end
