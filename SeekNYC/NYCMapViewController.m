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
#import "VisitedTile.h"
#import "VisitedTile+CoreDataProperties.h"
#import "ClearOverlayPathRenderer.h"
#import "MKMapColorOverlayRenderer.h"
#import "MKMapFullCoverageOverlay.h"
#import "AppDelegate.h"
#import "UserProfileViewController.h"
#import "NYAlertViewController.h"
#import "RNFrostedSidebar.h"
#import "SuggestedVenuesTableViewController.h"
#import "UIColor+Color.h"
#import "DiamondPinAnnotationView.h"
#import "DiamondAnnotationView.h"
#import "SunglassesAnnotationView.h"
#import "UberBlackAnnotationView.h"
#import "ClearOverlayPolygonRenderer.h"
#import "BoroughPolygonData.h"
#import "ZipCodeData.h"
#import "ZipCode.h"
#import "APIManager.h"
#import "SeekNYCParks.h"
#import "NYHiddenLocations.h"
#import "BootstrapData.h"

static double const tileSizeInMeters = 100.0;
static float const centerCoordLat = 40.7127;
static float const centerCoordLng = -74.0059;
static float const NYRegionSpan = 0.525;

@interface NYCMapViewController ()
<
CLLocationManagerDelegate,
MKMapViewDelegate,
NSFetchedResultsControllerDelegate
>

@property(nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *profileSettingsButton;
@property (weak, nonatomic) IBOutlet UIButton *zoomToLocationButton;

@property (nonatomic) CLLocationManager *locationManager;

@property (nonatomic) NSMutableArray *visitedTilesColumnRow;

@property (nonatomic) CLLocation *gridOriginPoint;
@property (nonatomic) CLLocationCoordinate2D gridCenterCoord;
@property (nonatomic) MKCoordinateSpan gridSpan;

@property (nonatomic) NSMutableArray *zipCodesOfNYC;
@property (nonatomic) ZipCodeData *zipCodeData;

@property (nonatomic) BoroughPolygonData *boroughPolygonData;
@property (nonatomic) NSArray *boroughPolygonOverlays;
@property (nonatomic) NSString *locationBorough;


@property (nonatomic) NSString *userLocationZipCode;

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@property (nonatomic) NSMutableArray *allSuggestions;

@property (nonatomic) NSMutableArray *venueResults;

@property (nonatomic) BOOL hasBootstrappedData;

@property (nonatomic) NSString *venueResultLat;

@property (nonatomic) NSString *venueResultLng;

@property (nonatomic) NSTimer *timer;

@end



@implementation NYCMapViewController

- (NSManagedObjectContext *)managedObjectContext {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}


-(void)passURL: (NSURL *)url {
    
    [APIManager GETRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *res = json[@"response"];
        NSArray *groups = res[@"groups"];
        NSArray *items = groups[0][@"items"];
        
        //We don't want to reset the array here because
        //we're calling this method several times
        //if we reset every time, we lose what was added to the array
//        //reset my array
//        self.venueResults = [[NSMutableArray alloc] init];
        
        // loop through all json posts
        for (NSDictionary *item in items) {
            
            // create new post from json
            SeekNYCParks *suggestedParkVenue = [[SeekNYCParks alloc] initWithJSON:item];
            
            //We don't want to add to the array before we filter the results
            //[self.venueResults addObject:suggestedParkVenue];
            
            //We're adding to self.venueResults inside this method below
            [self filterAPIResult:suggestedParkVenue];
            
        }
        
    }];
    
}




- (void)fetchFourSquareData {
    
//    NSArray *nycBorough = @[@"nyc", @"brooklyn", @"queens", @"bronx", @"staten_island"];
//    int randomBorough = arc4random_uniform((int)nycBorough.count);
//    NSArray *nycQuery = @[@"landmark",@"park"];
//    int randomQuery = arc4random_uniform((int)nycQuery.count);
//    NSString *url = [NSString stringWithFormat: @"https://api.foursquare.com/v2/venues/explore?near=%@&query=%@&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV", nycBorough[randomBorough],nycQuery[randomQuery]];
   
    //Bronx Venues
    NSString *urlBronxPark = @"https://api.foursquare.com/v2/venues/explore?near=bronx&query=parks&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    NSString *urlBronxLandmark = @"https://api.foursquare.com/v2/venues/explore?near=bronx&query=landmark&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    
    //Manhattan Venues
    NSString *urlManhattanPark = @"https://api.foursquare.com/v2/venues/explore?near=nyc&query=park&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    NSString *urlManhattanLandmark = @"https://api.foursquare.com/v2/venues/explore?near=nyc&query=landmark&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    
    //Brooklyn Venues
    NSString *urlBrooklynPark = @"https://api.foursquare.com/v2/venues/explore?near=brooklyn&query=park&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    NSString *urlBrooklynLandmark = @"https://api.foursquare.com/v2/venues/explore?near=brooklyn&query=landmark&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    
    //Queens Venues
    NSString *urlQueensPark = @"https://api.foursquare.com/v2/venues/explore?near=queens&query=park&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    NSString *urlQueensLandmark = @"https://api.foursquare.com/v2/venues/explore?near=queens&query=landmark&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    
    //Queens Venues
    NSString *urlStatenIPark = @"https://api.foursquare.com/v2/venues/explore?near=staten_island&query=park&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";
    NSString *urlStatenILandmark = @"https://api.foursquare.com/v2/venues/explore?near=staten_island&query=landmark&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV";

    
//    NSURL *foursquaredURL = [NSURL URLWithString:url];
    NSURL *foursquaredURLBxPark = [NSURL URLWithString:urlBronxPark];
    NSURL *foursquaredURLBxLandmark = [NSURL URLWithString:urlBronxLandmark];
    
    NSURL *foursquaredURLManhattanPark = [NSURL URLWithString:urlManhattanPark];
    NSURL *foursquaredURLManhattanLandmark = [NSURL URLWithString:urlManhattanLandmark];
    
    NSURL *foursquaredURLBrooklynPark = [NSURL URLWithString:urlBrooklynPark];
    NSURL *foursquaredURLBrooklynLandmark = [NSURL URLWithString:urlBrooklynLandmark];
    
    NSURL *foursquaredURLQueensPark = [NSURL URLWithString:urlQueensPark];
    NSURL *foursquaredURLQueensLandmark = [NSURL URLWithString:urlQueensLandmark];
    
    NSURL *foursquaredURLStatenIPark = [NSURL URLWithString:urlStatenIPark];
    NSURL *foursquaredURLStatenILandmark = [NSURL URLWithString:urlStatenILandmark];
    
    [self passURL:foursquaredURLBxPark];
    [self passURL:foursquaredURLBxLandmark];

    [self passURL:foursquaredURLManhattanPark];
    [self passURL:foursquaredURLManhattanLandmark];

    [self passURL:foursquaredURLBrooklynPark];  
    [self passURL:foursquaredURLBrooklynLandmark];

    [self passURL:foursquaredURLQueensPark];
    [self passURL:foursquaredURLQueensLandmark];

    [self passURL:foursquaredURLStatenIPark];
    [self passURL:foursquaredURLStatenILandmark];
    
}

-(void)filterAPIResult: (SeekNYCParks *)result {
    
    CLLocation *resultLocation = [[CLLocation alloc] initWithLatitude:result.landmarkLat longitude:result.landmarkLng];
  
    NSString *resultColumnRow = [self locationInGrid:resultLocation];
    
    if ([self checkForMatchingTile:resultColumnRow] == NO) {
        
        if (self.venueResults == nil) {
            
            self.venueResults = [[NSMutableArray alloc] init];
        }
        
        [self.venueResults addObject: result];
        
    }
}


-(void)loadBootstrapData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSArray *arr = [BootstrapData data];
        for (CLLocation *location in arr) {
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf processBootStrapLocation:location];
            });
        }
    });
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasBootstrappedData = NO;
    
    // Filter hidden locations & VIPRecommendations by user's uncovered area
    //add to venueResults
    NSMutableArray *VIPRecommendations = [NYHiddenLocations hiddenLocations];
    
    for (SeekNYCParks *vipRec in VIPRecommendations) {
        
        [self filterAPIResult:vipRec];
    }
    
    [self fetchFourSquareData];
    
    [self startLocationUpdates];
    
    self.mapView.delegate = self;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    if (self.zipCodeData == nil) {
        
        self.zipCodeData = [[ZipCodeData alloc] init];
        [self.zipCodeData initializeData];
        
    }
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    self.gridCenterCoord = CLLocationCoordinate2DMake(centerCoordLat, centerCoordLng);
    self.gridSpan = MKCoordinateSpanMake(NYRegionSpan, NYRegionSpan);
    self.gridOriginPoint = [self topLeftLocationOfGrid:self.gridCenterCoord And:self.gridSpan];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self presentGestureAlertVC];
    

    //TESTING with BOOTSTRAP DATA*******************
//    if (!self.hasBootstrappedData) {
//        [self loadBootstrapData];
//        self.hasBootstrappedData = YES;
//    }
    //***********************************************
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self loadCountyPolygonOverlays];
    [self loadNYCMap];
    [self loadVisitedTiles];

    
    
    //UNCOMMENT THE FOLLOWING FOR TESTING
    
    //    //*****Testing Grid*********
    //    [self setGridWith:self.gridCenterCoord And:self.gridSpan];
    //
    //    //*****Testing Tile coordinates***************************************************************
    //    //40.6928, -73.9903
    //    CLLocation *testUserLocation = [[CLLocation alloc]initWithLatitude:40.6928 longitude:-73.9903];
    //    NSString *testUserColumnRow = [self locationInGrid:testUserLocation];
    //    NSArray *testUserTileCoords = [self visitedTileCoordinatesWith:testUserColumnRow];
    //    NSLog(@"testUserTileCoords: %@", testUserTileCoords);
    //
    //    [self saveVisitedTile:testUserColumnRow WithBorough: @"Brooklyn" AndCoordinates:testUserTileCoords];
    //
    //    [self.mapView addOverlay:[self polygonWithLocations:testUserTileCoords]];
    //    //[self.mapView addOverlay:[self polyLineWithLocations:testUserTileCoords]];
    //    //*********************************************************************************************
    
//        //*****Testing in Simulator*********CALIFORNIA, San Fran
//        CLLocationCoordinate2D testCenterCoord = CLLocationCoordinate2DMake(37.71641768, -122.44537354);
//        MKCoordinateSpan testSpan = MKCoordinateSpanMake(1.0, 1.0);
//    
//        [self setGridWith:testCenterCoord And:testSpan];
//        //**************************
    
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    NSArray *overlays = self.mapView.overlays;
    [self.mapView removeOverlays:overlays];
}


#pragma mark - Overlays

- (void)loadCountyPolygonOverlays {
    
    if (self.boroughPolygonData == nil) {
        
        self.boroughPolygonData = [[BoroughPolygonData alloc] init];
        
        [self.boroughPolygonData initializeData];
        
        self.boroughPolygonOverlays= @[self.boroughPolygonData.BKPolygon,
                                       self.boroughPolygonData.MANPolygon1,
                                       self.boroughPolygonData.MANPolygon2,
                                       self.boroughPolygonData.MANPolygon3,
                                       self.boroughPolygonData.BRXPolygon,
                                       self.boroughPolygonData.QNSPolygon,
                                       self.boroughPolygonData.SIPolygon
                                       ];
        
    }
   
    [self.mapView addOverlays:self.boroughPolygonOverlays];
    
}

- (void)loadNYCMap {
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.showsCompass = NO;
    self.mapView.mapType = MKMapTypeHybrid;
    
    //set mapview to bounds of screen for grid testing
    //self.mapView.frame = self.view.bounds;
    
    MKCoordinateRegion NYRegion = MKCoordinateRegionMake(self.gridCenterCoord, self.gridSpan);
    
    MKMapFullCoverageOverlay *fullOverlay = [[MKMapFullCoverageOverlay alloc] initWithMapView:self.mapView];
    [self.mapView addOverlay: fullOverlay];
    
    [self.mapView setRegion: NYRegion animated: YES];
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}


#pragma mark - Grid and VisitedTile calculations


-(CLLocation *)topLeftLocationOfGrid:(CLLocationCoordinate2D)centerCoord And: (MKCoordinateSpan)span {
    
    double latDegreesFromCenter = span.latitudeDelta * 0.5;
    double lngDegreesFromCenter = span.longitudeDelta * 0.5;
    
    //Create topLeft corner of grid
    CLLocationCoordinate2D topLeftCoord = CLLocationCoordinate2DMake(centerCoord.latitude + latDegreesFromCenter, centerCoord.longitude - lngDegreesFromCenter);
    
    CLLocation *topLeftLocation = [[CLLocation alloc] initWithLatitude:topLeftCoord.latitude longitude:topLeftCoord.longitude];
    
    return topLeftLocation;
}

-(NSString *)locationInGrid:(CLLocation *)location {
    
//        //TESTING in Simulator**********************
//        CLLocation *latDiff = [[CLLocation alloc] initWithLatitude:37.71641768 longitude:location.coordinate.longitude];
//        CLLocation *lngDiff = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:-122.44537354];
//        //*****************************
    
    CLLocation *latDiff = [[CLLocation alloc] initWithLatitude:self.gridOriginPoint.coordinate.latitude longitude:location.coordinate.longitude];
    CLLocation *lngDiff = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:self.gridOriginPoint.coordinate.longitude];
    
    CLLocationDistance latitudinalDistance = [location distanceFromLocation:latDiff];
    CLLocationDistance longitudinalDistance = [location distanceFromLocation:lngDiff];
    
    double rowNumber = latitudinalDistance / tileSizeInMeters;
    double columnNumber = (longitudinalDistance / tileSizeInMeters) - 1;
    
    NSString *columnRow = [NSString stringWithFormat:@"%.f, %.f", columnNumber, rowNumber];
    
    return  columnRow;
}

-(NSArray *)visitedTileCoordinatesWith: (NSString *)columnRow {
    
    NSArray *columnRowNumbers = [columnRow componentsSeparatedByString:@", "];
    NSString *column = columnRowNumbers[0];
    NSString *row = columnRowNumbers[1];
    NSInteger columnNumber = column.integerValue;
    NSInteger rowNumber = row.integerValue;
    
    double lngDiff = columnNumber * tileSizeInMeters;
    double latDiff = rowNumber * tileSizeInMeters;
    
//        //TESTING in Simulator********
//        CLLocationCoordinate2D gridOriginPoint = CLLocationCoordinate2DMake(37.71641768, -122.44537354);
//        //****************
    CLLocationCoordinate2D gridOriginPoint = CLLocationCoordinate2DMake(self.gridOriginPoint.coordinate.latitude, self.gridOriginPoint.coordinate.longitude);
    
    MKCoordinateRegion tempRegion = MKCoordinateRegionMakeWithDistance(gridOriginPoint, latDiff, lngDiff);
    MKCoordinateSpan tempSpan = tempRegion.span;
    double latDegreesFromGridOriginPoint = tempSpan.latitudeDelta;
    double lngDegreesFromGridOriginPoint = tempSpan.longitudeDelta;
    
    CLLocationCoordinate2D topLeft;
    topLeft.latitude = gridOriginPoint.latitude - latDegreesFromGridOriginPoint;
    topLeft.longitude = gridOriginPoint.longitude + lngDegreesFromGridOriginPoint;
    
    MKCoordinateRegion tileRegion = MKCoordinateRegionMakeWithDistance(topLeft, tileSizeInMeters, tileSizeInMeters);
    MKCoordinateSpan tileSpan = tileRegion.span;
    double latDegreesFromTopLeft = tileSpan.latitudeDelta;
    double lngDegreesFromTopLeft = tileSpan.longitudeDelta;
    
    CLLocationCoordinate2D topRight;
    topRight.latitude = topLeft.latitude;
    topRight.longitude = topLeft.longitude + lngDegreesFromTopLeft;
    
    CLLocationCoordinate2D bottomLeft;
    bottomLeft.latitude = topLeft.latitude - latDegreesFromTopLeft;
    bottomLeft.longitude = topLeft.longitude;
    
    CLLocationCoordinate2D bottomRight;
    bottomRight.latitude = topRight.latitude - latDegreesFromTopLeft;
    bottomRight.longitude = topRight.longitude;
    
    CLLocation *tileTopLeft = [[CLLocation alloc] initWithLatitude:topLeft.latitude longitude:topLeft.longitude];
    CLLocation *tileTopRight = [[CLLocation alloc] initWithLatitude:topRight.latitude longitude:topRight.longitude];
    CLLocation *tileBottomRight = [[CLLocation alloc] initWithLatitude:bottomRight.latitude longitude:bottomRight.longitude];
    CLLocation *tileBottomLeft = [[CLLocation alloc]initWithLatitude:bottomLeft.latitude longitude:bottomLeft.longitude];
    
    NSArray *visitedTileCoordinates = @[tileTopLeft,
                                        tileTopRight,
                                        tileBottomRight,
                                        tileBottomLeft,
                                        tileTopLeft
                                        ];
    
    //***Add annotations to map for visual debugging***
    //    [self addAnnotationToMapWith:topLeft];
    //    [self addAnnotationToMapWith:topRight];
    //    [self addAnnotationToMapWith:bottomRight];
    //    [self addAnnotationToMapWith:bottomLeft];
    
    return visitedTileCoordinates;
}

-(NSArray *)surroundingVisitedTileCoordinatesWithLocation: (CLLocation *)newLocation {
    
    CLLocationCoordinate2D newLoc = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    MKCoordinateSpan newLocSpan = MKCoordinateSpanMake(0.0008, 0.0008);
    
    double latDegreesFromCenter = newLocSpan.latitudeDelta * 0.5;
    double lngDegreesFromCenter = newLocSpan.longitudeDelta * 0.5;
    
    //Create outer corners of newLocationRegion
    CLLocationCoordinate2D topLeftNewLocationRegion = CLLocationCoordinate2DMake(newLoc.latitude + latDegreesFromCenter, newLoc.longitude - lngDegreesFromCenter);
    CLLocationCoordinate2D topRightNewLocationRegion = CLLocationCoordinate2DMake(newLoc.latitude + latDegreesFromCenter, newLoc.longitude + lngDegreesFromCenter);
    CLLocationCoordinate2D bottomLeftNewLocationRegion = CLLocationCoordinate2DMake(newLoc.latitude - latDegreesFromCenter, newLoc.longitude - lngDegreesFromCenter);
    CLLocationCoordinate2D bottomRightNewLocationRegion = CLLocationCoordinate2DMake(newLoc.latitude - latDegreesFromCenter, newLoc.longitude + lngDegreesFromCenter);
    CLLocationCoordinate2D topNewLocationRegion = CLLocationCoordinate2DMake(topLeftNewLocationRegion.latitude, newLoc.longitude);
    CLLocationCoordinate2D rightNewLocationRegion = CLLocationCoordinate2DMake(newLoc.latitude, topRightNewLocationRegion.longitude);
    CLLocationCoordinate2D bottomNewLocationRegion  = CLLocationCoordinate2DMake(bottomLeftNewLocationRegion.latitude, newLoc.longitude);
    CLLocationCoordinate2D leftNewLocationRegion = CLLocationCoordinate2DMake(newLoc.latitude, topLeftNewLocationRegion.longitude);
    
    CLLocation *topLeft = [[CLLocation alloc] initWithLatitude:topNewLocationRegion.latitude longitude:topLeftNewLocationRegion.longitude];
    CLLocation *topRight = [[CLLocation alloc]initWithLatitude:topRightNewLocationRegion.latitude longitude:topRightNewLocationRegion.longitude];
    CLLocation *bottomLeft = [[CLLocation alloc] initWithLatitude:bottomLeftNewLocationRegion.latitude longitude:bottomLeftNewLocationRegion.longitude];
    CLLocation *bottomRight = [[CLLocation alloc] initWithLatitude:bottomRightNewLocationRegion.latitude longitude:bottomRightNewLocationRegion.longitude];
    CLLocation *top = [[CLLocation alloc] initWithLatitude:topNewLocationRegion.latitude longitude:topNewLocationRegion.longitude];
    CLLocation *right = [[CLLocation alloc] initWithLatitude:rightNewLocationRegion.latitude longitude:rightNewLocationRegion.longitude];
    CLLocation *bottom = [[CLLocation alloc] initWithLatitude:bottomNewLocationRegion.latitude longitude:bottomNewLocationRegion.longitude];
    CLLocation *left = [[CLLocation alloc] initWithLatitude:leftNewLocationRegion.latitude longitude:leftNewLocationRegion.longitude];
    
    NSArray *surroundingTileCoords = @[ topLeft,
                                        topRight,
                                        bottomRight,
                                        bottomLeft,
                                        top,
                                        right,
                                        bottom,
                                        left
                                        ];
    
    return surroundingTileCoords;

}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    //tried (annotation == mapView.userLocation) to no avail
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        
        
        //******Testing an alternative annotationView**********************************************************
        //        UberBlackAnnotationView *view = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:@"animated"];
        //        if (!view)
        //            view = [[UberBlackAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"animated"];
        //        view.bounds = CGRectMake(0, 0, 45, 20);
        
        SunglassesAnnotationView *view = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:@"sunglassesAnimated"];
        if (!view) {
            view = [[SunglassesAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"sunglassesAnimated"];
            view.bounds = CGRectMake(0, 0, 80, 80);
            
        }

        CABasicAnimation *theAnimation = [self animation];
        
        //Assign the animation to your UIImage layer and the
        //animation will start immediately
        [view.layer addAnimation:theAnimation forKey:@"animateOpacity"];
        
        return view;
        
        
    }else if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        
        DiamondAnnotationView *view = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:@"diamondAnimated"];
        if(!view)
            view =[[DiamondAnnotationView alloc ] initWithAnnotation:annotation reuseIdentifier:@"diamondAnimated"];
        view.bounds = CGRectMake(0, 0, 30, 30);
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [infoButton setImage:[UIImage imageNamed:@"directions.png"] forState:UIControlStateNormal];
        
        infoButton.tintColor = [UIColor hotPinkColor];
        view.rightCalloutAccessoryView = infoButton;
//        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notepad_F.png"]];
//        view.leftCalloutAccessoryView = iconView;
       
        CABasicAnimation *theAnimation = [self animation];
        
        [view.layer addAnimation:theAnimation forKey:@"animateOpacity"];
        
        view.canShowCallout = YES;
      
        return view;
        
        
       
       
    }
    
    return nil;
}




-(CABasicAnimation *)animation{
    
    CABasicAnimation *theAnimation;
    
    
    //value of the layer
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    //animation lasts 1 second
    theAnimation.duration=1.0;
    //and it repeats forever
    theAnimation.repeatCount= HUGE_VALF;
    //we want a reverse animation
    theAnimation.autoreverses=YES;
    
    return theAnimation;
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *annotationView;
    
    for (annotationView in views) {
        
        //Don't pin drop if annotation is user location
        if (![annotationView.annotation isKindOfClass:[MKUserLocation class]]) {
        
        CGRect endFrame = annotationView.frame;
        
        // Move annotation out of view
        annotationView.frame = CGRectMake(annotationView.frame.origin.x,
                                          annotationView.frame.origin.y - self.view.frame.size.height,
                                          annotationView.frame.size.width,
                                          annotationView.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:0.5
                              delay:0.04*[views indexOfObject:annotationView]
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             annotationView.frame = endFrame;
                             
                             // Animate squash
                         }completion:^(BOOL finished){
                             if (finished) {
                                 [UIView animateWithDuration:0.05 animations:^{
                                     annotationView.transform = CGAffineTransformMakeScale(1.0, 0.8);
                                     
                                 }completion:^(BOOL finished){
                                     if (finished) {
                                         [UIView animateWithDuration:0.1 animations:^{
                                             annotationView.transform = CGAffineTransformIdentity;
                                         }];
                                     }
                                 }];
                             }
                         }];
        }
    }
    
}


#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    for (CLLocation *newLocation in locations) {
        
        [self processLocation:newLocation];
        
    }
}

-(BOOL)locationIsNYC: (CLLocation *)newLocation {
    
    CLLocationCoordinate2D mapCoordinate = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    MKMapPoint mapPoint = MKMapPointForCoordinate(mapCoordinate);
    
    for (BoroughPolygon *boroughOverlay in self.boroughPolygonOverlays) {
        
        ClearOverlayPolygonRenderer *boroughOverlayRenderer = (ClearOverlayPolygonRenderer *)[self.mapView rendererForOverlay: boroughOverlay];
        
        CGPoint boroughOverlayViewPoint = [boroughOverlayRenderer pointForMapPoint:mapPoint];
        
        BOOL locationIsInNYC = CGPathContainsPoint(boroughOverlayRenderer.path, NULL, boroughOverlayViewPoint, NO);
        
        if (locationIsInNYC) {
            
            //get borough of newLocation
            self.locationBorough = boroughOverlay.name;
            
            NSLog(@"User is in NYC, %@", self.locationBorough);
           
            return YES;
            
        }
        
    }
    
    NSLog(@"User is not in NYC");
    
    return NO;
}

-(void) processLocation: (CLLocation *)newLocation {
    
    NSLog(@"newLocation: %@", newLocation);
    
    BOOL isAccurate = newLocation.horizontalAccuracy < 20;
    
    if (!isAccurate) {
        
        return;
    }
   
    //***REMOVE (isNYC) to test in simulator *************
    if ([self locationIsNYC:newLocation]) {
        
        [self createNewTile:newLocation WithBorough:self.locationBorough];
        
        NSArray *surroundingTileCoords = [self surroundingVisitedTileCoordinatesWithLocation:newLocation];
        
        for (CLLocation *loc in surroundingTileCoords) {
            
            if ([self locationIsNYC:loc]) {
                
                [self createNewTile:loc WithBorough:self.locationBorough];
            }
            
        }
        
    }
    
}




-(void) processBootStrapLocation: (CLLocation *)newLocation {
    
    if ([self locationIsNYC:newLocation]) {
        
        [self createNewTile:newLocation WithBorough:self.locationBorough];
        
        //get surrounding locations from new location
        //repeat the above to calculate surrounding tiles
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *surroundingTileCoords = [self surroundingVisitedTileCoordinatesWithLocation:newLocation];
            for (CLLocation *loc in surroundingTileCoords) {
                
                if ([self locationIsNYC:loc]) {
                    
                    [self createNewTile:loc WithBorough:self.locationBorough];
                    
                }
                
            }
            
        });
        
    }
    
}



-(BOOL)checkForMatchingTile: (NSString *)newTile {
    
    for (int i = 0; i < self.visitedTilesColumnRow.count; i++) {
        
        if ([newTile isEqualToString:self.visitedTilesColumnRow[i]]) {
            NSLog(@"Matching Tile Found");
            return YES;
        }
        
    }
    return NO;
}

-(void)createNewTile: (CLLocation *)newLocation WithBorough: (NSString *)newLocationBorough {
    
    NSString *newTile = [self locationInGrid:newLocation];
    
    if ([self checkForMatchingTile:newTile] == NO) {
        
        NSLog(@"No matching tile found");
        
        //Use these coords to draw the tile
        NSArray *tileCoords = [self visitedTileCoordinatesWith:newTile];
        
        [self saveVisitedTile:newTile WithBorough:newLocationBorough AndCoordinates:tileCoords];
        
        [self.visitedTilesColumnRow addObject:newTile];
        
        [self.mapView addOverlay:[self polygonWithLocations:tileCoords]];
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
    self.locationManager.distanceFilter = 10.0; // meters
    
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    [self.locationManager startUpdatingLocation];
    
}


-(void)getZipCode: (CLLocation *)newLocation completion:(void(^)(BOOL isNYC))completion {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             //Testing Location********************
             CLLocation *testLocation = newLocation;
             NSLog(@"location: %@", testLocation);
             
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             //NSLog(@"placemark %@",placemark);
             
             if (placemark.postalCode) {
                 NSString *zipNumber = [[NSString alloc]initWithString:placemark.postalCode];
                 self.userLocationZipCode = zipNumber;
             
                 completion([self verifyZipCode:zipNumber]);
             }
             
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error); // Error handling required
         }
     }];
    
}

-(BOOL)verifyZipCode: (NSString *)userLocationZipCode {
    
    
    for (ZipCode *zip in self.zipCodeData.allZipCodes){
        
        if ([zip.number isEqualToString:userLocationZipCode]) {
            
            NSLog(@"User is in NYC, %@", zip.borough);

            return YES;
            
        }
        
    }
    
    NSLog(@"User is not in NYC");

    return NO;
    
}

- (NSString *) getBorough: (NSString *)newLocationZipCode {
    
    for (ZipCode *zip in self.zipCodeData.allZipCodes){
        if ([zip.number isEqualToString:newLocationZipCode]) {
            
            return zip.borough;
        }
    }
    
    return nil;
}

#pragma mark - Action Buttons


- (IBAction)menuButtonTapped:(UIButton *)sender {
    
    
    NSArray *images = @[
                        [UIImage imageNamed:@"percentage"],
                        [UIImage imageNamed:@"tint"],
                        [UIImage imageNamed:@"seek"]
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
    NSLog(@"Tapped item at index %ld",(unsigned long)index);
    
    
    if (index == 0) {
        
        //***SEGUE TO PROFILE***
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UserProfileViewController *userProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
        
        [self presentViewController:userProfileVC animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES];
        
    } else if (index == 1) {
        
        //***TINT***
        //AlertVC for custom tint
        
        [self setCustomTint];
        
        [sidebar dismissAnimated:YES];
        
        
        
    } else if (index == 2) {
        
        //*** Alert for Suggested landmark/park ***
        
        [self suggestedPlacesAlertVC];
        
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
    
    
    
    MKCoordinateRegion region;
    
    //Testing alternatives for this action button
    
//    MKMapPoint userLocationPoint = MKMapPointForCoordinate(self.mapView.userLocation.coordinate);
//    
//    if ([self.mapView.annotations count] > 1) {
//        
//        MKMapPoint annotationPoint = MKMapPointForCoordinate(self.mapView.userLocation.coordinate);
//        MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
//        
//        for (id<MKAnnotation> annotation in self.mapView.annotations) {
//            
//            if (![annotation isKindOfClass:[MKUserLocation class]]) {
//            
//            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
//            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 1000.0, 1000.0);
//            zoomRect = MKMapRectUnion(zoomRect, pointRect);
//                
//            
////            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
////                
////                
////            CLLocation *annotationLocation = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
////            CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.mapView.userLocation.coordinate.latitude longitude:self.mapView.userLocation.coordinate.longitude];
////
////            CLLocationDistance distanceBetweenAnnotationsAndUserLocation = [userLocation distanceFromLocation:annotationLocation];
////            CLLocationCoordinate2D userLocation2D =CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
////            
////            region.center = userLocation2D;
////            region.span.latitudeDelta = distanceBetweenAnnotationsAndUserLocation;
////            region.span.longitudeDelta = distanceBetweenAnnotationsAndUserLocation;
//        }
//        
//        //[self.mapView setRegion:region animated:YES];
//            [self.mapView setVisibleMapRect:zoomRect animated:YES];
//            
//            self.mapView.frame = self.view.bounds;
//            
//        }
//        
//    }else {
//        
//    }

    
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    
    CLLocationCoordinate2D location = self.mapView.userLocation.coordinate;
    
    region.span = span;
    region.center = location;
    
    [self.mapView setRegion:region animated:TRUE];
    [self.mapView regionThatFits:region];
    
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}


#pragma mark - Core Data

- (void)saveVisitedTile: (NSString *)columnRow WithBorough: (NSString *)borough AndCoordinates: (NSArray *)coords {
    
    VisitedTile *tile = [NSEntityDescription insertNewObjectForEntityForName:@"VisitedTile"
                                                      inManagedObjectContext:self.managedObjectContext];
    
    tile.timestamp = [NSDate date];
    tile.columnRow = columnRow;
    tile.borough = borough;
    tile.coordinatesArray = coords;
    
    
    // Save the context.
    NSError *error = nil;
    
    if (![self.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(void)loadVisitedTiles {
    
    self.visitedTilesColumnRow = [[NSMutableArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"VisitedTile"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    fetchRequest.sortDescriptors = @[sort];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    if (self.fetchedResultsController.fetchedObjects != nil) {
        
        NSArray *fetchedTiles = self.fetchedResultsController.fetchedObjects;
        
        for (VisitedTile *tile in fetchedTiles) {
            
            //Get tile's columnRow string
            
            [self.visitedTilesColumnRow addObject: tile.columnRow];
            
            
            //Draw tile with tile coordinates
            
            NSArray *visitedTileCoordinates = tile.coordinatesArray;
            
            [self.mapView addOverlay:[self polygonWithLocations:visitedTileCoordinates]];
            
        }
        
    }
}


#pragma mark - Overlay Renderer

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    if ([overlay isKindOfClass:[BoroughPolygon class]]) {
        
        BoroughPolygon *boroughOverlay = (BoroughPolygon *)overlay;
        
        
        ClearOverlayPolygonRenderer *renderer = [[ClearOverlayPolygonRenderer alloc] initWithPolygon:boroughOverlay];
        
        renderer.fillColor = [UIColor blackColor];
        renderer.strokeColor = [UIColor blackColor];
        renderer.lineWidth   = 3;
        
        return renderer;
        
    }else if ([overlay isKindOfClass:[MKPolygon class]]) {
        
        MKPolygon *tileOverlay = (MKPolygon *)overlay;
       
        ClearOverlayPolygonRenderer *renderer = [[ClearOverlayPolygonRenderer alloc] initWithPolygon:tileOverlay];
        
        renderer.fillColor = [UIColor blackColor];
        renderer.strokeColor = [UIColor blackColor];
        renderer.lineWidth   = 3;
        
        return renderer;
        
    } else if([overlay isMemberOfClass:[MKMapFullCoverageOverlay class]]) {
        
        MKMapColorOverlayRenderer *fullOverlayRenderer = [[MKMapColorOverlayRenderer alloc] initWithOverlay:overlay];
        fullOverlayRenderer.overlayAlpha = 0.90;
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:TintKey]) {
            
            NSData *colourData = [[NSUserDefaults standardUserDefaults] objectForKey:TintKey];
            
            UIColor *userColour = [NSKeyedUnarchiver unarchiveObjectWithData:colourData];
            
            fullOverlayRenderer.overlayColor = userColour;
            
            fullOverlayRenderer.overlayAlpha = 0.75;
            
            
        }
        
        return fullOverlayRenderer;
    }
    
    return nil;
}


- (MKPolygon *)polygonWithLocations: (NSArray <CLLocation *> *)locations {
    
    CLLocationCoordinate2D coords[locations.count];
    
    for (int i = 0; i < locations.count; i++) {
        CLLocation *location = [locations objectAtIndex:i];
        coords[i] = location.coordinate;
    }
    
    return [MKPolygon polygonWithCoordinates:coords count:locations.count];
}


#pragma mark - AlertViewController

-(void)presentGestureAlertVC {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *infoAlert = @"infoAlert";
    if ([prefs boolForKey:infoAlert])
        return;
    [prefs setBool:YES forKey:infoAlert];
    
    NYAlertViewController *gestureAlertInfo = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    // Set a title and message
    gestureAlertInfo.title = NSLocalizedString(@"Heads Up", nil);
    gestureAlertInfo.message = NSLocalizedString(@"Shake your phone to\n generate places to visit", nil);
    
    // Customize appearance as desired
    gestureAlertInfo.transitionStyle = NYAlertViewControllerTransitionStyleSlideFromBottom;
    [self alertViewControllerUI:gestureAlertInfo];
    
    //add action
    [gestureAlertInfo addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(NYAlertAction *action) {
                                                           [self dismissViewControllerAnimated:YES completion:nil];
                                                       }]];
    
    // Present the alert view controller
    [self presentViewController:gestureAlertInfo animated:YES completion:nil];
}

-(void)alertViewControllerUI: (NYAlertViewController *)alertViewController {
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"Viafont" size:19.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"Viafont" size:16.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"Viafont" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"Viafont" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.swipeDismissalGestureEnabled = YES;
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
}

-(void)setCustomTint {
    
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    // Set a title and message
    alertViewController.title = NSLocalizedString(@"Tint", nil);
    alertViewController.message = NSLocalizedString(@"Pick a color, Set the vibe.", nil);
    
    [self alertViewControllerUI:alertViewController];
    
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
                                                              
                                                              NSArray *overlays = self.mapView.overlays;
                                                              [self.mapView removeOverlays:overlays];
                                                              
                                                              MKMapFullCoverageOverlay *fullOverlay = [[MKMapFullCoverageOverlay alloc] initWithMapView:self.mapView];
                                                              
                                                              [self.mapView addOverlay: fullOverlay];
                                                              
                                                              [self loadVisitedTiles];
                                                              
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


-(void)suggestedPlacesAlertVC {
    
    NYAlertViewController *gestureAlertInfo = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    // Set a title and message
    gestureAlertInfo.title = NSLocalizedString(@"Seeking something new?", nil);
    gestureAlertInfo.message = NSLocalizedString(@"Shake Your Phone!", nil);
    
    // Customize appearance as desired
    gestureAlertInfo.transitionStyle = NYAlertViewControllerTransitionStyleFade;
    [self alertViewControllerUI:gestureAlertInfo];
    
    //add action
    [gestureAlertInfo addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(NYAlertAction *action) {
                                                           [self dismissViewControllerAnimated:YES completion:nil];
                                                       }]];
    
    // Present the alert view controller
    [self presentViewController:gestureAlertInfo animated:YES completion:nil];
}


#pragma mark - ShakeGesture

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        
        [self showSuggestedPlacesAlert];
        
    }
}

-(IBAction)showSuggestedPlacesAlert {
    
    //  NSLog(@"%@", self.venueResults);
    int random = arc4random_uniform((int)self.venueResults.count);
    
    SeekNYCParks *suggestedVenue = [self.venueResults objectAtIndex:random];
    
    NYAlertViewController *alertShakeGesture = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    // Set a title and message
    alertShakeGesture.title = NSLocalizedString(suggestedVenue.name, nil);
    alertShakeGesture.message = NSLocalizedString(suggestedVenue.detail, nil);
    
    // Customize appearance as desired
    
    alertShakeGesture.transitionStyle = NYAlertViewControllerTransitionStyleFade;
    [self alertViewControllerUI:alertShakeGesture];
    
    //add action
    [alertShakeGesture addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Go", nil)
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(NYAlertAction *action) {
                                                                                                                        
                                                
                                                            
                                                            //Remove any previous annotations
                                                            NSMutableArray *annotationsToRemove = [self.mapView.annotations mutableCopy];
                                                            [self.mapView removeAnnotations:annotationsToRemove];
                                                            
                                                            //create an annotation
                                                            MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
                                                            myAnnotation.coordinate = CLLocationCoordinate2DMake(suggestedVenue.landmarkLat, suggestedVenue.landmarkLng);
                                                            myAnnotation.title = suggestedVenue.name;
                                                            myAnnotation.subtitle = suggestedVenue.address;
                                                            
                                                            
                                                           
                                                            self.venueResultLat = [NSString stringWithFormat:@"%lf", suggestedVenue.landmarkLat];
                                                            self.venueResultLng = [NSString stringWithFormat:@"%lf", suggestedVenue.landmarkLng];
                                                            
                                                            
                                                            
//                                                            //TEST ANNOTATION
//                                                            MKPointAnnotation *testAnnotation = [[MKPointAnnotation alloc] init];
//                                                            testAnnotation.coordinate = CLLocationCoordinate2DMake(40.7538, -73.9836);
//                                                            testAnnotation.title = @"Testing 1, 2, 3...";
                                                            
                                                            //Check to see if it's in the current map view, if not zoom out to NY region view
                                                            MKMapPoint point =  MKMapPointForCoordinate(myAnnotation.coordinate);
                                                            if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
                                                                
                                                                MKCoordinateRegion NYRegion = MKCoordinateRegionMake(self.gridCenterCoord, self.gridSpan);
                                                                [self.mapView setRegion: NYRegion animated: YES];
                                                            }
                                                            
                                                            //drop pin
                                                            [self.mapView addAnnotation:myAnnotation];
                                                            
//                                                            //testAnnotation
//                                                            [self.mapView addAnnotation:testAnnotation];
                                                         
                                                            [self dismissViewControllerAnimated:YES completion:nil];
                                                        }]];
    
    [alertShakeGesture addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", nil)
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(NYAlertAction *action) {
                                                            [self dismissViewControllerAnimated:YES completion:nil];
                                                        }]];
    
    // Present the alert view controller
    [self presentViewController:alertShakeGesture animated:YES completion:nil];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    NSString *addressString = [NSString stringWithFormat:@"https://maps.google.com/?daddr=%@,%@",self.venueResultLat, self.venueResultLng];
    NSLog(@"%@", addressString);
        NSURL *url = [NSURL URLWithString:addressString];
        [[UIApplication sharedApplication] openURL:url];
    
    
  }


#pragma  mark - Testing Grid


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
