//
//  UberBlackAnnotationView.m
//  SeekNYC
//
//  Created by Justine Gartner on 11/22/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "UberBlackAnnotationView.h"

@implementation UberBlackAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    imageView.animationImages = @[[UIImage imageNamed:@"UberBLACK1"],
                                  [UIImage imageNamed:@"UberBLACK2"],
                                  [UIImage imageNamed:@"UberBLACK3"],
                                  [UIImage imageNamed:@"UberBLACK4"],
                                  [UIImage imageNamed:@"UberBLACK5"]
                                  ];
    
    imageView.animationDuration = 0.5;
    [imageView startAnimating];
    [self addSubview:imageView];
    
    return self;
}

@end
