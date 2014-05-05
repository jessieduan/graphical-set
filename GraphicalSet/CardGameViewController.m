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
#import "SetCard.h" //to remove after debugging


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
    if (!_grid) {
        _grid = [[Grid alloc] init];
        [self setGridProperties:_grid withWindow:self.window];
    }
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
    [self removeMatchedCards];
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

# define NUM_CARDS_TO_ADD 3

- (IBAction)addCards:(id)sender {
    [self.game addCardsWithCount:NUM_CARDS_TO_ADD];
    [self addCardViewsWithCount:NUM_CARDS_TO_ADD];
    [self createGrid];
    [self updateGrid];
    [self updateUI];
}

- (void)addCardViewsWithCount:(int)count {
    for(int i = 0; i < [self.game.addedCards count]; i++) {
        int row = i / self.grid.rowCount;
        int col = i % self.grid.rowCount;
        UIView *cardView = [self makeCardView:self.grid atRow:row atColumn:col];
        
        [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch:)]];
        
        [self.window addSubview:cardView];
        [self.cardViews addObject:cardView];
    }
}

- (void)updateUI
{
    for (UIView *cardView in self.cardViews) {
        cardView.alpha = 1;
        int cardIndex = (int)[self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *cardInArr = (SetCard *)self.game.cards[cardIndex];
            NSLog(@"cards: %d", cardInArr.symbol);
            
            NSLog(@"being drawn: %d", ((SetCard *)card).symbol);
        }
        
        [self drawCardView:cardView withCard:card];
        [self animateCardView:cardView withCard:card];

        if (card.isMatched) cardView.alpha = 0.2;  //if cards are matched, make transparent
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

//duplicate to method within setcardviewcontroller
- (void)createGrid {
//    self.grid.size = CGSizeMake(self.window.bounds.size.width,self.window.bounds.size.height);
//    self.grid.cellAspectRatio = .666666666667;
    self.grid.minimumNumberOfCells = [self.game.cards count];
}

- (void)updateGrid
{
    for (int i = 0; i < [self.cardViews count]; i++) {
        UIView *view = self.cardViews[i];
        
        int row = i / self.grid.rowCount;
        int col = i % self.grid.rowCount;
        
        CGRect frame = [self.grid frameOfCellAtRow:row inColumn:col];
        view.frame = frame;
        
    }
}

#define REMOVE_DURATION 1.5

- (void)removeMatchedCards {
    if (![self.game.removedCards count]) {
        return;
    }
    NSMutableArray *viewsToRemove = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.game.removedCards count]; i++) {
        int viewIndex = [self.game.removedCardIndices[i] intValue];
        
        UIView *cardView = [self.cardViews objectAtIndex:viewIndex];
        [viewsToRemove addObject:cardView];
    }
    NSMutableArray *oldFrames = [[NSMutableArray alloc] init];
    [UIView animateWithDuration:REMOVE_DURATION
                     animations:^{
                         for (UIView *view in viewsToRemove) {
                             [oldFrames addObject:[NSValue valueWithCGRect:view.frame]];
                             CGRect frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + [view superview].bounds.size.height, view.frame.size.width, view.frame.size.height);
                             view.frame = frame;
                         }
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             for (int i = 0; i < [self.game.removedCards count]; i++) {
                                 UIView *view = [self.cardViews lastObject];
                                 [view removeFromSuperview];
                                 [self.cardViews removeObject:view];
                             }
                             [self updateGrid];
                             [self updateUI];
                             [self.game.removedCards removeAllObjects];
                             [self.game.removedCardIndices removeAllObjects];
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
            //if ([self.game.cards count] && (r * self.grid.rowCount + c >= [self.game.cards count])) return;
            UIView *cardView = [self makeCardView:self.grid atRow:r atColumn:c];
            
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


