//
//  UserProfileViewController.m
//  TrueLocalNYC
//
//  Created by Christella on 11/12/15.
//  Copyright © 2015 Christella. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileView.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    UserProfileView *profileView = [[[NSBundle mainBundle] loadNibNamed:@"UserProfileView" owner:self options:nil] firstObject];
    
    NSLog(@"Is it passing %2f?", profileView.percentage);
    
    
    profileView.percentage = self.progress;
    
    //self.view.frame.size.height
}

@end
