//
//  UIColor+BlendMode.m
//  UIColorBlendModeExample
//
//  Created by Jarod Luebbert on 8/1/13.
//  Copyright (c) 2013 Elepath. All rights reserved.
//

#import "UIColor+BlendMode.h"

@implementation UIColor (BlendMode)

- (UIColor *)colorWithColor:(UIColor *)color andBlendMode:(CGBlendMode)blendMode
{
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, self.CGColor);
    CGContextFillRect(ctx, rect);
    CGContextSetBlendMode(ctx, blendMode);
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self colorAtPosition:CGPointMake(0, 0) inImage:image];
}

// Source: https://gist.github.com/mindbrix/894665
- (UIColor *)colorAtPosition:(CGPoint)position inImage:(UIImage *)image
{
    CGRect sourceRect = CGRectMake(position.x, position.y, 1.0f, 1.0f);
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, sourceRect);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *buffer = malloc(4);
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    CGContextRef context = CGBitmapContextCreate(buffer, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0.f, 0.f, 1.0f, 1.0f), imageRef);
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGFloat r = buffer[0] / 255.0f;
    CGFloat g = buffer[1] / 255.0f;
    CGFloat b = buffer[2] / 255.0f;
    CGFloat a = buffer[3] / 255.0f;
    free(buffer);
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
