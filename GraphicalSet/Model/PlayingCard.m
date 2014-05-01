//
//  PlayingCard.m
//  Matchismo2
//
//  Created by Kevin Yang on 4/3/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit; //because we provide the setter AND getter


/* METHOD: match
 * This method calculates the resulting score of the combination of this playing card
 * and an array of other cards.
 */
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] == 1){                                //match this card and 1 other card
        PlayingCard *otherCard = [otherCards firstObject];
        if([self.suit isEqualToString:otherCard.suit]){
            score = 2;                                          //2 pts for suit match
        }else if(self.rank == otherCard.rank){                  //8 pts for rank match
            score = 8;
        }
    }else{                                                      //match this card and 2 other cards
        for (PlayingCard * otherCard in otherCards) {               //match cards: 1&2, 1&3
            if([self.suit isEqualToString:otherCard.suit]){     //1 pt per suit match
                score = score + 1;
            }else if(self.rank == otherCard.rank){              //4 pts per rank match
                score = score + 4;
            }
        }
        PlayingCard *otherCard1 = otherCards[0];                    //match cards: 2&3
        PlayingCard *otherCard2 = otherCards[1];
        if([otherCard1.suit isEqualToString:otherCard2.suit]){
            score = score + 1;
        }else if(otherCard1.rank == otherCard2.rank){
            score = score + 4;
        }
    }
    //for n cards, use a double for loop
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank]                  //take the rank
            stringByAppendingString:self.suit];   //append the suit
}


+ (NSArray *)validSuits
{
    return @[@"♠️",@"♣️",@"♥️",@"♦️"];
}


/*
+ (NSArray *)validSuits
{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}
*/

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit:@"?";
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
