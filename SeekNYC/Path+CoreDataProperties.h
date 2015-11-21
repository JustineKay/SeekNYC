//
//  Path+CoreDataProperties.h
//  SeekNYC
//
//  Created by Justine Kay 🙏🏼 on 11/13/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Path.h"

NS_ASSUME_NONNULL_BEGIN

@interface Path (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *distance;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSDate *timestamp;
@property (nullable, nonatomic, retain) NSManagedObject *user;
@property (nullable, nonatomic, retain) NSOrderedSet<NSManagedObject *> *locations;

@end

@interface Path (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inLocationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLocationsAtIndex:(NSUInteger)idx;
- (void)insertLocations:(NSArray<NSManagedObject *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLocationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLocationsAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceLocationsAtIndexes:(NSIndexSet *)indexes withLocations:(NSArray<NSManagedObject *> *)values;
- (void)addLocationsObject:(NSManagedObject *)value;
- (void)removeLocationsObject:(NSManagedObject *)value;
- (void)addLocations:(NSOrderedSet<NSManagedObject *> *)values;
- (void)removeLocations:(NSOrderedSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
