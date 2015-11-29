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
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    //CGContextFillRect(context, [self rectForMapRect: mapRect]);
    
}

@end
