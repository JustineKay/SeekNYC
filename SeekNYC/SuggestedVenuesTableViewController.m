//
//  SuggestedVenuesTableViewController.m
//  SeekNYC
//
//  Created by Christella on 11/22/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "SuggestedVenuesTableViewController.h"
#import "APIManager.h"
#import "SeekNYCParks.h"
#import "SuggestedVenuesTableViewCell.h"

@interface SuggestedVenuesTableViewController ()

@property (nonatomic) NSMutableArray *venueResults;
@property (nonatomic) NSMutableArray *parkResults;

@end

@implementation SuggestedVenuesTableViewController


- (void)fetchFourSquareData {
    
    //     create an url
    NSURL *foursquaredURL = [NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search?near=ny&categoryId=4bf58dd8d48988d12d941735&v=20150214&m=foursquare&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV"];
    
    // fetch data from the endpoint and print json response
    [APIManager GETRequestWithURL:foursquaredURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *venues = json[@"response"][@"venues"];
        
        // reset my array
        self.venueResults = [[NSMutableArray alloc] init];
        
        // loop through all json posts
        for (NSDictionary *venue in venues) {
            
            // create new post from json
            SeekNYCParks *suggestedVenue = [[SeekNYCParks alloc] initWithJSON:venue];
            
            // add post to array
            [self.venueResults addObject:suggestedVenue];
            NSLog(@"%@", self.venueResults);
            
        }
        
        
        
          [self.tableView reloadData];
        
    }];
    
}
    
  - (void)fetchFourSquareParkData {
    
    NSURL *foursquaredParkURL = [NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search?near=ny&categoryId=4bf58dd8d48988d163941735&v=20150214&m=foursquare&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV"];
    
    // fetch data from the instagram endpoint and print json response
    [APIManager GETRequestWithURL:foursquaredParkURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
        NSArray *parks = json[@"response"][@"venues"];
        
        // reset my array
        self.parkResults = [[NSMutableArray alloc] init];

        // loop through all json posts
        
        
        for (NSDictionary *venue in parks) {
            
            // create new post from json
            SeekNYCParks *suggestedVenuePark = [[SeekNYCParks alloc] initWithJSON:venue];
            
            // add post to array
            [self.parkResults addObject:suggestedVenuePark];
            NSLog(@"%@", self.parkResults);
            
        }
        
        [self.tableView reloadData];
    
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self fetchFourSquareData];
    [self fetchFourSquareParkData];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"Gray Background.png"]];
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   

    return self.parkResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SuggestedVenuesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placesidentifier" forIndexPath:indexPath];
    
    
    SeekNYCParks *suggestedVenue = self.venueResults[indexPath.row];
    SeekNYCParks *suggestedVenuePark = self.parkResults[indexPath.row];
    
    
    cell.placeAddress.text = [NSString stringWithFormat:@"%@", suggestedVenue.address];
    cell.placeAddress.lineBreakMode = NSLineBreakByWordWrapping;
    cell.placeAddress.numberOfLines = 0;
    cell.placeAddress.text = [NSString stringWithFormat:@"%@", suggestedVenuePark.address];
    cell.placeAddress.lineBreakMode = NSLineBreakByWordWrapping;
    cell.placeAddress.numberOfLines = 0;

   
    cell.placeName.text = [NSString stringWithFormat:@"%@", suggestedVenue.name];
    cell.placeName.lineBreakMode = NSLineBreakByWordWrapping;
    cell.placeName.numberOfLines = 0;
    cell.placeName.text = [NSString stringWithFormat:@"%@", suggestedVenuePark.name];
    cell.placeName.lineBreakMode = NSLineBreakByWordWrapping;
    cell.placeName.numberOfLines = 0;

    
    cell.placeCategory.text = [NSString stringWithFormat:@"%@", suggestedVenue.categoryName];
    cell.placeCategory.text = [NSString stringWithFormat:@"%@", suggestedVenuePark.categoryName];
    
    return cell;
}






@end
