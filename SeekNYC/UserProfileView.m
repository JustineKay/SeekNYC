//
//  UserProfileView.m
//  SeekNYC
//
//  Created by Justine Gartner on 11/21/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "UserProfileView.h"

@implementation UserProfileView

- (void)setPercentageNYC:(CGFloat)percentageNYC {
    
    if (percentageNYC) {
        NSLog(@"%f", percentageNYC);
        _percentageNYC = percentageNYC;
        
    }else {
        
        _percentageNYC = 0.00;
    }
    
    
    NSLog(@"percentageNYC: %2f", self.percentageNYC);
}

- (void)setPercentageBK:(CGFloat)percentageBK {
    
    if (percentageBK) {
        NSLog(@"%f", percentageBK);
        _percentageBK = percentageBK;
        
    }else {
        
        _percentageBK = 0.00;
    }
    
    
    NSLog(@"percentageBK: %2f", self.percentageBK);
}

- (void)setPercentageMAN:(CGFloat)percentageMAN {
    
    if (percentageMAN) {
        NSLog(@"%f", percentageMAN);
        _percentageMAN = percentageMAN;
        
    }else {
        
        _percentageMAN = 0.00;
    }
    
    
    NSLog(@"percentageMAN: %2f", self.percentageMAN);
}

- (void)setPercentageBRX:(CGFloat)percentageBRX{
    
    if (percentageBRX) {
        NSLog(@"%f", percentageBRX);
        _percentageBRX = percentageBRX;
        
    }else {
        
        _percentageBRX = 0.00;
    }
    
    
    NSLog(@"percentageBRX: %2f", self.percentageBRX);
}

- (void)setPercentageQNS:(CGFloat)percentageQNS {
    
    if (percentageQNS) {
        NSLog(@"%f", percentageQNS);
        _percentageQNS = percentageQNS;
        
    }else {
        
        _percentageQNS = 0.00;
    }
    
    
    NSLog(@"percentageQNS: %2f", self.percentageQNS);
}

- (void)setPercentageSI:(CGFloat)percentageSI {
    
    if (percentageSI) {
        NSLog(@"%f", percentageSI);
        _percentageSI = percentageSI;
        
    }else {
        
        _percentageSI = 0.00;
    }
    
    
    NSLog(@"percentageSI: %2f", self.percentageSI);
}

@end
