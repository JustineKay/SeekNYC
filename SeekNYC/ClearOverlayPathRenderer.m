//
//  ClearOverlayPathRenderer.m
//  MoonRunner
//
//  Created by Justine Kay 🙏🏼 on 11/12/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ClearOverlayPathRenderer.h"

@interface ClearOverlayPathRenderer () {
    CGMutablePathRef _mutablePath;
}

@property (nonatomic, strong) MKPolyline *polyline;

@end

@implementation ClearOverlayPathRenderer

-(id)initWithPolyline:(MKPolyline *)polyline{
    
    self = [super initWithOverlay:polyline];
    if (self) {
        self.polyline    = polyline;
        _mutablePath = CGPathCreateMutable();
        [self constructPath];
        
        // defaults
        self.backgroundColor  = [UIColor blackColor];
    }
    return self;

}

- (void)dealloc
{
    CGPathRelease(_mutablePath);
    _mutablePath = NULL;
}

- (void)constructPath
{
    // turn the polyline into a path
    BOOL pathIsEmpty = YES;
    
    for (int i = 0; i < self.polyline.pointCount; i++) {
        CGPoint point = [self pointForMapPoint:self.polyline.points[i]];
        
        if (pathIsEmpty) {
            CGPathMoveToPoint(_mutablePath, nil, point.x, point.y);
            pathIsEmpty = NO;
        } else {
            CGPathAddLineToPoint(_mutablePath, nil, point.x, point.y);
        }
    }
}

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)context
{
    CGFloat baseWidth = self.lineWidth / zoomScale;
    
     //nice for debugging
      //CGContextSetRGBFillColor(context, (0.0 / 255.0), (0.0 / 255.0), (0.0 / 255.0), 1.0);
      //CGContextFillRect(context, [self rectForMapRect:mapRect]);
    
    // a black background. Might Not need this...
    [self drawLine:self.backgroundColor.CGColor
             width:baseWidth
       allowDashes:NO
      forZoomScale:zoomScale
         inContext:context];
    
    // draw the actual line.
    [self drawLine:self.strokeColor.CGColor
             width:baseWidth
       allowDashes:NO
      forZoomScale:zoomScale
         inContext:context];
    
}

#pragma mark - Private helpers

- (void)drawLine:(CGColorRef)color
           width:(CGFloat)width
     allowDashes:(BOOL)allowDashes
    forZoomScale:(MKZoomScale)zoomScale
       inContext:(CGContextRef)context
{
    CGContextAddPath(context, _mutablePath);
    
    // now set the colour and width
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, width);
    //CGContextSetLineWidth(context, 5.0 * zoomScale);
    
    
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    
    CGContextStrokePath(context);
    CGContextFillPath(context);
}



@end
