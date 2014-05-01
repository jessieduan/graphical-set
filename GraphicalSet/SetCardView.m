//
//  SetCardView.m
//  GraphicalSet
//
//  Created by Kevin Yang on 4/30/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView


#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0
#define CORNER_LINE_SPACING_REDUCTION 0.05

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    

    //[self drawSquiggle];
    //---------trial shape----------//
    /*
    CGRect shapeRect = CGRectMake(self.bounds.origin.x+5, self.bounds.origin.y+10, self.bounds.size.width-10, self.bounds.size.height-70);
    UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:200.0];
    [[UIColor purpleColor] setFill];
    [oval fill];
     */
    
    //------squiggle---------//
    //UIBezierPath *squiggle = [[UIBezierPath alloc] init];
        //path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
    //[squiggle addQuadCurveToPoint:CGPointMake(self.bounds.origin.x+30, self.bounds.origin.y) controlPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y)];

    


    
    //squiggle.lineJoinStyle = kCGLineJoinRound;

    //[squiggle addArcWithCenter:CGPointMake(self.bounds.origin.x+20, self.bounds.origin.y+20) radius:50.0 startAngle:0 endAngle:M_PI/3 clockwise:YES];
    //[squiggle addArcWithCenter:CGPointMake(self.bounds.origin.x+30, self.bounds.origin.y+40) radius:50.0 startAngle:0 endAngle:M_PI/3 clockwise:NO];

    

}

- (void)drawSymbols
{
    if (self.number==1) {
        //drawSymbolAtPoint;
    }else if(self.number==2){
        //drawSymbolAtPoint;
        //drawSymbolAtPoint;
    }else{
        //drawSymbolAtPoint;
        //drawSymbolAtPoint;
        //drawSymbolAtPoint;
    }
}

- (void)drawSymbolsAtPoint:(CGPoint)point
{
    if (self.symbol==1) {
        //drawDiamondAtPoint
    }else if(self.symbol==2){
        //drawSquiggleAtPoint
    }else{
        //drawOvalAtPoint
    }
}

//- (void)

#define STARTING_X_FACTOR 0.1
- (void)drawSquiggleAtPoint:(CGPoint)point
{
    UIBezierPath *squiggle = [[UIBezierPath alloc] init];
    int currWidth = 70;
    int currHeight = 100;
    NSLog(@"Bounds Height: %f", self.bounds.size.height);
    NSLog(@"Bounds Width: %f", self.bounds.size.width);
    
    [squiggle moveToPoint:CGPointMake(self.bounds.origin.x+(STARTING_X_FACTOR * self.bounds.size.width), self.bounds.origin.y+(30 * self.bounds.size.height / currHeight))];
    [squiggle addCurveToPoint:CGPointMake(self.bounds.origin.x+(50 * self.bounds.size.width / currWidth), self.bounds.origin.y+(30 * self.bounds.size.height / currHeight)) controlPoint1:CGPointMake(self.bounds.origin.x+(25 * self.bounds.size.width / currWidth), self.bounds.origin.y+(15 * self.bounds.size.height / currHeight)) controlPoint2:CGPointMake(self.bounds.origin.x+(35 * self.bounds.size.width / currWidth), self.bounds.origin.y+(35 * self.bounds.size.height / currHeight))];
    [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.origin.x+(60 * self.bounds.size.width / currWidth), self.bounds.origin.y+(50 * self.bounds.size.height / currHeight)) controlPoint:CGPointMake(self.bounds.origin.x+(80 * self.bounds.size.width / currWidth), self.bounds.origin.y+(22 * self.bounds.size.height / currHeight))];
    [squiggle addCurveToPoint:CGPointMake(self.bounds.origin.x+(20 * self.bounds.size.width / currWidth), self.bounds.origin.y+(50 * self.bounds.size.height / currHeight)) controlPoint1:CGPointMake(self.bounds.origin.x+(45 * self.bounds.size.width / currWidth), self.bounds.origin.y+(55 * self.bounds.size.height / currHeight)) controlPoint2:CGPointMake(self.bounds.origin.x+(35 * self.bounds.size.width / currWidth), self.bounds.origin.y+(35 * self.bounds.size.height / currHeight))];
    [squiggle addQuadCurveToPoint:CGPointMake(self.bounds.origin.x+(10 * self.bounds.size.width / currWidth), self.bounds.origin.y+(30 * self.bounds.size.height / currHeight)) controlPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y+(60 * self.bounds.size.height / currHeight))];
    [[UIColor purpleColor] setFill];
    [squiggle fill];
}

/*
#define SQUIGGLE_WIDTH 0.12
#define SQUIGGLE_HEIGHT 0.3
#define SQUIGGLE_FACTOR 0.8
#define SYMBOL_LINE_WIDTH 0.02;
- (void)drawSquiggleAtPoint:(CGPoint)point;
{
    CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2;
    CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2;
    CGFloat dsqx = dx * SQUIGGLE_FACTOR;
    CGFloat dsqy = dy * SQUIGGLE_FACTOR;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
    [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
                 controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
    [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
            controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
            controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
    [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
                 controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
    [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
            controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
            controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
    path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
    //[self shadePath:path];
    [path stroke];
}
 */

#pragma mark Properties


- (void)setShading:(int)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setSymbol:(int)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setColor:(int)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setNumber:(int)number
{
    _number = number;
    [self setNeedsDisplay];
}

#pragma mark Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

@end
