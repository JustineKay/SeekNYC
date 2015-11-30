//
//  ClearOverlayPolygonRenderer.m
//  SeekNYC
//
//  Created by Justine Gartner on 11/29/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ClearOverlayPolygonRenderer.h"

@interface ClearOverlayPolygonRenderer () {
    
    CGMutablePathRef _mutablePath;
    
}

@property (nonatomic, strong) MKPolygon *clearPolygon;

@end

@implementation ClearOverlayPolygonRenderer

-(id)initWithPolygon:(MKPolygon *)polygon {
    
    self = [super initWithOverlay:polygon];
    if (self) {
        
        self.clearPolygon = polygon;
        
        _mutablePath = CGPathCreateMutable();
        [self pathForPolygon:self.clearPolygon];
        
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

- (CGPathRef)pathForPolygon:(MKPolygon*)aPolygon;
{
    CGMutablePathRef mpr = CGPathCreateMutable();
    
    MKMapPoint *polygonPoints = aPolygon.points;
    size_t nCount = aPolygon.pointCount;
    
    for (int p = 0; p < nCount; p++)
    {
        MKMapPoint mp = polygonPoints[p];
        
        if (p == 0)
            CGPathMoveToPoint(mpr, NULL, mp.x, mp.y);
        else
            CGPathAddLineToPoint(mpr, NULL, mp.x, mp.y);
    }
    
    return mpr; //Keep in memory;
}

//- (void)constructPath
//{
//    // turn the polygon into a path
//    BOOL pathIsEmpty = YES;
//    
//    for (int i = 0; i < self.polygon.pointCount; i++) {
//        CGPoint point = [self pointForMapPoint:self.polygon.points[i]];
//        
//        if (pathIsEmpty) {
//            CGPathMoveToPoint(_mutablePath, nil, point.x, point.y);
//            pathIsEmpty = NO;
//        } else {
//            CGPathAddLineToPoint(_mutablePath, nil, point.x, point.y);
//        }
//    }
//}

//-(BOOL)canDrawMapRect:(MKMapRect)mapRect
//            zoomScale:(MKZoomScale)zoomScale {
//    
//    return YES;
//}

-(void)drawMapRect:(MKMapRect)mapRect
         zoomScale:(MKZoomScale)zoomScale
         inContext:(CGContextRef)context
{
    
    CGPathRef path = [self pathForPolygon:self.clearPolygon];
    if (path)
    {
        [self applyFillPropertiesToContext:context atZoomScale:zoomScale];
        CGContextBeginPath(context);
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathFill);
        [self applyStrokePropertiesToContext:context atZoomScale:zoomScale];
        CGContextBeginPath(context);
        CGContextAddPath(context, path);
        CGContextSetAlpha(context,1.0);
        CGContextStrokePath(context);
    }
    CGPathRelease(path);
    
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextStrokePath(context);
    CGContextFillPath(context);

}


@end
