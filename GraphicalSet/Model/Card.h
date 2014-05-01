//
//  Card.h
//  Matchismo2
//
//  Created by Kevin Yang on 4/3/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
