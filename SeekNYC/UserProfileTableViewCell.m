//
//  UserProfileTableViewCell.m
//  SeekNYC
//
//  Created by Christella on 11/14/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "UserProfileTableViewCell.h"
#import "UserProfileViewController.h"


@implementation UserProfileTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
  
    
   [self.nycCircleProgressBar setProgress:self.percentage animated:YES]; //in set progress number add
    NSLog(@"Let's see %2f", self.percentage);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
