//
//  UserProfileViewController.m
//  TrueLocalNYC
//
//  Created by Christella on 11/12/15.
//  Copyright © 2015 Christella. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileView.h"
#import "AppDelegate.h"
#import "VisitedTile+CoreDataProperties.h"
#import "VisitedTile.h"

static double const tileSizeInMeters = 100.0;
static double const NYCMeters = 785000000;
static double const BKMeters = 183000000;
static double const BRXMeters = 109000000;
static double const MANMeters = 59000000;
static double const QNSMeters = 283000000;
static double const SIMeters = 151000000;

@interface UserProfileViewController ()
<
NSFetchedResultsControllerDelegate
>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic) NSArray *fetchedTiles;

@property (nonatomic) NSInteger BKTiles;
@property (nonatomic) NSInteger BRXTiles;
@property (nonatomic) NSInteger MANTiles;
@property (nonatomic) NSInteger QNSTiles;
@property (nonatomic) NSInteger SITiles;


@end

@implementation UserProfileViewController

- (NSManagedObjectContext *)managedObjectContext {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self setVisitedTiles];
    [self setUserProgress];
    [self loadProgressView];
    
}

- (void)loadView {
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"UserProfileView" owner:self options:nil] firstObject];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [((UserProfileView *)self.view).backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
 
}


- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setVisitedTiles {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"VisitedTile"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    fetchRequest.sortDescriptors = @[sort];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    if (self.fetchedResultsController.fetchedObjects != nil) {
        
        if (!self.fetchedTiles) {
            self.fetchedTiles = [[NSArray alloc] init];
        }
        
        self.fetchedTiles = self.fetchedResultsController.fetchedObjects;
        
    }
    
    
}

- (void)loadProgressView {
    UserProfileView *view = (UserProfileView *)self.view;
    view.percentageNYC = self.progressNYC;
    view.percentageBK = self.progressBK;
    view.percentageMAN = self.progressMAN;
    view.percentageQNS = self.progressQNS;
    view.percentageBRX = self.progressBRX;
    view.percentageSI = self.progressSI;
    
    UIFont *boroughFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
    UIFont *nycFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:25.0];
    
    [view.nycCircleProgressBar setHintTextFont:nycFont];
    [view.nycCircleProgressBar setProgressBarWidth:20];
    
    [view.BKCircleProgressBar setHintTextFont:boroughFont];
    [view.BKCircleProgressBar setProgressBarWidth:12.0];
    [view.MANCircleProgressBar setHintTextFont:boroughFont];
    [view.MANCircleProgressBar setProgressBarWidth:12.0];
    [view.QNSCircleProgressBar setHintTextFont:boroughFont];
    [view.QNSCircleProgressBar setProgressBarWidth:12.0];
    [view.BRXCircleProgressBar setHintTextFont:boroughFont];
    [view.BRXCircleProgressBar setProgressBarWidth:12.0];
    [view.SICircleProgressBar setHintTextFont:boroughFont];
    [view.SICircleProgressBar setProgressBarWidth:12.0];
    
    [view.nycCircleProgressBar setProgress:view.percentageNYC animated:YES];
    [view.BKCircleProgressBar setProgress:view.percentageBK animated:YES];
    [view.MANCircleProgressBar setProgress:view.percentageMAN animated:YES];
    [view.QNSCircleProgressBar setProgress:view.percentageQNS animated:YES];
    [view.BRXCircleProgressBar setProgress:view.percentageBRX animated:YES];
    [view.SICircleProgressBar setProgress:view.percentageSI animated:YES];
}


-(void)setUserProgress {
    
    if (self.fetchedTiles != nil) {
        
        self.progressNYC = [self percentageOfAreaUncovered:self.fetchedTiles.count With:NYCMeters];
        
        for (VisitedTile *tile in self.fetchedTiles) {
            
            [self getNumberOfBoroughsWith:tile.borough];
            
        }
        
        self.progressBK = [self percentageOfAreaUncovered:self.BKTiles With:BKMeters];
        self.progressBRX = [self percentageOfAreaUncovered:self.BRXTiles With:BRXMeters];
        self.progressMAN = [self percentageOfAreaUncovered:self.MANTiles With:MANMeters];
        self.progressQNS = [self percentageOfAreaUncovered:self.QNSTiles With:QNSMeters];
        self.progressSI = [self percentageOfAreaUncovered:self.SITiles With:SIMeters];
    }
}

-(void)getNumberOfBoroughsWith: (NSString *)tileBorough {
    
    if ([tileBorough isEqualToString:@"Brooklyn"]) {
        
        self.BKTiles += 1;
        
    }else if ([tileBorough isEqualToString:@"Manhattan"]) {
        
        self.MANTiles += 1;
        
    }else if ([tileBorough isEqualToString:@"Bronx"]) {
        
        self.BRXTiles += 1;
        
    }else if ([tileBorough isEqualToString:@"Queens"]) {
        
        self.QNSTiles += 1;
        
    }else if ([tileBorough isEqualToString:@"Staten Island"]) {
        
        self.SITiles += 1;
        
    }
    
    
}

#pragma mark - Percentage Calculations


-(CGFloat)percentageOfAreaUncovered: (NSInteger)numberOfTiles With: (NSInteger)areaMeters {
    
    CGFloat userMeters = numberOfTiles * tileSizeInMeters;
    CGFloat percentageUncovered = userMeters / areaMeters;
    
    return percentageUncovered;
}



@end
