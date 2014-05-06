//
//  SetCardGameController.m
//  Matchismo
//
//  Created by Jessie Duan on 4/22/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:@"cardfront"];
}

- (NSString *)titleForCard:(Card *)card {
    return @"";
}

@end
