//
//  VenueDetailViewController.h
//  SeekNYC
//
//  Created by Christella on 12/5/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) NSString *placeName;

@end
