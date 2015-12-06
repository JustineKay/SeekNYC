//
//  BootstrapData.m
//  SeekNYC
//
//  Created by Justine Gartner on 12/5/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "BootstrapData.h"
#import <CoreLocation/CoreLocation.h>

@implementation BootstrapData

+ (NSArray *)data {
    return @[
             [self manhattanData],
             [self bronxData],
             [self brooklynData]
             ];
}

+ (NSArray *)manhattanData {
    
    NSArray *mLats = @[
                       @(40.73308),
                       @(40.73408),
                       @(40.73508),
                       @(40.73608),
                       @(40.73708),
                       @(40.73808),
                       @(40.73908),
                       @(40.74008),
                       @(40.74108),
                       @(40.74208),
                       @(40.74308),
                       @(40.74408)];
    
    NSArray *mLngs = @[
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401),
                       @(-73.989401)];
    
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < mLngs.count; i++) {
        double lat = [mLats[i] doubleValue];
        double lng = [mLngs[i] doubleValue];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        [arr addObject:location];
        
    }
    return arr;
}

+ (NSArray *)brooklynData {
    
    NSArray *bkLat = @[
                       @(40.720852),
                       @(40.721852),
                       @(40.722852),
                       @(40.723852),
                       @(40.724852),
                       @(40.725852),
                       @(40.726852),
                       @(40.727852),
                       @(40.728852),
                       @(40.729852),
                       @(40.730852),
                       @(40.731852),
                       @(40.732852),
                       @(40.733852),
                       @(40.734852)];
    
    NSArray *bkLng = @[
                       @(-73.952322), 
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322),
                       @(-73.952322)];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < bkLng.count; i++) {
        double lat = [bkLat[i] doubleValue];
        double lng = [bkLng[i] doubleValue];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        [arr addObject:location];
    }
    return arr;
}

+ (NSArray *)bronxData {
    
    NSArray *bxLats = @[
                       @(40.820045),
                       @(40.821045),
                       @(40.822045),
                       @(40.823045),
                       @(40.824045),
                       @(40.825045),
                       @(40.826045),
                       @(40.827045),
                       @(40.828045),
                       @(40.829045),
                       @(40.830045),
                       @(40.831045),
                       @(40.832045),
                       @(40.833045),
                       @(40.834045),
                       @(40.835045),
                       @(40.836045),
                       @(40.837045),
                       @(40.838045),
                       @(40.839045),
                       @(40.840045),
                       @(40.841045),
                       @(40.842044),
                       @(40.843044),
                       @(40.844044),
                       @(40.845044),
                       @(40.846044),
                       @(40.847044),
                       @(40.848044),
                       @(40.849044),
                       @(40.850044),
                       @(40.851044),
                       @(40.852044),
                       @(40.853044),
                       @(40.854044),
                       @(40.855044),
                       @(40.856044),
                       @(40.857044),
                       @(40.858044),
                       @(40.859044),
                       @(40.860044),
                       @(40.861044),
                       @(40.862044),
                       @(40.863044)];
    
    NSArray *bxLngs = @[
                        @(-73.897991), 
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991),
                        @(-73.897991)];
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < bxLngs.count; i++) {
        double lat = [bxLats[i] doubleValue];
        double lng = [bxLngs[i] doubleValue];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        [arr addObject:location];
        
    }
    return arr;
}

@end
