//
//  VisitedTile+CoreDataProperties.h
//  SeekNYC
//
//  Created by Justine Gartner on 11/30/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VisitedTile.h"

NS_ASSUME_NONNULL_BEGIN

@interface VisitedTile (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *columnRow;
@property (nullable, nonatomic, retain) NSNumber *coordinateTopLeftLatitude;
@property (nullable, nonatomic, retain) NSNumber *coordinateTopRightLatitude;
@property (nullable, nonatomic, retain) NSDate *timestamp;
@property (nullable, nonatomic, retain) NSNumber *coordinateTopRightLongitude;
@property (nullable, nonatomic, retain) NSNumber *coordinateBottomRightLatitude;
@property (nullable, nonatomic, retain) NSNumber *coordinateBottomRightLongitude;
@property (nullable, nonatomic, retain) NSNumber *coordinateBottomLeftLatitude;
@property (nullable, nonatomic, retain) NSNumber *coordinateBottomLeftLongitude;
@property (nullable, nonatomic, retain) NSNumber *coordinateTopLeftLongitude;
@property (nullable, nonatomic, retain) NSString *borough;

@end

NS_ASSUME_NONNULL_END
