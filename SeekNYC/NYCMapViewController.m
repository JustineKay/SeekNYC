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

@class Path;

@interface NYCMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *profileSettingsButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *zoomToLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *stopTrackingPathButton;

@property (weak, nonatomic) IBOutlet UIButton *trackPathButton;


@property (nonatomic) CLLocationManager *locationManager;

@property (nonatomic) Path *userPath;
@property (nonatomic) NSMutableArray *locations;
@property (nonatomic) float distance;
@property (nonatomic) int seconds;

@property (nonatomic) NSTimer *timer;

@end

@implementation NYCMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    self.trackPathButton.hidden = NO;
    self.stopTrackingPathButton.hidden = YES;
    
    [self loadNYCMap];
    
}

//- (void)setPath:(Path *)userPath {
//    
//    if (self.userPath != userPath) {
//        self.userPath = userPath;
//        
//        [self loadNYCMap];
//    }
//}

- (void)loadNYCMap {
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.showsCompass = YES;
    self.mapView.mapType = MKMapTypeHybrid;
    
    CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(40.7127, -74.0059);
    
    MKCoordinateSpan spanOfNY = MKCoordinateSpanMake(0.55, 0.55 );
    
    MKCoordinateRegion NYRegion = MKCoordinateRegionMake(centerCoord, spanOfNY);
    
    MKMapFullCoverageOverlay *fullOverlay = [[MKMapFullCoverageOverlay alloc] initWithMapView:self.mapView];
    [self.mapView addOverlay: fullOverlay];
    
    //If self.userPath.locations != nil then lay down the existing polyline
    //[self.mapView addOverlay:[self polyLine]];
    
    [self.mapView setRegion: NYRegion animated: YES];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations) {
        NSLog(@"%f", newLocation.horizontalAccuracy);
        NSLog(@"%f", fabs([newLocation.timestamp timeIntervalSinceNow]));
        
        //BOOL isAccurate = newLocation.horizontalAccuracy < 20;
        //BOOL isRecent = fabs([newLocation.timestamp timeIntervalSinceNow]) < 2.0;
        
        if (self.locations.count > 0) {
            
            // update distance
            self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
            
            //drop polyline ***************************
            //[self.mapView addOverlay:[self polyLine]];
        }
        
            [self.locations addObject:newLocation];
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
    
    [self.locationManager stopUpdatingLocation];
    
}



- (void)savePath {
    
    Path *newPath = [NSEntityDescription insertNewObjectForEntityForName:@"Path"
                                                inManagedObjectContext:self.managedObjectContext];
    
    newPath.distance = [NSNumber numberWithFloat:self.distance];
    newPath.duration = [NSNumber numberWithInt:self.seconds];
    newPath.timestamp = [NSDate date];
    
    NSMutableArray *locationArray = [NSMutableArray array];
    for (CLLocation *location in self.locations) {
        Location *locationObject = [NSEntityDescription insertNewObjectForEntityForName:@"Location"
                                                                 inManagedObjectContext:self.managedObjectContext];
        
        locationObject.timestamp = location.timestamp;
        locationObject.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
        locationObject.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
        [locationArray addObject:locationObject];
    }
    
    newPath.locations = [NSOrderedSet orderedSetWithArray:locationArray];
    
    if (self.userPath == nil) {
        
        self.userPath = newPath;
    
    }else {
    
        [self.userPath addLocations: newPath.locations];
    
    }
    
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
        
        fullOverlayView.overlayAlpha = 0.85;
        
        return fullOverlayView;
    }
    
    return nil;
}

- (MKPolyline *)polyLine {
    
    CLLocationCoordinate2D coords[self.locations.count];
    
    for (int i = 0; i < self.locations.count; i++) {
        Location *location = [self.locations objectAtIndex:i];
        coords[i] = CLLocationCoordinate2DMake(location.latitude.doubleValue, location.longitude.doubleValue);
    }
    
    return [MKPolyline polylineWithCoordinates:coords count:self.locations.count];
}



@end
