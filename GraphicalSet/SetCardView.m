//
//  SetCardView.m
//  GraphicalSet
//
//  Created by Kevin Yang on 4/30/14.
//  Copyright (c) 2014 Kevin Yang. All rights reserved.
//

#import "SetCardView.h"


@interface SetCardView()
@end

@implementation SetCardView


#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0
#define CORNER_LINE_SPACING_REDUCTION 0.05

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

#define SYMBOL_WIDTH_SCALE_FACTOR 0.7
#define SYMBOL_HEIGHT_SCALE_FACTOR 0.23
#define OVAL_RADIUS 100.0

- (CGFloat)symbolWidth { return self.bounds.size.width * SYMBOL_WIDTH_SCALE_FACTOR; }
- (CGFloat)symbolHeight { return self.bounds.size.height * SYMBOL_HEIGHT_SCALE_FACTOR; }
- (CGFloat)symbolX { return self.bounds.origin.x + (self.bounds.size.width*((1.0 - SYMBOL_WIDTH_SCALE_FACTOR)/2.0)); }
//- (CGFloat)symbolY:(int)position { return self.bounds.origin.y + (self.bounds.size.height * (1.0/6.0) * position ); }
- (CGFloat)symbolY:(int)position { return self.bounds.origin.y + self.bounds.size.height * (1.0/8.0)+ (self.bounds.size.height * (1.0/8.0) * position ); }

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    //[[UIColor whiteColor] setFill];
    //UIRectFill(self.bounds);
    
    if(self.chosen){
        [[UIColor orangeColor] setFill];
        UIRectFill(self.bounds);
    }else{
        [[UIColor whiteColor] setFill];
        UIRectFill(self.bounds);
    }
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self drawSymbols];
    
    
}

- (UIColor *)symbolColor
{
    if (self.color == 1){
        return [UIColor redColor];
    }else if (self.color == 2){
        return [UIColor greenColor];
    }else{
        return [UIColor purpleColor];
    }
}

- (void)symbolShading:(UIBezierPath *)symbol
{
    if (self.shading == 1){
        [[UIColor clearColor] setFill];
    }else if (self.shading == 2){                //TO DO -> REPLACE WITH STRIPES!!!
        UIColor *color = [self symbolColor];
        color = [color colorWithAlphaComponent:0.3];
        [color setFill];
        [symbol fill];
    }else{
        [[self symbolColor] setFill];
        [symbol fill];
    }
}

- (void)drawSymbols
{
    [[self symbolColor] setStroke];
    if (self.number==1) {
        [self drawSymbolsAtPoint:CGPointMake([self symbolX], [self symbolY:3])];
    }else if(self.number==2){
        [self drawSymbolsAtPoint:CGPointMake([self symbolX], [self symbolY:2])];
        [self drawSymbolsAtPoint:CGPointMake([self symbolX], [self symbolY:4])];
    }else{
        [self drawSymbolsAtPoint:CGPointMake([self symbolX], [self symbolY:1])];
        [self drawSymbolsAtPoint:CGPointMake([self symbolX], [self symbolY:3])];
        [self drawSymbolsAtPoint:CGPointMake([self symbolX], [self symbolY:5])];
    }
}

- (void)drawSymbolsAtPoint:(CGPoint)point
{
    if (self.symbol==1) {
        [self drawDiamondAtPoint:point];
    }else if(self.symbol==2){
        [self drawSquiggleAtPoint:point];
    }else{
        [self drawOvalAtPoint:point];
    }
    
}

- (void)drawOvalAtPoint: (CGPoint)point
{
    CGRect frame = CGRectMake(point.x, point.y - (self.bounds.size.height * 0.12), [self symbolWidth], [self symbolHeight]);
    UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:OVAL_RADIUS];
    
    [self symbolShading:oval];
    [oval stroke];
}

- (void)drawDiamondAtPoint: (CGPoint)point
{
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    
    [diamond moveToPoint:point];
    [diamond addLineToPoint:CGPointMake(point.x + [self symbolWidth]/2,
                                        point.y - [self symbolHeight]/2)];
    [diamond addLineToPoint:CGPointMake(point.x + [self symbolWidth],
                                        point.y)];
    [diamond addLineToPoint:CGPointMake(point.x + [self symbolWidth]/2,
                                        point.y + [self symbolHeight]/2)];
    [diamond addLineToPoint:point];
    
    [self symbolShading:diamond];
    [diamond stroke];

}

- (void)drawSquiggleAtPoint:(CGPoint)point
{
    UIBezierPath *squiggle = [[UIBezierPath alloc] init];
    int currWidth = 70;
    int currHeight = 100;
    
    [squiggle moveToPoint:point];
    [squiggle addCurveToPoint:CGPointMake(point.x+(50 * self.bounds.size.width / currWidth), point.y+(30 * self.bounds.size.height / currHeight)) controlPoint1:CGPointMake(point.x+(25 * self.bounds.size.width / currWidth), point.y+(15 * self.bounds.size.height / currHeight)) controlPoint2:CGPointMake(point.x+(35 * self.bounds.size.width / currWidth), point.y+(35 * self.bounds.size.height / currHeight))];
    [squiggle addQuadCurveToPoint:CGPointMake(point.x+(60 * self.bounds.size.width / currWidth),point.y+(50 * self.bounds.size.height / currHeight)) controlPoint:CGPointMake(point.x+(80 * self.bounds.size.width / currWidth), point.y+(22 * self.bounds.size.height / currHeight))];
    [squiggle addCurveToPoint:CGPointMake(point.x+(20 * self.bounds.size.width / currWidth), point.y+(50 * self.bounds.size.height / currHeight)) controlPoint1:CGPointMake(point.x+(45 * self.bounds.size.width / currWidth), point.y+(55 * self.bounds.size.height / currHeight)) controlPoint2:CGPointMake(point.x+(35 * self.bounds.size.width / currWidth), point.y+(35 * self.bounds.size.height / currHeight))];
    [squiggle addQuadCurveToPoint:CGPointMake(point.x+(10 * self.bounds.size.width / currWidth), point.y+(30 * self.bounds.size.height / currHeight)) controlPoint:CGPointMake(point.x, point.y+(60 * self.bounds.size.height / currHeight))];
    
    [self symbolShading:squiggle];
    [squiggle stroke];
}


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
