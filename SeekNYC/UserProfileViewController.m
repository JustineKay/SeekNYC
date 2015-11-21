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

- (void)loadView {
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"UserProfileView" owner:self options:nil] firstObject];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    UserProfileView *view = (UserProfileView *)self.view;
    [view.backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"Is it passing %2f?", view.percentage);
 
    view.percentage = self.progress;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
