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
        
        
        NSDictionary *venueType = [venue[@"items"]objectAtIndex:0];
        self.name = venueType[@"venue"][@"name"];

        NSDictionary *venueAddress = venueType[@"venue"][@"location"];
        self.address = [[venueAddress objectForKey:@"formattedAddress"] componentsJoinedByString:@" "];
        NSDictionary *parkDetails = [venueType[@"tips"]objectAtIndex:0];
        self.detail = [parkDetails objectForKey:@"text"];
        

        
//        NSLog(@"%@",venueType);
        NSLog(@"%@",self.name);
        NSLog(@"%@",self.address);
        NSLog(@"%@",self.detail);
        
        return self;
    }
    return nil;
}

@end
