//
//  UserProfileView.h
//  SeekNYC
//
//  Created by Justine Gartner on 11/21/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressBar.h"
#import "UserProfileViewController.h"
#import "NYCMapViewController.h"

@interface UserProfileView : UIView

@property (weak, nonatomic) IBOutlet CircleProgressBar *nycCircleProgressBar;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic) CGFloat percentage;

@end
