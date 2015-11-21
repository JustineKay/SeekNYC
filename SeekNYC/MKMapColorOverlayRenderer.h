//
//  MKMapColorOverlayRenderer.h
//
//  Created by Justine Kay 🙏🏼 on 11/8/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapColorOverlayRenderer : MKOverlayRenderer

/**
 *  Color for the overlay. Default color is 'gray'
 */
@property (nonatomic, strong) UIColor *overlayColor;

/**
 *  Overlay opacity. Default is '0.2'
 */
@property (nonatomic) CGFloat overlayAlpha;


@end
