//
//  UIColor+BlendMode.h
//  UIColorBlendModeExample
//
//  Created by Jarod Luebbert on 8/1/13.
//  Copyright (c) 2013 Elepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BlendMode)

- (UIColor *)colorWithColor:(UIColor *)color andBlendMode:(CGBlendMode)blendMode;

@end
