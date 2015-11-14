//
//  NYCMapViewController.m
//  TrueLocalNYC
//
//  Created by Christella on 11/12/15.
//  Copyright © 2015 Christella. All rights reserved.
//

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

@class Path;

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

- (void)loadNYCMap {
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.mapType = MKMapTypeHybrid;
    
    CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(40.7127, -74.0059);
    
    MKCoordinateSpan spanOfNY = MKCoordinateSpanMake(0.55, 0.55 );
    
    MKCoordinateRegion NYRegion = MKCoordinateRegionMake(centerCoord, spanOfNY);
    
    MKMapFullCoverageOverlay *fullOverlay = [[MKMapFullCoverageOverlay alloc] initWithMapView:self.mapView];
    [self.mapView addOverlay: fullOverlay];
    
    [self.mapView setRegion: NYRegion animated: YES];
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
        
        self.userPaths = self.fetchedResultsController.fetchedObjects;
        
        for (Path *path in self.userPaths) {
            
            NSOrderedSet *pathLocations = path.locations;
            
            [self.mapView addOverlay:[self polyLineWithLocations:pathLocations.array]];
        }
        
    }
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations) {
        NSLog(@"%f", newLocation.horizontalAccuracy);
        NSLog(@"%f", fabs([newLocation.timestamp timeIntervalSinceNow]));
        
        //BOOL isAccurate = newLocation.horizontalAccuracy < 20;
        //BOOL isRecent = fabs([newLocation.timestamp timeIntervalSinceNow]) < 2.0;
        
        [self.locations addObject:newLocation];
        
        if (self.locations.count > 1) {
            
            // update distance
            self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
            
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

- (IBAction)zoomToLocationButtonTapped:(UIButton *)sender {
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES]; 
}

- (IBAction)trackPathButtonTapped:(UIButton *)sender {
    
    self.trackPathButton.hidden = YES;
    self.stopTrackingPathButton.hidden = NO;
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    self.distance = 0;
    
    if (self.locations == nil) {
        
        self.locations = [NSMutableArray array];
    }
    
    [self startLocationUpdates];
    
}

- (IBAction)stopTrackingPathButtonTapped:(UIButton *)sender {
    
    [self stopTrackingUserLocation];
}


- (void)stopTrackingUserLocation {
    
    self.stopTrackingPathButton.hidden = YES;
    self.trackPathButton.hidden = NO;
    
    self.locations = nil;
    
    [self.locationManager stopUpdatingLocation];
    
    [self savePath];
}



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

- (MKPolyline *)polyLineWithLocations: (NSArray *)locations {
    
    CLLocationCoordinate2D coords[locations.count];
    
    for (int i = 0; i < locations.count; i++) {
        CLLocation *location = [locations objectAtIndex:i];
        coords[i] = location.coordinate;
    }
    
    return [MKPolyline polylineWithCoordinates:coords count:locations.count];
}



@end
