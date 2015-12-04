//
//  SeekNYCParks.m
//  SeekNYC
//
//  Created by Christella on 11/22/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "SeekNYCParks.h"

@implementation SeekNYCParks

- (instancetype)initWithJSON:(NSDictionary *)venue {
    
    if (self = [super init]) {
        
        // Name
        NSDictionary *items = [venue[@"items"]objectAtIndex:0];
       // NSLog(@"%@", items);
        self.name = items[@"venue"][@"name"];
        NSLog(@"%@", self.name);
      
       // Address
       NSDictionary *address = items[@"venue"][@"location"];
       self.address = [[address objectForKey:@"formattedAddress"]componentsJoinedByString:@" "];
       self.landmarkLat = [[address objectForKey:@"lat"]floatValue];
        self.landmarkLng = [[address objectForKey:@"lng"]floatValue];
//        NSLog(@"%2lf %2lf", self.landmarkLat, self.landmarkLng);
        
        //NSLog(@"%@", self.address);
       // NSLog(@"%@", address);
        
        //Category
        NSArray *venueType = items[@"venue"][@"categories"];
        NSDictionary *category = [venueType objectAtIndex:0];
        self.categoryName = [category objectForKey:@"name"];
        //NSLog(@"%@", self.categoryName);

        
        //the detail
        NSArray *tips = items[@"tips"];
        NSDictionary *theTip = [tips objectAtIndex:0];
        self.detail = [theTip objectForKey:@"text"];
        
        NSLog(@"%@", self.detail);
        
        
        

        
        
        return self;
    }
    return nil;
}

@end
