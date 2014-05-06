//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jessie Duan on 4/3/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UITextField *statusLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"historySegue"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *historyController = segue.destinationViewController;
            historyController.game = self.game;
        }
    }
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (IBAction)resetButton:(UIButton *)sender {
    [self.game resetWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
}

- (Deck *)createDeck {
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (NSAttributedString *)getStatusFromCards:(NSArray *)matchedCards score:(int)score {
    if (!matchedCards) return [[NSAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *status = [[NSMutableAttributedString alloc] init];
    for (Card *card in matchedCards) {
        [status appendAttributedString:[self titleForCard:card]];
    }
    NSString *statusEnd = [NSString stringWithFormat:@" matched for %d points", score];
    NSAttributedString *statusEndAttr = [[NSAttributedString alloc] initWithString:statusEnd];
    [status appendAttributedString:statusEndAttr];
    return status;
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    [self.statusLabel setAttributedText:[self getStatusFromCards:self.game.matchedCards score:[[self.game.historyPoints lastObject] intValue]]];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return nil;
}

@end
