//
//  GraphicalSetViewController.m
//  GraphicalSet
//
//  Created by Kevin Yang on 4/27/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardView.h"
#import "CardMatchingGame.h"
#import "Grid.h"


@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *window;
@property (strong, nonatomic) Grid* grid;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardViews;
@end

static const int PLAYING_CARD_GAME = 0;

@implementation CardGameViewController

- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [[NSMutableArray alloc] init];
    return _cardViews;
}

- (Grid*)grid
{
    if (!_grid) _grid = [[Grid alloc] init];
    [self setGridProperties:_grid withWindow:self.window];
    return _grid;
}

- (void)setGridProperties:(Grid *)grid withWindow:(UIView *)window
{
    //overridden by subclass
}

- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    return nil;
}

- (void)drawCardView:(UIView *)cardView withCard:(Card *)card
{
    //overridden by subclass
}


- (void)touch:(UITapGestureRecognizer *)gesture
{
    int cardIndex = (int)[self.cardViews indexOfObject:gesture.view];
    [self setGameMode:self.game];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)setGameMode:(CardMatchingGame *)game
{
    //overridden by subclass
}

- (IBAction)redealButton:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
}

- (void)updateUI
{
    if ([self.game.removedCards count]) {
        [self removeCards];
    }
    for (UIView *cardView in self.cardViews) {
        cardView.alpha = 1;
        int cardIndex = (int)[self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [self drawCardView:cardView withCard:card];
        [self animateCardView:cardView withCard:card];
        
        if (card.isMatched) cardView.alpha = 0.2;  //if cards are matched, make transparent
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

#define REMOVE_DURATION 1.5

- (void)removeCards {
    NSMutableArray *viewsToRemove = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.game.removedCards count]; i++) {
        int viewIndex = [self.game.removedCardIndices[i] intValue];
        
        UIView *cardView = [self.cardViews objectAtIndex:viewIndex];
        [viewsToRemove addObject:cardView];
    }
    [UIView animateWithDuration:REMOVE_DURATION
                          delay:0
                        options:0
                     animations:^{
                         for (UIView *view in viewsToRemove) {
                             CGRect frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + [view superview].bounds.size.height, view.frame.size.width, view.frame.size.height);
                             view.frame = frame;
                         }
                     }
                     completion:^(BOOL finished) {
                         for (UIView *view in viewsToRemove) {
                             [view removeFromSuperview];
                         }
                     }];
    
}

- (void)animateCardRemoval:(UIView *)cardView withCard:(Card *)card {
    //overridden
}

- (void)animateCardView:(UIView *)cardView withCard:(Card *)card
{
    //overridden by subclass
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeCardViews];
    [self updateUI];
}

- (void)initializeCardViews
{
    for(int r=0; r<self.grid.rowCount; r++){
        for(int c=0; c<self.grid.columnCount; c++){
            UIView *cardView = [self makeCardView:self.grid atRow:r atColumn:c];
            
            //CGRect rect = [self.grid frameOfCellAtRow:r inColumn:c];
            //NSLog(@"%f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
            [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch:)]];
            
            [self.window addSubview:cardView];
            [self.cardViews addObject:cardView];
        }
    }
}


- (UIView *)makeCardView:(Grid *)grid atRow:(int)r atColumn:(int)c
{
    return nil;
}


@end


