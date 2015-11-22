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

@property (nonatomic) NSMutableArray *parkResults;

@end

@implementation SuggestedVenuesTableViewController


- (void)fetchFourSquareParkData {
    
    
    
    // create an instagram url
    NSURL *foursquaredParksURL = [NSURL URLWithString:@"https://api.foursquare.com/v2/venues/explore?near=nyc&section=outdoors&query=park&venuePhotos=1&sortByDistance=1&v=20151121&client_secret=OHH5FNLYPFF4CIQ4FI1HVJJT4ERPW1MTVG5ZMU4CBNO0RPRV&client_id=E1D5IIQOKCJTC5RF5FTYJ3PTVLAWDZSXGOIINT3AWP3KNEVV"];
    
    // fetch data from the instagram endpoint and print json response
    [APIManager GETRequestWithURL:foursquaredParksURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
      //  NSLog(@"%@", json);
        
        NSArray *venues = json[@"response"][@"groups"];
        
     //   NSLog(@"VENUES HERE %@", venues);
        
        // reset my array
        self.parkResults = [[NSMutableArray alloc] init];
        
        // loop through all json posts
        for (NSDictionary *venue in venues) {
            
            // create new post from json
            SeekNYCParks *parks = [[SeekNYCParks alloc] initWithJSON:venue];
            
            // add post to array
            [self.parkResults addObject:parks];
        }
        
        [self.tableView reloadData];
    }];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchFourSquareParkData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placesidentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}



@end
