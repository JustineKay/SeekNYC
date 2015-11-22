//
//  UIColor+Color.m
//  SeekNYC
//
//  Created by Justine Gartner on 11/22/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

//COLORS
//HotPink: hex# FF0080, rgb(255,0,128)
//NeonGreen: hex# 39FF14, rgb(57,255,20)
//FlorescentYellow: hex# F3F315, rgb(243,243,21)

#import "UIColor+Color.h"

@implementation UIColor (Color)

+ (UIColor *) hotPinkColor {
    
    UIColor *hotPink = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:128.0/255.0 alpha:1];
    
    return hotPink;
}

+ (UIColor *) neonGreenColor {
    
    UIColor *neonGreen = [UIColor colorWithRed:57.0/255.0 green:255.0/255.0 blue:20.0/255.0 alpha:1];
    
    return neonGreen;
}

+ (UIColor *) florescentYellow {
    
    UIColor *floYellow = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:21.0/255.0 alpha:1];
    
    return floYellow;
}

@end
