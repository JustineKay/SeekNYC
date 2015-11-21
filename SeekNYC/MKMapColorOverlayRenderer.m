//
//  MKMapColorOverlayRenderer.m
//
//  Created by Justine Kay 🙏🏼 on 11/8/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "MKMapColorOverlayRenderer.h"

@implementation MKMapColorOverlayRenderer



- (instancetype)initWithOverlay:(id <MKOverlay>)overlay {
    self = [super initWithOverlay:overlay];
    if (self != nil) {
        self.overlayAlpha = 0.2;
        self.overlayColor = [UIColor grayColor];
    }
    return self;
}

- (BOOL)canDrawMapRect:(MKMapRect)mapRect
             zoomScale:(MKZoomScale)zoomScale {
    return true;
}

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)ctx {
    CGContextSetAlpha(ctx, self.overlayAlpha);
    CGContextSetFillColorWithColor(ctx, self.overlayColor.CGColor);
    CGContextFillRect(ctx, [self rectForMapRect:MKMapRectWorld]);
}


@end
