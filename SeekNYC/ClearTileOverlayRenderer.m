//
//  ClearTileOverlayRenderer.m
//  SeekNYC
//
//  Created by Justine Gartner on 11/29/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ClearTileOverlayRenderer.h"

@implementation ClearTileOverlayRenderer

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay {
    
    self = [super initWithOverlay:overlay];
    if (self != nil) {
        self.overlayColor = [UIColor blackColor];
        self.overlayAlpha = 1.0;
    }
    return self;
}

-(BOOL)canDrawMapRect:(MKMapRect)mapRect
            zoomScale:(MKZoomScale)zoomScale {
    
    return YES;
}

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)context {
    
    
    CGContextSetAlpha(context, self.overlayAlpha);
    CGContextSetFillColorWithColor(context, self.overlayColor.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    //CGContextFillRect(context, [self rectForMapRect: mapRect]);
    CGContextFillPath(context);
    
}


@end
