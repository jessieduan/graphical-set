//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Jessie Duan on 4/3/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (NSAttributedString *)titleForCard:(Card *)card;
- (NSAttributedString *)getStatusFromCards:(NSArray *)matchedCards score:(int)score;
@end
