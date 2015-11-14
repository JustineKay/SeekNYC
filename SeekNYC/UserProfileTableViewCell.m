//
//  UserProfileTableViewCell.m
//  SeekNYC
//
//  Created by Felicia Weathers on 11/14/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "UserProfileTableViewCell.h"


@implementation UserProfileTableViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UserProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"UserProfileTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserProfileCell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UserProfileTableViewCell *)cell forRowAtIndexPath:( NSIndexPath *)indexPath {
    
}



//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

// Configure the view for the selected state
//}


@end
