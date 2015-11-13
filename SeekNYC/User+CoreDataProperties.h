//
//  User+CoreDataProperties.h
//  SeekNYC
//
//  Created by Justine Gartner on 11/13/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) Path *path;

@end

NS_ASSUME_NONNULL_END
