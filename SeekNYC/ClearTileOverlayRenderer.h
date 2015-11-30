//
//  ClearTileOverlayRenderer.h
//  SeekNYC
//
//  Created by Justine Gartner on 11/29/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ClearTileOverlayRenderer : MKOverlayRenderer

/**
 *  Color for the overlay. Default color is 'black'
 */
@property (nonatomic, strong) UIColor *overlayColor;

/**
 *  Overlay opacity. Default is '0.2'
 */
@property (nonatomic) CGFloat overlayAlpha;



@end
