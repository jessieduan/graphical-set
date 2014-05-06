//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Jessie Duan on 4/22/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "HistoryViewController.h"
#import "CardGameViewController.h"
#import "SetCardGameViewController.h"
#import "PlayingCardGameViewController.h"
#import "SetCard.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyDisplay;

@end

@implementation HistoryViewController

- (void)setGame:(CardMatchingGame *)game {
    _game = game;
    [self historyDisplay].attributedText = [self getHistory];
}

- (NSAttributedString *)getHistory {
    NSMutableAttributedString *history = [[NSMutableAttributedString alloc] init];
    for (NSUInteger i = 0; i < [self.game.historyCards count]; i++) {
        [history appendAttributedString:[[[CardGameViewController alloc] init] getStatusFromCards:[self.game.historyCards objectAtIndex:i] score:[[self.game.historyPoints objectAtIndex:i] intValue]]];
    }
    return history;
}

@end
