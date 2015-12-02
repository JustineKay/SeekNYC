//
//  DiamondPinAnnotationView.m
//  SeekNYC
//
//  Created by Justine Gartner on 12/2/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "DiamondPinAnnotationView.h"

@implementation DiamondPinAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    imageView.animationImages = @[[UIImage imageNamed:@"SuperDiamond1"],
                                  [UIImage imageNamed:@"SuperDiamond2"],
                                  [UIImage imageNamed:@"SuperDiamond3"],
                                  [UIImage imageNamed:@"SuperDiamond4"]
                                  ];
    
    imageView.animationDuration = 0.5;
    [imageView startAnimating];
    [self addSubview:imageView];
    
    return self;
}

@end
