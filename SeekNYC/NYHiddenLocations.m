//
//  NYHiddenLocations.m
//  SeekNYC
//
//  Created by Felicia Weathers on 12/5/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "NYHiddenLocations.h"
#import "SeekNYCParks.h"

@implementation NYHiddenLocations

+ (NSMutableArray *)hiddenLocations {
    NSDictionary *atlasObs1 = @{
                                @"name" : @"Bristol Basin",
                                @"url" : @"http://www.atlasobscura.com/places/bristol-basin",
                                @"lat" : @40.667253,
                                @"lng" : @-73.911550,
                                @"address" : @"Bristol Basin, New York, New York, 10010, United States",
                                @"description" : @"A small part of lower Manhattan is actually made from a bit of England"
                                };
    
    NSDictionary *atlasObs2 = @{
                                @"name" : @"TinPan Alley",
                                @"url" : @"http://www.atlasobscura.com/places/the-remnants-of-tin-pan-alley",
                                @"lat" : @40.745927,
                                @"lng" : @-73.989668,
                                @"address" : @"45 West 28th Street, New York, New York, 10001, United States",
                                @"description" : @"The one-time epicenter of American songwriting is now a little remembered Manhattan commercial block"
                                };
    
    NSDictionary *atlasObs3 = @{
                                @"name" : @"Barthman's Sidewalk Clock",
                                @"url" : @"http://www.atlasobscura.com/places/barthman-s-sidewalk-clock",
                                @"lat" : @40.707064,
                                @"lng" : @-74.011978,
                                @"address" : @"76 Broadway, New York, New York, 10038, United States",
                                @"description" : @"A clock set into the concrete outside a Manhattan jeweler has been telling time underfoot for over a century"
                                };
    
    NSDictionary *atlasObs4 = @{
                                @"name" : @"Harry Jenning's Rat Pit of the Five Points",
                                @"url" : @"http://www.atlasobscura.com/places/harry-jenning-s-rat-pit-of-the-five-points",
                                @"lat" : @40.712175,
                                @"lng" : @-73.998275,
                                @"address" : @"47-49 Madison Street, New York, New York, 10038, United States",
                                @"description" : @"This humble historic facade hides a history of boozing and the gentlemanly sport of rat-fighting"
                                };
    
    NSDictionary *atlasObs5 = @{
                                @"name" : @"First Shearith Israel Graveyard",
                                @"url" : @"http://www.atlasobscura.com/places/first-shearith-israel-graveyard",
                                @"lat" : @40.712632,
                                @"lng" : @-73.998808,
                                @"address" : @"57 Saint James Place, New York, New York, 10038, United States",
                                @"description" : @"Revolutionary War casualties fill the only 17th century structure remaining in Manhattan"
                                };
    
    NSDictionary *atlasObs6 = @{
                                @"name" : @"Titanic Memorial",
                                @"url" : @"http://www.atlasobscura.com/places/titanic-memorial",
                                @"lat" : @40.707603,
                                @"lng" : @-74.003663,
                                @"address" : @"Titanic Memorial Park, New York, New York, 10038, United States",
                                @"description" : @"Lower Manhattan's lighthouse, erected at the insistence of the unsinkable Molly Brown"
                                };
    
    NSDictionary *atlasObs7 = @{
                                @"name" : @"Brooklyn Bridge Love Locks",
                                @"url" : @"http://www.atlasobscura.com/places/brooklyn-bridge-love-locks",
                                @"lat" : @40.707150,
                                @"lng" : @-74.002102,
                                @"address" : @"New York, New York, 10038, United States",
                                @"description" : @"The tradition of placing padlocks on bridges to symbolize love has finally appeared on New York's Brooklyn Bridge"
                                };
    
    NSDictionary *atlasObs8 = @{
                                @"name" : @"Chinatown's Bloody Angle",
                                @"url" : @"http://www.atlasobscura.com/places/chinatown-s-bloody-angle",
                                @"lat" : @40.714353,
                                @"lng" : @-73.997976,
                                @"address" : @"Doyers Street, New York, New York, 10013, United States",
                                @"description" : @"The adventure-laden area used to be the battleground for gang warfare of the Tong war, started by legendary Chinese gangster Mock Duck"
                                };
    
    NSDictionary *atlasObs9 = @{
                                @"name" : @"City Hall Library",
                                @"url" : @"http://www.atlasobscura.com/places/chinatown-s-bloody-angle",
                                @"lat" : @40.713612,
                                @"lng" : @-74.004459,
                                @"address" : @"31 Chambers Street, Room 112, New York, New York, 10007, United States",
                                @"description" : @"An accidentally hidden library containing the ephemeral history of New York"
                                };
    
    NSDictionary *atlasObs11 = @{
                                 @"name" : @"The Mulberry Blend",
                                 @"url" : @"http://www.atlasobscura.com/places/the-mulberry-bend",
                                 @"lat" : @40.715142,
                                 @"lng" : @-73.999439,
                                 @"address" : @"8-50 Mulberry Street, New York, New York, 10013, United States",
                                 @"description" : @"At one of New York's most violent streets during the 19th century, you could pay for violence off a prix fixe menu"
                                 
                                 };
    
    NSDictionary *atlasObs12 = @{
                                 @"name" : @"Five Beekman St.",
                                 @"url" : @"http://www.atlasobscura.com/places/the-mulberry-bend",
                                 @"lat" : @40.711401,
                                 @"lng" : @-74.006746,
                                 @"address" : @"5 Beekman Street, New York, New York, 10038, United States",
                                 @"description" : @"Beautiful empty building in the heart of Manhattan's Financial District"
                                 };
    
    NSDictionary *atlasObs13 = @{
                                 @"name" : @"Model Ship Collection, Seaport Museum",
                                 @"url" : @"http://www.atlasobscura.com/places/model-ship-collection-at-the-south-street-seaport-museum",
                                 @"lat" : @40.707150,
                                 @"lng" : @-74.002102,
                                 @"address" : @"far right of the South Street Seaport Docks, New York, New York, 10038, United States",
                                 @"description" : @"Houses a permanent collection of over 1,000 model ships in addition to its fleet of full sized vessels"
                                 };
    
    NSDictionary *atlasObs14 = @{
                                 @"name" : @"Chinatown Icecream Factory",
                                 @"url" : @"http://www.atlasobscura.com/places/chinatown-ice-cream-factory",
                                 @"lat" : @40.715324,
                                 @"lng" : @-73.998174,
                                 @"address" : @"65 Bayard Street , B, New York, New York, 10013, United States",
                                 @"description" : @"China invented ice cream hundreds of years ago in the Tang Dynasty"
                                 };
    
    NSDictionary *atlasObs15 = @{
                                 @"name" : @"Site Of The Beach Pneumatic Subway",
                                 @"url" : @"http://www.atlasobscura.com/places/beach-pneumatic-subway",
                                 @"lat" : @40.714386,
                                 @"lng" : @-74.010141,
                                 @"address" : @"Murray Street, New York, New York, 10007, United States",
                                 @"description" : @"Alfred Beach built this pneumatic tunnel to show the possibility of a subway in New York"
                                 };
    
    NSDictionary *atlasObs16 = @{
                                 @"name" : @"Toloache",
                                 @"url" : @"http://www.atlasobscura.com/places/toloache",
                                 @"lat" : @40.707514,
                                 @"lng" : @-74.007332,
                                 @"address" : @"83 Maiden Ln, New York, New York, 10038, United States",
                                 @"description" : @"This Mexican restaurant serves up a delicacy punctuated with a growth most people are not accustomed"
                                 };
    
    NSDictionary *atlasObs17 = @{
                                 @"name" : @"The John Street Methodist Church",
                                 @"url" : @"http://www.atlasobscura.com/places/the-john-street-methodist-church",
                                 @"lat" : @40.709134,
                                 @"lng" : @-74.008118,
                                 @"address" : @"44 John Street, New York, New York, 10038, United States",
                                 @"description" : @"The oldest Methodist church in the United States has been spreading the good news for over two centuries"
                                 };
    
    NSDictionary *atlasObs18 = @{
                                 @"name" : @"Tunnel Number 3",
                                 @"url" : @"http://www.atlasobscura.com/places/tunnel-number-3",
                                 @"lat" : @40.713649,
                                 @"lng" : @-74.008713,
                                 @"address" : @"New York, New York, 10007, United States",
                                 @"description" : @"Deep under Manhattan is the largest construction project in city history"
                                 };
    
    NSDictionary *atlasObs19 = @{
                                 @"name" : @"New York Federal Gold Vault",
                                 @"url" : @"http://www.atlasobscura.com/places/new-york-federal-gold-vault",
                                 @"lat" : @40.708539,
                                 @"lng" : @-74.008505,
                                 @"address" : @"44 Maiden Ln., New York, New York, 10038, United States",
                                 @"description" : @"50 feet below sea level, you will find yourself in a vault glittering with the largest stockpile of gold in the entire world"
                                 };
    
    NSDictionary *atlasObs20 = @{
                                 @"name" : @"The Woolworth Building",
                                 @"url" : @"http://www.atlasobscura.com/places/the-woolworth-building",
                                 @"lat" : @40.712488,
                                 @"lng" : @-74.008323,
                                 @"address" : @"233 Broadway, New York, New York, 10007, United States",
                                 @"description" : @"Once the tallest building in the world and the site of \"the highest dinner ever held in New York\" will soon hold the most expensive apartment in the city"
                                 };
    
    NSDictionary *atlasObs21 = @{
                                 @"name" : @"Clocktower Gallery And Machinery Room",
                                 @"url" : @"http://www.atlasobscura.com/places/clocktower-gallery",
                                 @"lat" : @40.716389,
                                 @"lng" : @-74.003274,
                                 @"address" : @"108 Leonard Street, New York, New York, 10013, United States",
                                 @"description" : @"A 1890s clock tower, legendary art gallery, and radio station, and rarer yet, a hidden delight in busy Manhattan"
                                 };
    
    NSDictionary *atlasObs22 = @{
                                 @"name" : @"The Sugar House Prison Window",
                                 @"url" : @"http://www.atlasobscura.com/places/the-sugar-house-prison-window",
                                 @"lat" : @40.714973,
                                 @"lng" : @-74.004876,
                                 @"address" : @"NYPD Police Plaza, Duane Street, New York, New York, 10007, United States",
                                 @"description" : @"An odd, ancient window that may have once been part of a brutal prison is embedded in the side of New York's Police Plaza"
                                 };
    
    NSDictionary *atlasObs23 = @{
                                 @"name" : @"MMuseum",
                                 @"url" : @"http://www.atlasobscura.com/places/mmuseumm-2",
                                 @"lat" : @40.718046,
                                 @"lng" : @-74.003052,
                                 @"address" : @"Cortlandt Alley, Btwn Franklin St & White St , New York, New York, 10013, United States",
                                 @"description" : @"Tiny museum housed in a New York freight elevator specializes in the \"overlooked, dismissed, or ignored\""
                                 };
    
    NSDictionary *atlasObs24 = @{
                                 @"name" : @"Bargemusic",
                                 @"url" : @"http://www.atlasobscura.com/places/bargemusic",
                                 @"lat" : @40.717415,
                                 @"lng" : @-73.961499,
                                 @"address" : @"Fulton Ferry Landing, #4C, Brooklyn, New York, 11201, United States",
                                 @"description" : @"The most interesting venue for chamber music is on the hull of an old barge"
                                 };
    
    NSDictionary *atlasObs25 = @{
                                 @"name" : @"Museum of American Finance",
                                 @"url" : @"http://www.atlasobscura.com/places/museum-of-american-finance",
                                 @"lat" : @40.706567,
                                 @"lng" : @-74.009042,
                                 @"address" : @"48 Wall Street , New York, New York, 10005, United States",
                                 @"description" : @"Ever wanted the laymen's version of your credit card fine print"
                                 };
    
    NSDictionary *atlasObs26 = @{
                                 @"name" : @"33 Finance Street",
                                 @"url" : @"http://www.atlasobscura.com/places/33-thomas-street",
                                 @"lat" : @40.716437,
                                 @"lng" : @-74.00613,
                                 @"address" : @"33 Thomas Street, New York, New York, 10007, United States",
                                 @"description" : @"An uber-secure, windowless skyscraper of doom located in the center of Manhattan"
                                 };
    
    NSDictionary *atlasObs27 = @{
                                 @"name" : @"77 Water Street",
                                 @"url" : @"http://www.atlasobscura.com/places/77-water-street",
                                 @"lat" : @40.704195,
                                 @"lng" : @-74.008156,
                                 @"address" : @"77 Water Street, New York, New York, 10005, United States",
                                 @"description" : @"A WWI fighter plane and turn-of-the-century penny candy shop are among the unexpected features of this Financial District building"
                                 };
    
    NSDictionary *atlasObs28 = @{
                                 @"name" : @"Trinity Place Bank Vault Bar",
                                 @"url" : @"http://www.atlasobscura.com/places/trinity-place-bank-vault-bar",
                                 @"lat" : @40.708882,
                                 @"lng" : @-74.011433,
                                 @"address" : @"115 Broadway, New York, New York, 10006, United States",
                                 @"description" : @"This lower Manhattan bar is set up in an old bank vault that rests beneath a skyscraper that hides even more historic splendor"
                                 };
    
    NSDictionary *atlasObs29 = @{
                                 @"name" : @"Wall Street Bombing Scars",
                                 @"url" : @"http://www.atlasobscura.com/places/wall-street-bombing",
                                 @"lat" : @40.706795,
                                 @"lng" : @-74.01048,
                                 @"address" : @"23 Wall Street, New York, New York, 10005, United States",
                                 @"description" : @"Unrepaired walls from a 1920 Anarchist bomb attack"
                                 };
    
    NSDictionary *atlasObs30 = @{
                                 @"name" : @"New York City Police Museum",
                                 @"url" : @"http://www.atlasobscura.com/places/new-york-city-police-museum",
                                 @"lat" : @40.703597,
                                 @"lng" : @-74.0083,
                                 @"address" : @"100 Old Slip, New York, New York, 10005, United States",
                                 @"description" : @"The museum documents the evolution of the NYPD from the rattler wearing Dutch enforcers to today's modern police officers"
                                 };
    
    NSDictionary *atlasObs31 = @{
                                 @"name" : @"Delmonico's Pompeii Columns",
                                 @"url" : @"http://www.atlasobscura.com/places/delmonico-s-pompeii-columns",
                                 @"lat" : @40.705027,
                                 @"lng" : @-74.010358,
                                 @"address" : @"56 Beaver Street, New York, New York, 10004, United States",
                                 @"description" : @"The entrance is made of two marble columns taken from Pompeii"
                                 };
    
    NSDictionary *atlasObs32 = @{
                                 @"name" : @"Dream House",
                                 @"url" : @"http://www.atlasobscura.com/places/dream-house",
                                 @"lat" : @40.718477,
                                 @"lng" : @-74.004802,
                                 @"address" : @"275 Church St, New York, New York, 10013, United States",
                                 @"description" : @"Lamonte Young and Mariane Zazeela's \"Dream House\" will immerse you in an ever changing world of sound and light"
                                 };
    
    NSDictionary *atlasObs33 = @{
                                 @"name" : @"Museum Of Chinese In America",
                                 @"url" : @"http://www.atlasobscura.com/places/museum-of-chinese-in-america",
                                 @"lat" : @40.719388,
                                 @"lng" : @-73.999088,
                                 @"address" : @"215 Centre Street, New York, New York, 10013, United States",
                                 @"description" : @"This small New York museum examines Chinese history from its origins right up to its arrival in the city"
                                 };
    
    NSDictionary *atlasObs34 = @{
                                 @"name" : @"Trinity Churchyard",
                                 @"url" : @"http://www.atlasobscura.com/places/trinity-churchyard",
                                 @"lat" : @40.708091,
                                 @"lng" : @-74.004745,
                                 @"address" : @"56 Beaver Street, New York, New York, 10004, United States",
                                 @"description" : @"This cemetery has graves dating back to the 17th century, including the city's oldest carved tombstone and an ominous cryptogram"
                                 };
    
    NSDictionary *atlasObs35 = @{
                                 @"name" : @"Onieal's Grand Street Bar",
                                 @"url" : @"http://www.atlasobscura.com/places/onieals-grand-street-bar",
                                 @"lat" : @40.719711,
                                 @"lng" : @-73.997849,
                                 @"address" : @"174 Grand Street, New York, New York, 10013, United States",
                                 @"description" : @"There was once a tunnel between the bar and prohibition-era brothel and the police headquarters"
                                 };
    
    NSDictionary *atlasObs36 = @{
                                 @"name" : @"The Baby Grand",
                                 @"url" : @"http://www.atlasobscura.com/places/the-baby-grand",
                                 @"lat" : @40.719794,
                                 @"lng" : @-73.99908,
                                 @"address" : @"161 Lafayette Street, New York, New York, 10013, United States",
                                 @"description" : @"The tiniest little stage in New York"
                                 };
    
    NSDictionary *atlasObs37 = @{
                                 @"name" : @"284 Broome Street",
                                 @"url" : @"http://www.atlasobscura.com/places/284-broome-street",
                                 @"lat" : @40.718650,
                                 @"lng" : @-73.991275,
                                 @"address" : @"284 Broome Street, New York, New York, 10002, United States",
                                 @"description" : @"The smelliest block in New York City"
                                 };
    
    NSDictionary *atlasObs38 = @{
                                 @"name" : @"The Standard oil Building",
                                 @"url" : @"http://www.atlasobscura.com/places/284-broome-street",
                                 @"lat" : @40.705442,
                                 @"lng" : @-74.012888,
                                 @"address" : @"26, Broadway, New York, New York, 10004, United States",
                                 @"description" : @"This curved Manhattan building was built to house the opulence of John D. Rockefeller's oil empire"
                                 };
    
    NSDictionary *atlasObs39 = @{
                                 @"name" : @"Fraunces Tavern",
                                 @"url" : @"http://www.atlasobscura.com/places/fraunces-tavern",
                                 @"lat" : @40.703372,
                                 @"lng" : @-74.011373,
                                 @"address" : @"54 Pearl Street , New York, New York, 10004, United States",
                                 @"description" : @"This Wall Street bar was once a hub of revolutionary activity where Washington famously bid farewell to his troops"
                                 };
    
    NSDictionary *atlasObs40 = @{
                                 @"name" : @"The Oldest Fence In New York",
                                 @"url" : @"http://www.atlasobscura.com/places/the-oldest-fence-in-new-york",
                                 @"lat" : @40.703870,
                                 @"lng" : @-74.013854,
                                 @"address" : @"Bowling Green, New York, New York, 10004, United States",
                                 @"description" : @"Built hundreds of years ago this downtown iron barrier once protected a much despised king"
                                 };
    
    NSDictionary *atlasObs41 = @{
                                 @"name" : @"Ghostbuster's Firehouse",
                                 @"url" : @"http://www.atlasobscura.com/places/ghostbuster-s-firehouse",
                                 @"lat" : @40.719644,
                                 @"lng" : @-74.006621,
                                 @"address" : @"14 North Moore street, New York, New York, 10013, United States",
                                 @"description" : @"You may find you have the sudden urge to turn to someone on the street and say \"I am the keymaster\" to which they must by all rights of man and law reply \"I am the gatekeeper\""
                                 };
    
    NSDictionary *atlasObs42 = @{
                                 @"name" : @"Congee Village",
                                 @"url" : @"http://www.atlasobscura.com/places/congee-village",
                                 @"lat" : @40.718632,
                                 @"lng" : @-73.99037,
                                 @"address" : @"100 Allen Street, New York, New York, 10002, United States",
                                 @"description" : @"Congee Village is perfect for eaters looking for a little more adventure"
                                 };
    
    NSDictionary *atlasObs43 = @{
                                 @"name" : @"Number One Broadway",
                                 @"url" : @"http://www.atlasobscura.com/places/number-one-broadway",
                                 @"lat" : @40.704969,
                                 @"lng" : @-74.014595,
                                 @"address" : @"1, Broadway, New York, New York, 10004, United States",
                                 @"description" : @"This building at the southern tip of Manhattan was once the gateway to luxury vacationing"
                                 };
    
    NSDictionary *atlasObs44 = @{
                                 @"name" : @"The Sphere",
                                 @"url" : @"http://www.atlasobscura.com/places/the-sphere-by-fritz-koenig",
                                 @"lat" : @40.703314,
                                 @"lng" : @-74.016237,
                                 @"address" : @"75 Battery Park Underpass, New York, New York, 10004, United States",
                                 @"description" : @"Was originally designed as a work of art that was situated between the Twin Towers"
                                 };
    
    NSDictionary *atlasObs45 = @{
                                 @"name" : @"Irish Hunger Memorial",
                                 @"url" : @"http://www.atlasobscura.com/places/irish-hunger-memorial",
                                 @"lat" : @40.714403,
                                 @"lng" : @-74.016288,
                                 @"address" : @"290 Vesey St., New York, New York, 10281, United States",
                                 @"description" : @"A fallow potato field and the ruins of a 19th-century cottage"
                                 };
    
    NSDictionary *atlasObs46 = @{
                                 @"name" : @"The American Merchant Mariner's Memorial",
                                 @"url" : @"http://www.atlasobscura.com/places/the-american-merchant-mariner-s-memorial",
                                 @"lat" : @40.703551,
                                 @"lng" : @-74.006499,
                                 @"address" : @"Pier A, Battery Park, New York, New York, 10004, United States",
                                 @"description" : @"Takes the form of three merchant seamen stranded on a sinking ship, calling for help, reaching for the desperate hand of one of their shipmates floundering in the water below"
                                 };
    
    NSDictionary *vipRecsTanner = @{
                                    @"name" : @"Russian and Turkish Baths",
                                    @"url" : @"http://www.russianturkishbaths.com/",
                                    @"lat" : @40.728186,
                                    @"lng" : @-73.98358,
                                    @"address" : @"268 East 10th Street, New York NY 10009",
                                    @"description" : @"Offers several treatments including massages, salt and mud treatments, and the world-reknowned platza"
                                    };
    
    NSDictionary *vipRecsBen = @{
                                 @"name" : @"The Uncommons",
                                 @"url" : @"https://www.uncommonsnyc.com/",
                                 @"lat" : @40.729286,
                                 @"lng" : @-73.998625,
                                 @"address" : @"230 Thompson Street NY, NY 10012",
                                 @"description" : @"Manhattan's only board game cafe.  For $5 ($10 on weekends) browse and play any game in their library"
                                 };
    
    NSDictionary *vipRecsCory = @{
                                  @"name" : @"Ace Hotel Lobby",
                                  @"url" : @"http://www.acehotel.com/newyork",
                                  @"lat" : @40.745743,
                                  @"lng" : @-73.98826,
                                  @"address" : @"20 W 29TH STREET, NEW YORK CITY, NY 10001",
                                  @"description" : @"Bar, coffeeshop, coworking space all rolled into one, with leather couches to boot. Bring a friend or a laptop and get comfy"
                                  };
    
    NSDictionary *vipRecsJames = @{
                                   @"name" : @"New York Transit Museum",
                                   @"url" : @"https://en.wikipedia.org/wiki/New_York_Transit_Museum",
                                   @"lat" : @40.690333,
                                   @"lng" : @-73.989645,
                                   @"address" : @"Boerum Pl & Schermerhorn Street, Brooklyn, NY 11201",
                                   @"description" : @"Displays historical artifacts of the New York City Subway, bus, commuter rail, and bridge and tunnel systems"
                                   };
    
    NSDictionary *vipRecsOrta = @{
                                  @"name" : @"The Artsy Happy Hour",
                                  @"url" : @"http://parrishart.org/PCCArtsyTour",
                                  @"lat" : @40.718961,
                                  @"lng" : @-74.002794,
                                  @"address" : @"401 Broadway, New York, NY 10013 (25th floor)",
                                  @"description" : @"Orta’s favourite Arts + Science drinking session, every friday  on the 25th floor"
                                  };
    
    NSDictionary *vipRecsMatan = @{
                                   @"name" : @"The Met",
                                   @"url" : @"http://www.metmuseum.org/",
                                   @"lat" : @40.779165,
                                   @"lng" : @-73.962928,
                                   @"address" : @"279 Montauk Highway Water Mill, NY 11976",
                                   @"description" : @"Always something new to see.  Pick a different wing, browse a different floor. It’s suggested donation so you don’t have to break the bank every time you go."
                                   };
    
    NSDictionary *vipRecsRachel = @{
                                    @"name" : @"Snug Harbor Cultural Center and Botanic Gardens",
                                    @"url" : @"http://snug-harbor.org",
                                    @"lat" : @40.642631,
                                    @"lng" : @-74.101917,
                                    @"address" : @"1000 Richmond Terrace, Staten Island, NY 10301",
                                    @"description" : @"Formly a retirement community for Naval officers, Snug Harbor's beautiful grounds, community classes and Chinese Scholar's Garden are certainly worth a visit!"
                                    };
    
    NSDictionary *vipRecsCameron = @{
                                     @"name" : @"Governor's Island",
                                     @"url" : @"https://govisland.com/",
                                     @"lat" : @40.689450,
                                     @"lng" : @-74.016792,
                                     @"address" : @"10 South Street, Slip 7, New York, NY 10004, United States",
                                     @"description" : @"Explore this secluded, vehicle-free island on foot or by bike any day during the summer."
                                     };
    
    NSDictionary *statenIsland1 = @{
                                    @"name" : @"The New York City Farm Colony",
                                    @"url" : @"http://www.atlasobscura.com/places/satanic-insanity-the-new	-york-city-farm-colony",
                                    @"lat" : @40.597023,
                                    @"lng" : @-74.138685,
                                    @"address" : @"150 Walcott Avenue, Staten Island, New York, 10314, United States",
                                    @"description" : @"An aging set of antiquated buildings that have been used for everything from their intended purposes to satanic sacrifice and the burial of local children."
                                    };
    
    NSDictionary *statenIsland2 = @{
                                    @"name" : @"Fort Wadsworth",
                                    @"url" : @"http://www.atlasobscura.com/places/fort-wadsworth",
                                    @"lat" : @40.603592,
                                    @"lng" : @-74.058809,
                                    @"address" : @"210 New York Avenue, Staten Island, New York, 10305, United States",
                                    @"description" : @"America's longest-manned military fort is now an just an abandoned hulk"
                                    };
    
    NSDictionary *statenIsland3 = @{
                                    @"name" : @"Willowbrook State School",
                                    @"url" : @"http://www.atlasobscura.com/places/willowbrook-state-school",
                                    @"lat" : @40.583438,
                                    @"lng" : @-74.149587,
                                    @"address" : @"Staten Island, Staten Island, New York, 10314, United States",
                                    @"description" : @"Failed state-supported institution meant to rehabilitate students with mental retardation"
                                    
                                    };
    
    NSDictionary *statenIsland4 = @{
                                    @"name" : @"Fresh Kills Landfill",
                                    @"url" : @"http://www.atlasobscura.com/places/fresh-kills-landfill",
                                    @"lat" : @40.572934,
                                    @"lng" : @-74.129868,
                                    @"address" : @"Fresh Kills Landfill, Staten Island, New York, 10306, United States",
                                    @"description" : @"The garbage dump on Staten Island grew so large over the second half of the 21st century that it became the largest man-made structure in the world, rising eighty two feet higher than the Statue of Liberty. Over the next thirty years, the dump will be remade into one of New York's largest parks."
                                    };
    
    NSDictionary *statenIsland5 = @{
                                    @"name" : @"Hostoric Richmond Town",
                                    @"url" : @"http://www.atlasobscura.com/places/historic-richmond-town",
                                    @"lat" : @40.570232,
                                    @"lng" : @-74.145296,
                                    @"address" : @"441 Clarke Avenue, Staten Island, New York, 10306, United States",
                                    @"description" : @"A town trapped in time - 1958 to be exact"
                                    };
    
    NSDictionary *statenIsland6 = @{
                                    @"name" : @"Arthur Kill Ship Graveyard",
                                    @"url" : @"http://www.atlasobscura.com/places/tugboat-graveyard",
                                    @"lat" : @40.554808,
                                    @"lng" : @-74.217628,
                                    @"address" : @"2453 Arthur Kill Road, Staten Island, New York, 10309, United States",
                                    @"description" : @"Final resting place of two dozen New York City harbor ships"
                                    };
    
    NSDictionary *bronx1 = @{
                             @"name" : @"Banana Ripening Facility",
                             @"url" : @"http://www.atlasobscura.com/places/banana-ripening-facility",
                             @"lat" : @40.816314,
                             @"lng" : @-73.882690,
                             @"address" : @"750 Drake St. Bronx, Bronx, New York, 10474, United States",
                             @"description" : @"Despite not growing anywhere near New York City, bananas are ripened in a pressurized room in the Bronx using precise banana science"
                             };
    
    NSDictionary *bronx2 = @{
                             @"name" : @"Edgar Allen Poe Cottage",
                             @"url" : @"http://www.atlasobscura.com/places/edgar-allen-poe-cottage",
                             @"lat" : @40.816314,
                             @"lng" : @-73.882690,
                             @"address" : @"2640 Grand Concourse, Bronx, New York, 10458, United States",
                             @"description" : @"When Poe lived in this cottage, the Bronx was a country area. Poe used the cottage to write many of his poems. It now resides in a starkly different area but can still be visited by those interested in Poe and his work."
                             };
    
    NSDictionary *bronx3 = @{
                             @"name" : @"North Brother Island",
                             @"url" : @"http://www.atlasobscura.com/places/north-brother-island",
                             @"lat" : @40.800720,
                             @"lng" : @-73.898137,
                             @"address" : @"North Brother Island, Bronx, New York, 10455, United States",
                             @"description" : @"Home to the worst loss of life in New York's history until September 11, 2001"
                             };
    
    NSDictionary *bronx4 = @{
                             @"name" : @"St. Raymond's Cemetery",
                             @"url" : @"http://www.atlasobscura.com/places/st-raymonds-cemetery",
                             @"lat" : @40.822766,
                             @"lng" : @-73.834140,
                             @"address" : @"2600 Lafayette Avenue, Bronx, New York, 10465, United States",
                             @"description" : @"St. Raymond’s is the borough’s only Catholic cemetary. It also gets a staggering 4,000 new residents each year. It is home to the famous and infamous; everyone from, Typhoid Mary and Billie Holiday to an assortment of bishops and even mobsters."
                             };
    
    NSDictionary *bronx5 = @{
                             @"name" : @"Grand Central Monoliths",
                             @"url" : @"http://www.atlasobscura.com/places/grand-central-monoliths",
                             @"lat" : @40.894161,
                             @"lng" : @-73.896757,
                             @"address" : @"6089-6115 Broadway, Bronx, New York, 10471, United States",
                             @"description" : @"On the side of a walking trail in a wooded Bronx park sits a row of small monoliths made up of a variety of stones, evenly spaced, with no markings except the familiar run of graffiti."
                             };
    
    NSDictionary *queens1 = @{
                              @"name" : @"Valencia Movie House",
                              @"url" : @"http://www.atlasobscura.com/places/tabernacle-prayer-for-all-people-church",
                              @"lat" : @40.728364,
                              @"lng" : @-73.794878,
                              @"address" : @"74-24 175th Street, Queens, New York, 11366, United States",
                              @"description" : @"The Vatican of the movie industry turned into an actual church"
                              };
    
    NSDictionary *queens2 = @{
                              @"name" : @"A Panorama View Of New York City",
                              @"url" : @"http://www.atlasobscura.com/places/a-panorama-view-of-new-york-city",
                              @"lat" : @40.739714,
                              @"lng" : @-73.840785,
                              @"address" : @"New York City Building, Flushing Meadows Corona Park Queens, Queens, New York, 11375, United States",
                              @"description" : @"An incredibly realistic model of all five boroughs in New York City. The model now contains over 895,000 individual structures, including every building in the city that was standing before 1992."
                              };
    
    NSDictionary *queens3 = @{
                              @"name" : @"Flushing Meadows Corona Park",
                              @"url" : @"http://www.atlasobscura.com/places/flushing-meadows",
                              @"lat" : @40.749272,
                              @"lng" : @-73.848856,
                              @"address" : @"Kennedy Circle, Queens, New York, 11368, United States",
                              @"description" : @"The remnants of two World's Fairs are here, complete with a 12-story globe, a mini-Manhattan, and a UFO shaped pavilion"
                              };
    
    NSDictionary *queens4 = @{
                              @"name" : @"Louis Armstrong House",
                              @"url" : @"http://www.atlasobscura.com/places/louis-armstrong-house",
                              @"lat" : @40.754579,
                              @"lng" : @-73.861519,
                              @"address" : @"34-56 107th Street, Queens, New York, 11368, United States",
                              @"description" : @"Despite his international fame and acclaim, jazz legend Louis Armstrong retired to an unpretentious home in a quiet Queens neighborhood, which is now a museum dedicated to the musician."
                              };
    
    NSDictionary *queens5 = @{
                              @"name" : @"The Underground Home",
                              @"url" : @"http://www.atlasobscura.com/places/the-underground-home-2",
                              @"lat" : @40.740310,
                              @"lng" : @-73.848975,
                              @"address" : @"Flushing Meadows-Corona Park, 11101 Corona Ave, Queens, New York, 11368, United States",
                              @"description" : @"A hyper-luxurious, 12,000- square foot home might be buried beneath Queens, still waiting to protect you from nuclear missiles",
                              };
    
    NSDictionary *queens6 = @{
                              @"name" : @"Fort Totten",
                              @"url" : @"http://www.atlasobscura.com/places/fort-totten",
                              @"lat" : @40.792743,
                              @"lng" : @-73.776613,
                              @"address" : @"Weaver Road, Queens, New York, 11359, United States",
                              @"description" : @"If you look at the MTA subway map, in the top right hand corner is a legend explaining what the different symbols on the map mean. But hidden underneath this legend is the location of an abandoned Civil War fort, now an obscure underfunded city park."
                              };
    
    NSDictionary *queens7 = @{
                              @"name" : @"The Abandoned Rockaway Beach Branch of the Railroad",
                              @"url" : @"http://www.atlasobscura.com/places/the-abandoned-rockaway-beach-branch-of-the-long-island-railroad",
                              @"lat" : @40.719171,
                              @"lng" : @-73.861268,
                              @"address" : @"66th Avenue, Rego Park, Queens, New York, 11374, United States",
                              @"description" : @"A once crucial portion of the Long Island railroad still lays abandoned, waiting to be turned into an urban park"
                              };
    
    NSDictionary *queens8 = @{
                              @"name" : @"Houdini's Grave",
                              @"url" : @"http://www.atlasobscura.com/places/houdinis-grave",
                              @"lat" : @40.693814,
                              @"lng" : @-73.886369,
                              @"address" : @"Machpelah Cemetery, 82-30 Cypress Hills Street, Queens, New York, 11385, United States",
                              @"description" : @"The final resting place of the great escape artist, where some still gather to wait for his escape from death"
                              };
    
    NSDictionary *queens9 = @{
                              @"name" : @"Surreal ELevator",
                              @"url" : @"http://www.atlasobscura.com/places/surreal-elevator",
                              @"lat" : @40.738729,
                              @"lng" : @-73.918647,
                              @"address" : @"4816 47th Street, Woodside, New York, 11377, United States",
                              @"description" : @"Nondescript elevator doors open to reveal a stunning, surreal world"
                              };
    
    NSDictionary *queens10 = @{
                               @"name" : @"Flux Factory",
                               @"url" : @"http://www.atlasobscura.com/places/flux-factory",
                               @"lat" : @40.752666,
                               @"lng" : @-73.934976,
                               @"address" : @"39-31 29th Street, Queens, New York, 11101, United States",
                               @"description" : @"Offbeat arts organization that hosts exhibitions, events, and explorations"
                               };
    
    NSDictionary *queens11 = @{
                               @"name" : @"RMS Titanic Memorial",
                               @"url" : @"http://www.atlasobscura.com/places/rms-titanic-memorial",
                               @"lat" : @40.744817,
                               @"lng" : @-73.951197,
                               @"address" : @"47-08 11th Street, Queens, New York, 11101, United States",
                               @"description" : @"Over 1500 passengers and crew members lost their lives when the \"unsinkable\" RMS Titanic collided with an iceberg on the evening of April 14, 1912. It wasn't until seventy-two years later, however, that Joseph Colletti decided to erect his own memorial for the steamship, once considered the largest in the world"
                               };
    
    NSDictionary *brooklyn1 = @{
                                @"name" : @"The Lab (Electric Warehouse)",
                                @"url" : @"http://www.atlasobscura.com/places/the-lab-electric-warehouse",
                                @"lat" : @40.679802,
                                @"lng" : @-73.943563,
                                @"address" : @"1428 Fulton St, brooklyn, 11216",
                                @"description" : @"The Lab—or as it’s known to the dance kids and hipsters, Electric Warehouse—is a massive, 10,000-square-foot underground party space deep in Bed-Stuy."
                                };
    
    NSDictionary *brooklyn2 = @{
                                @"name" : @"Grand Army Plaza",
                                @"url" : @"http://www.atlasobscura.com/places/grand-army-plaza",
                                @"lat" : @40.673559,
                                @"lng" : @-73.968419,
                                @"address" : @"1 Grand Army Plaza, Brooklyn, New York, 11238, United States",
                                @"description" : @"Little do passers-by know, sitting just behind the entrance at the base of the arch is a storage and display space for the puppet lending library."
                                };
    
    NSDictionary *brooklyn3 = @{
                                @"name" : @"Brooklyn Botanic Garden",
                                @"url" : @"http://www.atlasobscura.com/places/brooklyn-botanic-garden",
                                @"lat" : @40.667716,
                                @"lng" : @-73.961836,
                                @"address" : @"900 Washington Avenue, Brooklyn, New York, 11238, United States",
                                @"description" : @"As you enjoy a leisurely walk through the beautiful Brooklyn Botanic Gardens, you may notice the intoxicating smell. That is the Titan Arum, poisoning the air with its rare blooming smell."
                                } ;
    
    NSDictionary *brooklyn4 = @{
                                @"name" : @"Campderdown Elm",
                                @"url" : @"http://www.atlasobscura.com/places/campderdown-elm",
                                @"lat" : @40.660204,
                                @"lng" : @-73.968956,
                                @"address" : @"Prospect Park, Brooklyn, New York, 11225, United States",
                                @"description" : @"The strangest tree in Brooklyn may be the gnarled branches of the Camperdown Elm near the Prospect Park boathouse. Its branches grow parallel to the ground instead of up, requiring extra support, so gazing up from beneath it is like standing beneath a giant bonsai."
                                };
    
    NSDictionary *brooklyn5 = @{
                                @"name" : @"Brooklyn Superhero Supply Store",
                                @"url" : @"http://www.atlasobscura.com/places/brooklyn-superhero-supply-store",
                                @"lat" : @40.671416,
                                @"lng" : @-73.984742,
                                @"address" : @"372 5th Avenue, Brooklyn, New York, 11215, United States",
                                @"description" : @"The one-stop shop for all of your superhero (or evil arch-nemesis) needs. Behind a false bookcase there is a secret lair that plays host to an after-school student writing center co-founded by best-selling writer Dave Eggers."
                                };
    
    NSDictionary *brooklyn6 = @{
                                @"name" : @"Wyckoff Street Mosaic",
                                @"url" : @"http://www.atlasobscura.com/places/mosaic-facade",
                                @"lat" : @40.685436,
                                @"lng" : @-73.989678,
                                @"address" : @"108 Wyckoff Street, Brooklyn, New York, 11201, United States",
                                @"description" : @"In 2001, Susan Gardner began attaching things to the facade of her three-story brownstone in Boerum Hill. Incorporating anything from shells and buttons to broken cups and old CDs, Gardner's growing mosaic became an icon of the neighborhood."
                                };
    
    NSDictionary *brooklyn7 = @{
                                @"name" : @"Morbid Anatomy Museum",
                                @"url" : @"http://www.atlasobscura.com/places/the-morbid-anatomy-museum",
                                @"lat" : @40.672872,
                                @"lng" : @-73.990131,
                                @"address" : @"424A Third Avenue, Brooklyn, New York, 11215, United States",
                                @"description" : @"A museum devoted to bringing to light forgotten or neglected histories through exhibitions, education and public programming."
                                };
    
    
    NSArray *stuffz = @[
                        atlasObs1,
                        atlasObs2,
                        atlasObs3,
                        atlasObs4,
                        atlasObs5,
                        atlasObs6,
                        atlasObs7,
                        atlasObs8,
                        atlasObs9,
                        atlasObs11,
                        atlasObs12,
                        atlasObs13,
                        atlasObs14,
                        atlasObs15,
                        atlasObs16,
                        atlasObs17,
                        atlasObs18,
                        atlasObs19,
                        atlasObs20,
                        atlasObs21,
                        atlasObs22,
                        atlasObs23,
                        atlasObs24,
                        atlasObs25,
                        atlasObs26,
                        atlasObs27,
                        atlasObs28,
                        atlasObs29,
                        atlasObs30,
                        atlasObs31,
                        atlasObs32,
                        atlasObs33,
                        atlasObs34,
                        atlasObs35,
                        atlasObs36,
                        atlasObs37,
                        atlasObs38,
                        atlasObs39,
                        atlasObs40,
                        atlasObs41,
                        atlasObs42,
                        atlasObs43,
                        atlasObs44,
                        atlasObs45,
                        atlasObs46,
                        vipRecsBen,
                        vipRecsCory,
                        vipRecsJames,
                        vipRecsTanner,
                        vipRecsOrta,
                        vipRecsMatan,
                        vipRecsRachel,
                        vipRecsCameron,
                        statenIsland1,
                        statenIsland2,
                        statenIsland3,
                        statenIsland4,
                        statenIsland5,
                        statenIsland6,
                        queens1,
                        queens2,
                        queens3,
                        queens4,
                        queens5,
                        queens6,
                        queens7,
                        queens8,
                        queens9,
                        queens10,
                        queens11,
                        bronx1,
                        bronx2,
                        bronx3,
                        bronx4,
                        bronx5,
                        brooklyn1,
                        brooklyn2,
                        brooklyn3,
                        brooklyn4,
                        brooklyn5,
                        brooklyn6,
                        brooklyn7
                        ];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in stuffz) {
        SeekNYCParks *park = [[SeekNYCParks alloc] init];
        
        park.name = dict[@"name"];
        park.address = dict[@"address"];
        park.detail = dict[@"description"];
        park.landmarkLat = [dict[@"lat"] floatValue];
        park.landmarkLng = [dict[@"lng"] floatValue];
        
        [arr addObject:park];
    }
    
    return arr;
}

@end
