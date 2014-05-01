//
//  SetCard.m
//  Matchismo
//
//  Created by Kevin Yang on 4/17/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents {
    return nil;
}

- (int)match:(NSArray *)otherCards  //awards points if there is a proper SET match
{
    NSLog(@"in set match!");
    int score = 0;
    
    SetCard* a = self;
    SetCard* b = otherCards[0];
    SetCard* c = otherCards[1];
    
    if([otherCards count] == 2){
        if ([self matchNum:a.number :b.number :c.number] && [self matchNum:a.symbol :b.symbol :c.symbol] && [self matchNum:a.shading :b.shading :c.shading] && [self matchNum:a.color :b.color :c.color]) {
            score = score + 25;
        }
    }

    return score;
}

- (BOOL)matchNum:(int)a :(int)b :(int)c //for there to be a match, each characteristic must be either all equal or all not equal
{
    if((a == b && b == c) || (a != b && a != c && b != c)){
        return YES;
    }
    return NO;
}


+ (NSUInteger)maxNumber
{
    return 3;
}

@end
