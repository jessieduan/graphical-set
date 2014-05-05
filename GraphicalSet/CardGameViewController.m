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


@interface CardGameViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *window;
@property (strong, nonatomic) Grid* grid;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UIButton *addCardsButton;
@property (strong, nonatomic) UIDynamicAnimator *animator;
//@property (strong, nonatomic) UISnapBehavior *deckSnap;
@end

@implementation CardGameViewController

/*
- (UISnapBehavior *)deckSnap
{
    _deckSnap = [[UISnapBehavior alloc] initWithItem:self.window snapToPoint:CGPointMake(self.window.bounds.size.width/2, self.window.bounds.size.height/2)];
    return _deckSnap;
}
 */
/*
- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        if (self.window) {
            _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.window];
            _animator.delegate = self;
        } else {
            NSLog(@"Tried to create an animator with no reference view.");
        }
    }
    return _animator;
}
 */

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

#define SLOWDOWN_FACTOR 10.0
- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
       (gesture.state == UIGestureRecognizerStateEnded)){
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.window];
        UIDynamicItemBehavior *cardViewItems = [[UIDynamicItemBehavior alloc] initWithItems:self.cardViews];
        //cardViewItems.resistance = SLOWDOWN_FACTOR;
        [self.animator addBehavior:cardViewItems];
        CGPoint center = CGPointMake(self.window.bounds.size.width/2, self.window.bounds.size.height/2);
        for (UIView* cardView in self.cardViews) {
            UISnapBehavior *deckSnap = [[UISnapBehavior alloc] initWithItem:cardView snapToPoint:center];
            [self.animator addBehavior:deckSnap];
        }
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    
    if(self.animator){
        CGPoint gesturePoint = [gesture locationInView:self.view];
        for(UIView *cardView in self.cardViews){
            cardView.center = CGPointMake(gesturePoint.x, gesturePoint.y);
        }
    }
}

- (void)drawCardView:(UIView *)cardView withCard:(Card *)card
{
    //overridden by subclass
}

- (void)setGridProperties:(Grid *)grid withWindow:(UIView *)window numCells:(int) numCells {
    //overridden by subclass
}

- (void)touch:(UITapGestureRecognizer *)gesture
{
    if(!self.animator){
        int cardIndex = (int)[self.cardViews indexOfObject:gesture.view];
        [self setGameMode:self.game];
        [self.game chooseCardAtIndex:cardIndex];
        [self removeMatchedCards];
        [self updateUI];
    }else{
        [UIView animateWithDuration:0.6
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:1
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             [self updateGrid];
                         }
                         completion:nil];
        self.animator = nil;
    }
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

- (void)setGameMode:(CardMatchingGame *)game
{
    //overridden by subclass
}

# define REDEAL_DURATION 1.5
# define NUM_REDEAL_CARDS 12

- (IBAction)redealButton:(UIButton *)sender {
    self.game = nil;
    self.grid = nil;
    [UIView animateWithDuration:REDEAL_DURATION
                     animations:^{
                         for (UIView *view in self.cardViews) {
                             CGRect frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + [view superview].bounds.size.height, view.frame.size.width, view.frame.size.height);
                             view.frame = frame;
                         }

                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             for (UIView *view in self.cardViews) {
                                 [view removeFromSuperview];
                             }
                             [self.cardViews removeAllObjects];
                             
                             [self setGridProperties:self.grid withWindow:self.window];
                             //[self updateGrid]; //sets frame for each view
                             self.game = [[CardMatchingGame alloc] initWithCardCount:NUM_REDEAL_CARDS usingDeck:[self createDeck]];
                             [self addCardViewsWithCount:NUM_REDEAL_CARDS];
                         }

                     }];

    self.addCardsButton.alpha = 1.0;
    self.addCardsButton.enabled = YES;
    self.animator = nil;
}




# define NUM_CARDS_TO_ADD 3

- (IBAction)addCards:(UIButton *)sender {
    int numCardsAdded = [self.game addCardsWithCount:NUM_CARDS_TO_ADD];
    [self addCardViewsWithCount:numCardsAdded];
    [self setGridMinCells];
    //[self updateGrid];
    [self updateUI];
    
    if (![self.game numCardsLeft]) {
        self.addCardsButton.alpha = 0.2;
        self.addCardsButton.enabled = NO;
    }
    
    
    [UIView animateWithDuration:0.6
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:1
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [self updateGrid];
                     }
                     completion:nil];
    self.animator = nil;
    NSLog(@"sup");
}

# define ADD_DURATION 0.5

- (void)addCardViewsWithCount:(int)count {
    for(int i = 0; i < count; i++) {
        UIView *cardView = [self makeCardView];
        
        
        [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch:)]];
        
        [self.window addSubview:cardView];
        [self.cardViews addObject:cardView];
    }
    [UIView animateWithDuration:ADD_DURATION
                     animations:^{
                         [self updateGrid];
                         [self updateUI];
                     }
                     completion:nil];
}

- (void)updateUI
{
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"WIDTH: %f", self.window.bounds.size.width);
    NSLog(@"WIDTH: %f", self.window.bounds.size.height);
    [self setGridProperties:self.grid withWindow:self.window numCells:[self.game numCardsInPlay]];
    [self updateUI];
    //[super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
}

- (void)setGridMinCells {
    self.grid.minimumNumberOfCells = [self.game numCardsInPlay];
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
    //overridden by subclass
}

- (void)animateCardView:(UIView *)cardView withCard:(Card *)card
{
    //overridden by subclass
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeCardViews];
    [self.window addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)]];
    [self.window addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    [self updateUI];
    
    [self.window.superview setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self.window.superview setAutoresizesSubviews:YES];
}


- (void)initializeCardViews
{
    [self.cardViews removeAllObjects];
    for(int r=0; r<self.grid.rowCount; r++){
        for(int c=0; c<self.grid.columnCount; c++){
            if ((r * self.grid.rowCount + c) >= self.grid.minimumNumberOfCells) return;
            //start from 0,0
            //then set new location
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

- (UIView *)makeCardView {
    return nil;
}


@end


