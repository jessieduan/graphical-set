//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Jessie Duan on 4/22/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "SetCardGameViewController.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"grayfront" : @"cardfront"];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    SetCard *setCard = (SetCard *)card;
    NSString *str = [[NSString alloc] init];
    for (NSUInteger i = 0; i < setCard.number; i++) {
        str = [str stringByAppendingString:setCard.symbol];
    }
    
    //NSString *str = [@"" stringByPaddingToLength:setCard.number withString:setCard.symbol startingAtIndex:0];

    
    //UIColor *innerColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    //NSLog([NSString stringWithFormat:@"%d", setCard.color]);
    UIColor *innerColor = [UIColor colorWithRed:(CGFloat)(setCard.color == 0 ? 1.0 : 0.0) green:(CGFloat)(setCard.color == 1 ? 1.0 : 0.0) blue:(CGFloat)(setCard.color == 2 ? 1.0 : 0.0) alpha:[setCard.shading floatValue]];
    UIColor *outerColor = [innerColor colorWithAlphaComponent:1.0];
    NSDictionary *attrsDictionary = @{NSForegroundColorAttributeName: innerColor,
                                      NSStrokeWidthAttributeName: @-5,
                                      NSStrokeColorAttributeName: outerColor };
    
    return [[NSAttributedString alloc] initWithString:str attributes:attrsDictionary];
}

@end
