//
//  SeekNYCParks.m
//  SeekNYC
//
//  Created by Christella on 11/22/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "SeekNYCParks.h"

@implementation SeekNYCParks

- (instancetype)initWithJSON:(NSDictionary *)item {
    
    if (self = [super init]) {
        
        NSDictionary *venue = item[@"venue"];
        NSArray *tips = item[@"tips"];
        
        // Name
        self.name = venue[@"name"];
//        NSLog(@"%@", self.name);
      
       // Address
       NSDictionary *address = venue[@"location"];
       self.address = [[address objectForKey:@"formattedAddress"]componentsJoinedByString:@" "];
       self.landmarkLat = [[address objectForKey:@"lat"]floatValue];
       self.landmarkLng = [[address objectForKey:@"lng"]floatValue];
//        NSLog(@"%2lf %2lf", self.landmarkLat, self.landmarkLng);
        
        //NSLog(@"%@", self.address);
       // NSLog(@"%@", address);
        
        //Category
        NSArray *venueType = venue[@"categories"];
        NSDictionary *category = [venueType objectAtIndex:0];
        self.categoryName = [category objectForKey:@"name"];
        //NSLog(@"%@", self.categoryName);

        
        //the detail
        if (tips) {
            NSDictionary *theTip = [tips objectAtIndex:0];
            self.detail = [theTip objectForKey:@"text"];
        } else {
            self.detail = @"No tip available";
        }
        
        NSLog(@"%@", self.detail);
        
        //the venue photo
        NSDictionary *getPhoto = [tips objectAtIndex:0];
        NSDictionary *user = getPhoto[@"user"][@"photo"];
        NSString *prefix = user[@"prefix"];
        NSString *suffix = user[@"suffix"];
        
        NSLog(@"%@ %@",prefix,suffix);
                
        return self;
    }
    return nil;
}

@end
