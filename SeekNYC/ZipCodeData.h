//
//  ZipCodeData.h
//  ZipCodes
//
//  Created by Justine Gartner on 11/27/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipCode.h"

@interface ZipCodeData : NSObject

@property (nonatomic) NSMutableArray *allZipCodes;

-(void) initializeData;

@end
