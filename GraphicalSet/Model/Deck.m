//
//  Deck.m
//  Matchismo2
//
//  Created by Kevin Yang on 4/3/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (nonatomic, strong) NSMutableArray *cards;
@end

//@synthesize cards = _cards happens behind the scenes

@implementation Deck

- (NSMutableArray *)cards   //lazy instantiation
{
    if(!_cards)_cards = [[NSMutableArray alloc] init];  //bec _cards is nil to begin with
    return _cards;
}

-(void)addCard: (Card*)card atTop:(BOOL)atTop
{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }else{
        [self.cards addObject:card];
    }
}

-(void)addCard: (Card *)card;
{
    [self addCard:card atTop:NO];
}


-(Card *)drawRandomCard;
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
