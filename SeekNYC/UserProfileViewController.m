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
 
    view.percentageNYC = self.progressNYC;
    view.percentageBK = self.progressBK;
    view.percentageMAN = self.progressMAN;
    view.percentageQNS = self.progressQNS;
    view.percentageBRX = self.progressBRX;
    view.percentageSI = self.progressSI;
    
    [view.nycCircleProgressBar setProgress:view.percentageNYC animated:YES];
    [view.BKCircleProgressBar setProgress:view.percentageBK animated:YES];
    [view.MANCircleProgressBar setProgress:view.percentageMAN animated:YES];
    [view.QNSCircleProgressBar setProgress:view.percentageQNS animated:YES];
    [view.BRXCircleProgressBar setProgress:view.percentageBRX animated:YES];
    [view.SICircleProgressBar setProgress:view.percentageSI animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
