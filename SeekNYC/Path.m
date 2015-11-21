//
//  Path.m
//  SeekNYC
//
//  Created by Justine Kay 🙏🏼 on 11/13/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "Path.h"
#import "Location.h"
#import <CoreLocation/CoreLocation.h>

@implementation Path

-(NSArray *)locationsAsCLLocation{
    
    NSMutableArray *pathLocations = [[NSMutableArray alloc] init];
    
    for (Location *location in self.locations) {
        
        CLLocationDegrees lat = [location.latitude doubleValue];
        CLLocationDegrees lng = [location.longitude doubleValue];
        CLLocation *loco = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        
        [pathLocations addObject:loco];
    }
    
    return pathLocations;
}

@end
