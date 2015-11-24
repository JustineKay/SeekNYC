//
//  SeekNYCParks.h
//  SeekNYC
//
//  Created by Christella on 11/22/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeekNYCParks : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *categoryName;


- (instancetype)initWithJSON:(NSDictionary *)json;

@end
