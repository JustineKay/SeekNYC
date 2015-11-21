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
        
        self.percentage = percentage;
    }else {
        
        self.percentage = 0.0;
    }
    
    
    [self.nycCircleProgressBar setProgress:self.percentage animated:YES]; //in set progress number add
    NSLog(@"Let's see %2f", self.percentage);
}

@end
