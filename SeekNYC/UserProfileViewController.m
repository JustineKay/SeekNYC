//
//  UserProfileViewController.m
//  TrueLocalNYC
//
//  Created by Christella on 11/12/15.
//  Copyright © 2015 Christella. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileTableViewCell.h"

@interface UserProfileViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    // grab the nib from the main bundle
    UINib *nib = [UINib nibWithNibName:@"UserProfileTableViewCell" bundle:nil];
    
    // register the nib for the cell identifer
    [self.tableView registerNib:nib forCellReuseIdentifier:@"UserProfileCellIdentifier"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCellIdentifier" forIndexPath:indexPath];
    
    cell.percentage = self.progress;
    
    cell.redBkgdUserAvatarView.layer.cornerRadius = 50.5;
    cell.redBkgdUserAvatarView.clipsToBounds = YES;
    
    cell.redBkgdUserAvatarView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.redBkgdUserAvatarView.layer.borderWidth = 5;
    
    NSLog(@"Is it passing %2f?", cell.percentage);
    
    return cell;
}

@end
