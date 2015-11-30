//
//  ClearOverlayPolygonRenderer.m
//  SeekNYC
//
//  Created by Justine Gartner on 11/29/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ClearOverlayPolygonRenderer.h"

@interface ClearOverlayPolygonRenderer ()

@property (nonatomic, strong) MKPolygon *clearPolygon;

@end

@implementation ClearOverlayPolygonRenderer


- (void)fillPath:(CGPathRef)path inContext:(CGContextRef)context {
    
    CGContextAddPath(context, path);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextDrawPath(context, kCGPathFillStroke);

}

@end
