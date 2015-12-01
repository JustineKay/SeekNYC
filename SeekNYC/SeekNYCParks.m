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
        
    
        self.name = venue[@"name"];
        self.address =[venue[@"location"][@"formattedAddress"] componentsJoinedByString:@" "];

        NSDictionary *venueType = [venue[@"categories"]objectAtIndex:0];
        
        self.categoryName = [venueType objectForKey:@"name"];
        
        self.landmarkLat = [venue[@"location"][@"lat"]floatValue];
        self.landmarkLng = [venue[@"location"][@"lng"]floatValue];

        return self;
    }
    return nil;
}

@end
