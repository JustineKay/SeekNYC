//
//  Path+CoreDataProperties.h
//  SeekNYC
//
//  Created by Justine Gartner on 11/30/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Path.h"
#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Path (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *distance;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSDate *timestamp;
@property (nullable, nonatomic, retain) NSOrderedSet<Location *> *locations;

@end

@interface Path (CoreDataGeneratedAccessors)

- (void)insertObject:(Location *)value inLocationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLocationsAtIndex:(NSUInteger)idx;
- (void)insertLocations:(NSArray<Location *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLocationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLocationsAtIndex:(NSUInteger)idx withObject:(Location *)value;
- (void)replaceLocationsAtIndexes:(NSIndexSet *)indexes withLocations:(NSArray<Location *> *)values;
- (void)addLocationsObject:(Location *)value;
- (void)removeLocationsObject:(Location *)value;
- (void)addLocations:(NSOrderedSet<Location *> *)values;
- (void)removeLocations:(NSOrderedSet<Location *> *)values;

@end

NS_ASSUME_NONNULL_END
