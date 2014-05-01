//
//  SetCard.h
//  Matchismo
//
//  Created by Kevin Yang on 4/17/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

                                    //all are expressed as 1,2, or 3
@property (nonatomic) int symbol;   //diamond, squiggle, oval
@property (nonatomic) int number;   //1,2,3
@property (nonatomic) int shading;  //alpha: 0,0.5,1
@property (nonatomic) int color;    //green, red, or purple

+(NSUInteger) maxNumber;

@end
