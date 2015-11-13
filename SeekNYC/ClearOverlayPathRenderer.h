//
//  ClearOverlayPathRenderer.h
//  MoonRunner
//
//  Created by Justine Kay 🙏🏼 on 11/12/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ClearOverlayPathRenderer : MKOverlayPathRenderer

@property (nonatomic, strong) UIColor *backgroundColor;

-(id)initWithPolyline:(MKPolyline *)polyline;

-(MKPolyline *)polyline;

@end
