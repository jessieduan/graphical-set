//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Kevin Yang on 4/17/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) BOOL lastState;

//- (void)pinch:(UIPinchGestureRecognizer *)gesture;



@end
