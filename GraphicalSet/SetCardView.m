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

#define STRIPES_OFFSET 0.20
#define SYMBOL_LINE_WIDTH 0.10
- (void)symbolShading:(UIBezierPath *)symbol
{
    if (self.shading == 1){
        [[UIColor clearColor] setFill];
    }else if (self.shading == 2){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        //UIColor *color = [self symbolColor];
        [symbol addClip];
        
        UIBezierPath *stripes = [[UIBezierPath alloc] init];
        CGPoint start = symbol.bounds.origin;
        CGPoint end = start;
        CGFloat change = symbol.bounds.size.height * STRIPES_OFFSET;
        end.x += symbol.bounds.size.width;
        start.y += change;
        
        for(int i=0.1; i<[self symbolHeight]; i=i+0.1*[self symbolHeight]){
            [stripes moveToPoint:start];
            [stripes addLineToPoint:end];
            start.y += change;
            end.y += change;
        }
        stripes.lineWidth = (symbol.bounds.size.width/2) * SYMBOL_LINE_WIDTH;
        [stripes stroke];
        
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
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
    
    [squiggle moveToPoint:CGPointMake(point.x+[self symbolWidth]*0.15, point.y+[self symbolHeight]*0.25)];
    [squiggle addQuadCurveToPoint:CGPointMake(point.x+[self symbolWidth]*0.05, point.y-[self symbolHeight]*0.65)
                     controlPoint:CGPointMake(point.x-[self symbolWidth]*0.30, point.y+[self symbolHeight]*0.25)];
    [squiggle addCurveToPoint:CGPointMake(point.x+[self symbolWidth]*0.75, point.y-[self symbolHeight]*0.8)
                controlPoint1:CGPointMake(point.x+[self symbolWidth]*0.50, point.y-[self symbolHeight])
                controlPoint2:CGPointMake(point.x+[self symbolWidth]*0.10, point.y+[self symbolHeight]*0.2)];
    [squiggle addQuadCurveToPoint:CGPointMake(point.x+[self symbolWidth]*0.9, point.y+[self symbolHeight]*0.2)
                     controlPoint:CGPointMake(point.x+[self symbolWidth]*1.30, point.y-[self symbolHeight])];
    [squiggle addCurveToPoint:CGPointMake(point.x+[self symbolWidth]*0.15, point.y+[self symbolHeight]*0.25)
                controlPoint1:CGPointMake(point.x+[self symbolWidth]*0.35, point.y-[self symbolHeight]*0.6)
                controlPoint2:CGPointMake(point.x+[self symbolWidth]*0.15, point.y+[self symbolHeight]*0.6)];
    //
    //[squiggle addCurveToPoint:CGPointMake(point.x+(20 * self.bounds.size.width / currWidth), point.y+(50 * self.bounds.size.height / currHeight)) controlPoint1:CGPointMake(point.x+(45 * self.bounds.size.width / currWidth), point.y+(55 * self.bounds.size.height / currHeight)) controlPoint2:CGPointMake(point.x+(35 * self.bounds.size.width / currWidth), point.y+(35 * self.bounds.size.height / currHeight))];
    //[squiggle addQuadCurveToPoint:CGPointMake(point.x+(10 * self.bounds.size.width / currWidth), point.y+(30 * self.bounds.size.height / currHeight)) controlPoint:CGPointMake(point.x, point.y+(60 * self.bounds.size.height / currHeight))];
    
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
