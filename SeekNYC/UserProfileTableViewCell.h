//
//  UserProfileTableViewCell.h
//  SeekNYC
//
//  Created by Christella on 11/14/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressBar.h"
#import "UserProfileViewController.h"
#import "NYCMapViewController.h"

@interface UserProfileTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UIView *redBkgdUserAvatarView;


@property (weak, nonatomic) IBOutlet CircleProgressBar *nycCircleProgressBar;

@property (nonatomic) CGFloat percentage;




@end
