//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kevin Yang on 4/8/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;   //of Card
@property (nonatomic, strong) Deck *deck;
@end

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 2;
static const int COST_TO_CHOOSE = 1;
static const int TWO_CARD_MATCH_MODE = 0;
static const int TWO_OTHER_CARDS = 2;

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


- (NSMutableArray *)recentCardFlips
{
    if (!_recentCardFlips) _recentCardFlips = [[NSMutableArray alloc] init];
    return _recentCardFlips;
}


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    self.deck = deck;
    
    if(self){
        for (int i=0; i<count; i++) {
            Card *card = [self.deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil ;
}



/* METHOD: chooseCardAtIndex
 * This method is the heart of the program. It decides the state of cards depending on if
 * it matches or does not match in a specific game mode. It also updates the state of the
 * recentCardFlips array.
 */
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (![self.recentCardFlips containsObject:card]) {  //if the card is not in the recentCardFlips array
        [self.recentCardFlips addObject:card];          //add recent card flip to recentCardFlips array
    }else{                                              //else, remove it
        [self.recentCardFlips removeObject:card];
    }

    if (!card.isMatched) {
        if (card.chosen) {
            card.chosen = NO;
        }else{
            if(self.gameMode==TWO_CARD_MATCH_MODE){     //attempt to match 2 cards (Matchismo)
                [self matchAttemptTwoCards: card];
            }else{                                      //attempt to match 3 cards (Set)
                [self matchAttemptThreeCards: card];
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

/* METHOD: matchAttemptTwoCards
 * This method updates the state of cards and the game in the 2-card-match-mode.
 */
- (void)matchAttemptTwoCards: (Card *)card
{
    for (Card *otherCard in self.cards) {
        if(otherCard.isChosen && !otherCard.isMatched){
            int matchScore = [card match:@[otherCard]];
            if (matchScore) {
                self.addedPoints = matchScore * MATCH_BONUS;    //x2 multiplier for bonus
                self.score += matchScore * MATCH_BONUS;
                card.matched = YES;
                otherCard.matched = YES;
            }else{
                self.addedPoints = MISMATCH_PENALTY;
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
            }
            break;
        }
    }
}

/* METHOD: matchAttemptThreeCards
 * This method updates the state of cards and the game in the 3-card-match-mode.
 */
- (void)matchAttemptThreeCards: (Card *)card
{
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {                   //collect all cards to be matched
        if(otherCard.isChosen && !otherCard.isMatched){
            [otherCards addObject:otherCard];
        }
    }
    
    if ([otherCards count]==TWO_OTHER_CARDS) {              //if the card can be matched with 2 other cards (thus 3 cards)
        int matchScore = [card match:otherCards];           //calculate the match score
        Card *otherCard1 = otherCards[0];
        Card *otherCard2 = otherCards[1];
        if (matchScore) {                                   //if there is a match
            self.addedPoints = matchScore * MATCH_BONUS;    //update addedPoints (plus pts * bonus) and game score
            self.score += matchScore * MATCH_BONUS;
//            card.matched = YES;                             //set all 3 cards as matched
//            otherCard1.matched = YES;
//            otherCard2.matched = YES;
            
            [self replaceCard:card];
            [self replaceCard:otherCard1];
            [self replaceCard:otherCard2];
        }else{                                              //else
            self.addedPoints = MISMATCH_PENALTY;            //update addedPoints (penalty) and game score
            self.score -= MISMATCH_PENALTY;
            otherCard1.chosen = NO;                         //unchoose other 2 cards
            otherCard2.chosen = NO;
        }
    }
}

- (void)replaceCard:(Card *)toReplace {
    for (int i = 0; i < [self.cards count]; i++) {
        if ([self.cards[i] isEqual:toReplace]) {
            self.cards[i] = [self.deck drawRandomCard];
            break;
        }
    }
    NSLog(@"ERROR AHHHH CARD NOT FOUND");
}

- (void)printCards:(NSMutableArray *)cards
{
    for (id card in cards) {
        Card *playingCard = card;
        NSLog(@"%@", [playingCard contents]);
    }
}


- (instancetype)init
{
    return nil;
}


@end
