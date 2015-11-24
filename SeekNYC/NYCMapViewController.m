//
//  NYCMapViewController.m
//
//  Created by Christella on 11/12/15.
//  Copyright © 2015 Christella. All rights reserved.
//

//SPAN: (latitudeDelta = 0.55000001339033844, longitudeDelta = 0.72560419568399936)
//Center Coord of Region: (latitude = 40.712699999999984, longitude = -74.005899999999997)

#define TintKey @"TintKey"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NYCMapViewController.h"
#import "Path.h"
#import "Path+CoreDataProperties.h"
#import "Location.h"
#import "Location+CoreDataProperties.h"
#import "ClearOverlayPathRenderer.h"
#import "MKMapColorOverlayRenderer.h"
#import "MKMapFullCoverageOverlay.h"
#import "AppDelegate.h"
#import "UserProfileViewController.h"
#import "NYAlertViewController.h"
#import "RNFrostedSidebar.h"
#import "SuggestedVenuesTableViewController.h"
#import "UIColor+Color.h"
#import "DiamondAnnotationView.h"
#import "UberBlackAnnotationView.h"

static float const metersInMile = 1609.344;
static double const tileSizeInMeters = 40.0;

@interface NYCMapViewController ()
<
CLLocationManagerDelegate,
MKMapViewDelegate,
NSFetchedResultsControllerDelegate
>

@property(nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *profileSettingsButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *zoomToLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *stopTrackingPathButton;

@property (weak, nonatomic) IBOutlet UIButton *trackPathButton;


@property (nonatomic) CLLocationManager *locationManager;

@property (nonatomic) NSMutableArray *locations;
@property (nonatomic) NSArray *userPaths;
@property (nonatomic) float distance;
@property (nonatomic) int seconds;

@property (nonatomic) NSMutableOrderedSet *visitedTiles;
@property (nonatomic) CLLocation *gridOriginPoint;

@property (nonatomic) CGFloat percentageTravelled;

@property (nonatomic) NSTimer *timer;


@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end



@implementation NYCMapViewController

- (NSManagedObjectContext *)managedObjectContext {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    self.trackPathButton.hidden = NO;
    self.stopTrackingPathButton.hidden = YES;
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self loadNYCMap];
    [self loadUserPaths];
}

#pragma mark - UI

- (void)loadNYCMap {
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.showsCompass = NO;
    self.mapView.mapType = MKMapTypeHybrid;
    
    //set mapview to bounds of screen for grid testing
    self.mapView.frame = self.view.bounds;
    
    CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(40.7127, -74.0059);
    
    MKCoordinateSpan spanOfNY = MKCoordinateSpanMake(0.525, 0.525);
    
    MKCoordinateRegion NYRegion = MKCoordinateRegionMake(centerCoord, spanOfNY);
    
    MKMapFullCoverageOverlay *fullOverlay = [[MKMapFullCoverageOverlay alloc] initWithMapView:self.mapView];
    [self.mapView addOverlay: fullOverlay];
    
    [self.mapView setRegion: NYRegion animated: YES];
    
    
    //Testing Grid
    
    CLLocation *location1 = [self topLeftLocationOfGrid:centerCoord And:spanOfNY];
    self.gridOriginPoint = location1;
    
    CLLocation *userLocationTest = [[CLLocation alloc] initWithLatitude:40.71419829 longitude:-74.0062145];
    CLLocation *userLocationTest2 = [[CLLocation alloc] initWithLatitude:40.71482853 longitude:-74.0062896];
    
    NSString *visitedTile1 = [self userLocationInGrid:userLocationTest];
    NSString *visitedTile2 = [self userLocationInGrid:userLocationTest2];
    
    NSLog(@"column, row 1: %@, column, row 2: %@", visitedTile1, visitedTile2);
    
}

- (void)loadUserPaths{
    
    //Create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Path"];
    
    //create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    //set the sort descriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[sort];
    
    //create a fetchedResultsController with a fetchRequest and a managedObjectContext
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    if (self.fetchedResultsController.fetchedObjects != nil) {
        
        NSArray *fetchedPaths = self.fetchedResultsController.fetchedObjects;
        
        for (Path *path in fetchedPaths) {
            
            NSArray *locations = [path locationsAsCLLocation];
            
            MKPolyline *polyline = [self polyLineWithLocations:locations];
            
            [self.mapView addOverlay:polyline];
            
        }
        
    }
}



#pragma mark - Grid Set Up

-(NSString *)userLocationInGrid:(CLLocation *) userLocation{
    
    CLLocation *latDiff = [[CLLocation alloc] initWithLatitude:self.gridOriginPoint.coordinate.latitude longitude:userLocation.coordinate.longitude];
    CLLocation *lngDiff = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:self.gridOriginPoint.coordinate.longitude];
    
    CLLocationDistance latitudinalDistance = [userLocation distanceFromLocation:latDiff];
    CLLocationDistance longitudinalDistance = [userLocation distanceFromLocation:lngDiff];
    
    double rowNumber = latitudinalDistance / tileSizeInMeters;
    double columnNumber = longitudinalDistance / tileSizeInMeters;
    
    NSString *columnRow = [NSString stringWithFormat:@"%.f, %.f", columnNumber, rowNumber];
    
    return  columnRow;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        
//        UberBlackAnnotationView *view = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:@"animated"];
//        if (!view)
//            view = [[UberBlackAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"animated"];
//        view.bounds = CGRectMake(0, 0, 45, 20);
        
        DiamondAnnotationView *view = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:@"animated"];
        if(!view)
            view =[[DiamondAnnotationView alloc ] initWithAnnotation:annotation reuseIdentifier:@"animated"];
        view.bounds = CGRectMake(0, 0, 45, 45);
        
        
        //
        //Animate it like any UIView!
        //
        
        CABasicAnimation *theAnimation;
        
        //within the animation we will adjust the "opacity"
        //value of the layer
        theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        //animation lasts 1 second
        theAnimation.duration=1.0;
        //and it repeats forever
        theAnimation.repeatCount= HUGE_VALF;
        //we want a reverse animation
        theAnimation.autoreverses=YES;
        //justify the opacity as you like (1=fully visible, 0=unvisible)
        theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
        theAnimation.toValue=[NSNumber numberWithFloat:1.0];
        
        //Assign the animation to your UIImage layer and the
        //animation will start immediately
        [view.layer addAnimation:theAnimation forKey:@"animateOpacity"];
        
        return view;
    }
    
    return nil;
}


#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    for (CLLocation *newLocation in locations) {
        
        BOOL isAccurate = newLocation.horizontalAccuracy < 20;
        BOOL isRecent = fabs([newLocation.timestamp timeIntervalSinceNow]) < 2.0;
        
        if (isAccurate && isRecent) {
            
            if (self.locations == nil) {
                
                self.locations = [NSMutableArray array];
            }
            
            [self.locations addObject:newLocation];
            
            BOOL matchingTileFound = NO;
            
            NSString *visitedTile = [self userLocationInGrid:newLocation];
            
            for (int i = 0; i < self.visitedTiles.count; i++) {
                
                if ([visitedTile isEqualToString:self.visitedTiles[i]]) {
                    
                    matchingTileFound = YES;
                    break;
                }
                
            }
            
            if (matchingTileFound == NO) {
                
                [self.visitedTiles addObject:visitedTile];
                
            }
            
            if (self.locations.count > 1) {
                
                NSInteger sourceIndex = self.locations.count - 1;
                NSInteger destinationIndex = self.locations.count - 2;
                
                NSArray *newLocations = @[self.locations[sourceIndex], self.locations[destinationIndex]];
                
                //drop polyline ***************************
                [self.mapView addOverlay:[self polyLineWithLocations:newLocations]];
            }
            
            
        }else {
            
            self.locations = nil;
        }
        
    }
}


- (void)startLocationUpdates {
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    [self.locationManager requestAlwaysAuthorization];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    // Movement threshold for new events.
    self.locationManager.distanceFilter = 10; // meters
    
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Action Buttons


- (IBAction)menuButtonTapped:(UIButton *)sender {
    
    
    NSArray *images = @[
                        [UIImage imageNamed:@"ProgressButtonImage"],
                        [UIImage imageNamed:@"SeekButtonImage"],
                        [UIImage imageNamed:@"TintButtonImage"]
                        ];
    
    NSArray *colors = @[
                        [UIColor hotPinkColor],
                        [UIColor neonGreenColor],
                        [UIColor florescentYellow]
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    
    callout.delegate = self;
    
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %ld",index);
    
    
    if (index == 0) {
        
        //***SEGUE TO PROFILE***
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UserProfileViewController *userProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
        
        userProfileVC.progress = self.percentageTravelled;
        
        [self presentViewController:userProfileVC animated:YES completion:nil];
        
        NSLog(@"self.percentage travelled is stored %2f", userProfileVC.progress);
        
        
        [sidebar dismissAnimated:YES];
        
        
    } else if (index == 1) {
        
        //***SEGUE TO SuggestedVenue***
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
        SuggestedVenuesTableViewController *tableVC = [storyboard instantiateViewControllerWithIdentifier:@"SuggestedVenuesTableViewController"];
        
        [self presentViewController:tableVC animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES];
        
    } else if (index == 2) {
        
        //***TINT***
        //AlertVC for custom tint
        
        [self setCustomTint];
        
        [sidebar dismissAnimated:YES];
        
    };
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}


- (IBAction)zoomToLocationButtonTapped:(UIButton *)sender {
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    [self.locationManager requestAlwaysAuthorization];
    
    if (self.mapView.userTrackingMode == MKUserTrackingModeFollow) {
        CLLocationCoordinate2D location = self.mapView.userLocation.coordinate;
        MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
        MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
        
        [self.mapView setRegion:region animated:YES];
    }
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (IBAction)trackPathButtonTapped:(UIButton *)sender {
    
    self.trackPathButton.hidden = YES;
    self.stopTrackingPathButton.hidden = NO;
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    [self startLocationUpdates];
    
}

- (IBAction)stopTrackingPathButtonTapped:(UIButton *)sender {
    
    [self stopTrackingUserLocation];
    
    self.locations = nil;
}


- (void)stopTrackingUserLocation {
    
    self.stopTrackingPathButton.hidden = YES;
    self.trackPathButton.hidden = NO;
    
    [self.locationManager stopUpdatingLocation];
    
    [self savePath];
}

#pragma mark - Core Data

- (void)savePath {
    
    Path *path = [NSEntityDescription insertNewObjectForEntityForName:@"Path"
                                               inManagedObjectContext:self.managedObjectContext];
    
    path.distance = [NSNumber numberWithFloat:self.distance];
    path.duration = [NSNumber numberWithInt:self.seconds];
    path.timestamp = [NSDate date];
    
    NSMutableArray *locationArray = [NSMutableArray array];
    for (CLLocation *location in self.locations) {
        Location *locationObject = [NSEntityDescription insertNewObjectForEntityForName:@"Location"
                                                                 inManagedObjectContext:self.managedObjectContext];
        
        locationObject.timestamp = location.timestamp;
        locationObject.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
        locationObject.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
        [locationArray addObject:locationObject];
    }
    
    path.locations = [NSOrderedSet orderedSetWithArray:locationArray];
    
    // Save the context.
    NSError *error = nil;
    
    if (![self.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


#pragma mark - Distance Calculations

- (float)distanceInMiles:(float)meters
{
    float unitDivider;
    NSString *unitName;
    
    unitName = @"mi";
    // to get from meters to miles divide by this
    unitDivider = metersInMile;
    
    float distanceInMiles = meters/unitDivider;
    
    return distanceInMiles;
}


-(void)percentageOfNYCUncovered{
    
    float userMeters = self.visitedTiles.count * 40;
    float nycMeters = 785000;
    float metersOfNYCUncovered = userMeters / nycMeters;
    float percentageOfNYCUncovered = metersOfNYCUncovered * 100;
    
    self.percentageTravelled = percentageOfNYCUncovered;
    
    NSLog(@"marker");
}

#pragma mark - Overlay Renderer

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolyline *polyLine = (MKPolyline *)overlay;
        
        ClearOverlayPathRenderer *renderer = [[ClearOverlayPathRenderer alloc] initWithPolyline:polyLine];
        
        renderer.strokeColor = [UIColor blackColor];
        renderer.lineWidth = 18;
        
        return renderer;
        
    } else if([overlay isMemberOfClass:[MKMapFullCoverageOverlay class]]) {
        
        MKMapColorOverlayRenderer *fullOverlayView = [[MKMapColorOverlayRenderer alloc] initWithOverlay:overlay];
        fullOverlayView.overlayAlpha = 0.90;
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:TintKey]) {
            
            NSData *colourData = [[NSUserDefaults standardUserDefaults] objectForKey:TintKey];
            
            UIColor *userColour = [NSKeyedUnarchiver unarchiveObjectWithData:colourData];
            
            fullOverlayView.overlayColor = userColour;
            
            fullOverlayView.overlayAlpha = 0.75;
            
            
        }
        
        return fullOverlayView;
    }
    
    return nil;
}

- (MKPolyline *)polyLineWithLocations: (NSArray <CLLocation *> *)locations {
    
    CLLocationCoordinate2D coords[locations.count];
    
    for (int i = 0; i < locations.count; i++) {
        CLLocation *location = [locations objectAtIndex:i];
        coords[i] = location.coordinate;
    }
    
    return [MKPolyline polylineWithCoordinates:coords count:locations.count];
}


#pragma mark - AlertViewController

-(void)setCustomTint {
    
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    // Set a title and message
    alertViewController.title = NSLocalizedString(@"Tint", nil);
    alertViewController.message = NSLocalizedString(@"Pick a color, Set the vibe.", nil);
    
    // Customize appearance as desired
    
    alertViewController.transitionStyle = NYAlertViewControllerTransitionStyleFade;
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"Viafont" size:19.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"Viafont" size:16.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"Viafont" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"Viafont" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.swipeDismissalGestureEnabled = YES;
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    
    // Add alert actions
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:@"Hot Pink"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              
                                                              alertViewController.alertViewBackgroundColor = [UIColor hotPinkColor];
                                                              
                                                              
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:@"Neon Green"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              
                                                              alertViewController.alertViewBackgroundColor = [UIColor neonGreenColor];
                                                              
                                                          }]];
    
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:@"Florescent Yellow"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              
                                                              alertViewController.alertViewBackgroundColor = [UIColor florescentYellow];
                                                              
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:@"Pavement Gray"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              
                                                              alertViewController.alertViewBackgroundColor = [UIColor grayColor];
                                                              
                                                          }]];
    
    
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Set Tint", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              
                                                              //set the nsUserDefaults for the background view
                                                              UIColor *userColourChoice = alertViewController.alertViewBackgroundColor;
                                                              
                                                              
                                                              NSData *colourData = [NSKeyedArchiver archivedDataWithRootObject:userColourChoice];
                                                              
                                                              
                                                              [[NSUserDefaults standardUserDefaults] setObject:colourData forKey:TintKey];
                                                              
                                                              [self savePath];
                                                              
                                                              NSArray *overlays = self.mapView.overlays;
                                                              [self.mapView removeOverlays:overlays];
                                                              
                                                              
                                                              MKMapFullCoverageOverlay *fullOverlay = [[MKMapFullCoverageOverlay alloc] initWithMapView:self.mapView];
                                                              
                                                              [self.mapView addOverlay: fullOverlay];
                                                              
                                                              [self loadUserPaths];
                                                              
                                                              
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    // Present the alert view controller
    [self presentViewController:alertViewController animated:YES completion:nil];
}


#pragma  mark - Testing Grid

-(CLLocation *)topLeftLocationOfGrid:(CLLocationCoordinate2D)centerCoord And: (MKCoordinateSpan)span {
    
    double latDegreesFromCenter = span.latitudeDelta * 0.5;
    double lngDegreesFromCenter = span.longitudeDelta * 0.5;
    
    //Create topLeft corner of grid
    CLLocationCoordinate2D topLeftCoord = CLLocationCoordinate2DMake(centerCoord.latitude + latDegreesFromCenter, centerCoord.longitude - lngDegreesFromCenter);
    
    CLLocation *topLeftLocation = [[CLLocation alloc] initWithLatitude:topLeftCoord.latitude longitude:topLeftCoord.longitude];
    
    return topLeftLocation;
}

-(void)setGridWith:(CLLocationCoordinate2D)centerCoord And:(MKCoordinateSpan)span {
    
    double latDegreesFromCenter = span.latitudeDelta * 0.5;
    double lngDegreesFromCenter = span.longitudeDelta * 0.5;
    
    //Create outer corners of grid
    CLLocationCoordinate2D loc1TopLeft = CLLocationCoordinate2DMake(centerCoord.latitude + latDegreesFromCenter, centerCoord.longitude - lngDegreesFromCenter);
    CLLocationCoordinate2D loc2TopRight = CLLocationCoordinate2DMake(centerCoord.latitude + latDegreesFromCenter, centerCoord.longitude + lngDegreesFromCenter);
    CLLocationCoordinate2D loc3BottomLeft = CLLocationCoordinate2DMake(centerCoord.latitude - latDegreesFromCenter, centerCoord.longitude - lngDegreesFromCenter);
    CLLocationCoordinate2D loc4BottomRight = CLLocationCoordinate2DMake(centerCoord.latitude - latDegreesFromCenter, centerCoord.longitude + lngDegreesFromCenter);
    
    //Add annotations to map for visual debugging
    [self addAnnotationToMapWith:loc1TopLeft];
    [self addAnnotationToMapWith:loc2TopRight];
    [self addAnnotationToMapWith:loc3BottomLeft];
    [self addAnnotationToMapWith:loc4BottomRight];
    [self addAnnotationToMapWith:centerCoord];
    
    //Set total number of columns and rows for debugging
    
    //Convert CLLocationCoordinate2D to CLLocation
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:loc1TopLeft.latitude longitude:loc1TopLeft.longitude];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:loc2TopRight.latitude longitude:loc2TopRight.longitude];
    CLLocation *location3 = [[CLLocation alloc] initWithLatitude:loc3BottomLeft.latitude longitude:loc3BottomLeft.longitude];
    
    //Find distance in meters between topLeft and topRt, topLf and bottomLft
    CLLocationDistance distanceFromLoc1ToLoc2 = [location1 distanceFromLocation:location2];
    CLLocationDistance distanceFromLoc1ToLoc3 = [location1 distanceFromLocation:location3];
    
    //Divide distance by width of each grid tile in meters
    double numberOfColumns = distanceFromLoc1ToLoc2 / tileSizeInMeters;
    double numberOfRows = distanceFromLoc1ToLoc3 / tileSizeInMeters;
    
    NSLog(@"Columns: %f, Rows: %f", numberOfColumns, numberOfRows);
    
}

-(void)addAnnotationToMapWith:(CLLocationCoordinate2D)coord {
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coord;
    
    [self.mapView addAnnotation:annotation];
}


@end
