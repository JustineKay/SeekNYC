//
//  Path.h
//  SeekNYC
//
//  Created by Justine Kay 🙏🏼 on 11/13/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Path : NSManagedObject

-(NSArray *)locationsAsCLLocation;

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Path+CoreDataProperties.h"
