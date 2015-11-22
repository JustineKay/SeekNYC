//
//  NYCMapViewController.h
//  TrueLocalNYC
//
//  Created by Christella on 11/12/15.
//  Copyright © 2015 Christella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface NYCMapViewController : UIViewController
<RNFrostedSidebarDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
