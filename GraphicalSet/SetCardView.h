//
//  SetCardView.h
//  GraphicalSet
//
//  Created by Kevin Yang on 4/30/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic) int symbol;   //diamond, squiggle, oval
@property (nonatomic) int number;   //1,2,3
@property (nonatomic) int shading;  //alpha: 0,0.5,1
@property (nonatomic) int color;    //green, red, or purple
@property (nonatomic) BOOL selected;
//@property (nonatomic) BOOL lastState;

@end
