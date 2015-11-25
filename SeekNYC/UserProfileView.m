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
    
    //Change to percentage uncovered?
    //CGFloat percentageUncovered = 100 - percentage;
    
    if (percentage) {
        NSLog(@"%f", percentage);
        _percentage = percentage;
        
    }else {
        
        _percentage = 0.01;
    }
    
    
    NSLog(@"Let's see %2f", self.percentage);
}

@end
