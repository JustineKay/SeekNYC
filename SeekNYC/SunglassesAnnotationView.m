//
//  SunglassesAnnotationView.m
//  SeekNYC
//
//  Created by Justine Gartner on 12/2/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "SunglassesAnnotationView.h"

@implementation SunglassesAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    imageView.animationImages = @[[UIImage imageNamed:@"sunglasses_ringsAnimated1"],
                                  [UIImage imageNamed:@"sunglasses_ringsAnimated2"],
                                  [UIImage imageNamed:@"sunglasses_ringsAnimated3"],
                                  [UIImage imageNamed:@"sunglasses_ringsAnimated4"],
                                  [UIImage imageNamed:@"sunglasses_ringsAnimated5"],
                                  [UIImage imageNamed:@"sunglasses_ringsAnimated6"]
                                  ];
    
    imageView.animationDuration = 2.0;
    [imageView startAnimating];
    [self addSubview:imageView];
    
    return self;
}

@end
