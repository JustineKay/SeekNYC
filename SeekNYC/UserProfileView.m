//
//  UserProfileView.m
//  SeekNYC
//
//  Created by Justine Gartner on 11/21/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "UserProfileView.h"

@implementation UserProfileView

- (void)setPercentage:(CGFloat)percentage {
    
    if (percentage) {
        NSLog(@"%f", percentage);
        _percentage = percentage;
        
    }else {
        
        _percentage = 0.001;
    }
    
    
    [self.nycCircleProgressBar setProgress:self.percentage animated:YES]; //in set progress number add
    NSLog(@"Let's see %2f", self.percentage);
}

@end
