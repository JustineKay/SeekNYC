//
//  NYCMapViewController.m
//
//  Created by Christella on 11/12/15.
//  Copyright © 2015 Christella. All rights reserved.
//

//SPAN: (latitudeDelta = 0.55000001339033844, longitudeDelta = 0.72560419568399936)
//Center Coord of Region: (latitude = 40.712699999999984, longitude = -74.005899999999997)

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NYCMapViewController.h"
#import "Path.h"
#import "Path+CoreDataProperties.h"
#import "Location.h"
#import "Location+CoreDataProperties.h"
#import "ClearOverlayPathRenderer.h"
#import "MKMapGrayOverlayRenderer.h"
#import "MKMapFullCoverageOverlay.h"
#import "AppDelegate.h"
#import "UserProfileTableViewCell.h"
#import "UserProfileViewController.h"

static bool const isMetric = NO;
static float const metersInKM = 1000;
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


@property (nonatomic) NSTimer *timer;

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
    
//    MKMapFullCoverageOverlay *fullOverlay = [[MKMapFullCoverageOverlay alloc] initWithMapView:self.mapView];
//    [self.mapView addOverlay: fullOverlay];
    
    [self.mapView setRegion: NYRegion animated: YES];
    
    
    //Testing Grid
    
    CLLocation *location1 = [self topLeftLocationOfGrid:&centerCoord And:&spanOfNY];
    
    CLLocation *userLocationTest = [[CLLocation alloc] initWithLatitude:40.71419829 longitude:-74.0062145];
    CLLocation *userLocationTest2 = [[CLLocation alloc] initWithLatitude:40.71482853 longitude:-74.0062896];
    
    NSString *visitedTile1 = [self findUserLocationInGridWith:location1 And:userLocationTest];
    NSString *visitedTile2 = [self findUserLocationInGridWith:location1 And:userLocationTest2];
  
    NSLog(@"column, row 1: %@, column, row 2: %@", visitedTile1, visitedTile2);
    
}

#pragma mark - Grid Set Up

-(CLLocation *)topLeftLocationOfGrid:(CLLocationCoordinate2D *)centerCoord And: (MKCoordinateSpan *)span {
    
    double latDegreesFromCenter = span->latitudeDelta * 0.5;
    double lngDegreesFromCenter = span->longitudeDelta * 0.5;
    
    //Create topLeft corner of grid
    CLLocationCoordinate2D topLeftCoord = CLLocationCoordinate2DMake(centerCoord->latitude + latDegreesFromCenter, centerCoord->longitude - lngDegreesFromCenter);
    
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

-(NSString *)findUserLocationInGridWith:(CLLocation *)gridOriginLocation And:(CLLocation *) userLocation{
    
    CLLocation *latDiff = [[CLLocation alloc] initWithLatitude:gridOriginLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    CLLocation *lngDiff = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:gridOriginLocation.coordinate.longitude];
    
    CLLocationDistance latitudinalDistance = [userLocation distanceFromLocation:latDiff];
    CLLocationDistance longitudinalDistance = [userLocation distanceFromLocation:lngDiff];
    
    double rowNumber = latitudinalDistance / tileSizeInMeters;
    double columnNumber = longitudinalDistance / tileSizeInMeters;
    
    NSString *columnRow = [NSString stringWithFormat:@"%.f, %.f", columnNumber, rowNumber];
    
    return  columnRow;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return [[MKAnnotationView alloc] init];
    }
    return nil;
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


#pragma mark - location manager delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations) {
       
        //NSLog(@"%f", newLocation.horizontalAccuracy);
        //NSLog(@"%f", fabs([newLocation.timestamp timeIntervalSinceNow]));
        
        BOOL isAccurate = newLocation.horizontalAccuracy < 20;
        BOOL isRecent = fabs([newLocation.timestamp timeIntervalSinceNow]) < 2.0;
        
        [self.locations addObject:newLocation];
        
        if (self.locations.count > 1) {
            
            NSInteger sourceIndex = self.locations.count - 1;
            NSInteger destinationIndex = self.locations.count - 2;
            
            NSArray *newLocations = @[self.locations[sourceIndex], self.locations[destinationIndex]];
            
            //drop polyline ***************************
            [self.mapView addOverlay:[self polyLineWithLocations:newLocations]];
        }
        
    }
}


- (void)startLocationUpdates
{
    // Create the location manager if this object does not
    // already have one.
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
    
    if (self.locations == nil) {
        
        self.locations = [NSMutableArray array];
    }
    
    [self startLocationUpdates];
    
}

- (IBAction)stopTrackingPathButtonTapped:(UIButton *)sender {
    
    [self stopTrackingUserLocation];
    
    [self updateDistance];
    
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



-(void)convertMilesToSqMiles {
    
    float miles = [self distanceInMiles:self.distance];
   
    float squareMiles = miles * .0621371;

    self.percentageTravelled = (squareMiles / 305) * 100;
    
    NSLog(@"SquareMiles: %2f", squareMiles);
    NSLog(@"Percentage travelled: %2f", self.percentageTravelled);

}


- (void)updateDistance{
    
    NSLog(@"self.distance: %f", self.distance);
    
    self.distance += [self.locations.firstObject distanceFromLocation:self.locations.lastObject];
    
    NSLog(@"Distance between first Location and last location: %f", [self.locations.firstObject distanceFromLocation:self.locations.lastObject]);
    NSLog(@"self.distance: %f", self.distance);
    NSLog(@"%@", [NSString stringWithFormat:@"Distance: %f", [self distanceInMiles:self.distance]]);
    
    [self convertMilesToSqMiles];
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
        
        MKMapGrayOverlayRenderer *fullOverlayView = [[MKMapGrayOverlayRenderer alloc] initWithOverlay:overlay];
        
        fullOverlayView.overlayAlpha = 0.90;
        
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

#pragma  mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navController = segue.destinationViewController;
    
   UserProfileViewController *detailViewController = (UserProfileViewController *) ([navController viewControllers][0]);
    
    detailViewController.progress = self.percentageTravelled;
    
    NSLog(@"self.percentage travelled is stored %2f", detailViewController.progress);
}



@end
