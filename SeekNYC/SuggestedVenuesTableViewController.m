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

@end

@implementation SuggestedVenuesTableViewController


- (void)fetchFourSquareParkData {
    
    
    
    // create an instagram url
    NSURL *foursquaredParksURL = [NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search?near=nyc&categoryId=4bf58dd8d48988d12d941735&v=20150214&m=foursquare&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV"];
    
    // fetch data from the instagram endpoint and print json response
    [APIManager GETRequestWithURL:foursquaredParksURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
      //  NSLog(@"%@", json);
        
        NSArray *venues = json[@"response"][@"venues"];
       
     //   NSLog(@"VENUES HERE %@", venues);
        
        // reset my array
        self.venueResults = [[NSMutableArray alloc] init];
        
        // loop through all json posts
        for (NSDictionary *venue in venues) {
            
            // create new post from json
            SeekNYCParks *suggestedVenue = [[SeekNYCParks alloc] initWithJSON:venue];
            
            // add post to array
            [self.venueResults addObject:suggestedVenue];
            
        }
        
        [self.tableView reloadData];
    }];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchFourSquareParkData];
    
   
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

    return self.venueResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SuggestedVenuesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placesidentifier" forIndexPath:indexPath];
    
    SeekNYCParks *suggestedVenue = self.venueResults[indexPath.row];
    
    cell.placeAddress.text = [NSString stringWithFormat:@"%@", suggestedVenue.address];
    NSLog(@"%@", cell.placeAddress.text);
    
    cell.placeName.text = [NSString stringWithFormat:@"%@", suggestedVenue.name];
    
    cell.placeCategory.text = [NSString stringWithFormat:@"%@", suggestedVenue.categoryName];
    
    return cell;
}



@end
