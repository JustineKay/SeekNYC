//
//  ClearOverlayPolygonRenderer.m
//  SeekNYC
//
//  Created by Justine Gartner on 11/29/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "ClearOverlayPolygonRenderer.h"

@interface ClearOverlayPolygonRenderer () {
    
}

@property (nonatomic, strong) MKPolygon *clearPolygon;

@end

@implementation ClearOverlayPolygonRenderer

-(id)initWithPolygon:(MKPolygon *)polygon {
    
    self = [super initWithOverlay:polygon];
    if (self) {
        
        self.clearPolygon = polygon;
        
    }
    
    return self;
}

@end
