//
//  NYHiddenLocations.m
//  SeekNYC
//
//  Created by Felicia Weathers on 12/5/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import "NYHiddenLocations.h"

@implementation NYHiddenLocations

+ (NSArray *)hiddenLocations {
NSDictionary *atlasObs1 = @{
                           @"name" : @"Bristol Basin",
                           @"url" : @"http://www.atlasobscura.com/places/bristol-basin",
                           @"lat" : @40.667253,
                           @"lng" : @73.911550,
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
                            @"lat" : @40.714353,
                            @"lng" : @-73.997976,
                            @"address" : @"Doyers Street, New York, New York, 10013, United States",
                            @"description" : @"An accidentally hidden library containing the ephemeral history of New York"
                            };

/*
 NSDictionary *atlasObs10 = @{
	@"name" : @"City Hall Library",
	@"url" : @"http://www.a/places/city-hall-librarytlasobscura.com",
	@"lat" : @40.714353,
	@"lng" : @-73.997976,
	@"address" : @"31 Chambers Street, Room 112, New York,
 New York, 10007, United States",
 };
 */

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
                             @"lng": @ -73.998174,
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
                             @"lng" : @40.713649,
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
                             @"lng": @-74.010358,
                             @"address" : @"56 Beaver Street, New York, New York, 10004, United States",
                             @"description" : @"The entrance is made of two marble columns taken from Pompeii"
                             };

NSDictionary *atlasObs32 = @{
                             @"name" : @"Dream House",
                             @"url" : @"http://www.atlasobscura.com/places/dream-house",
                             @"lat": @40.718477,
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
                             @"lng" : @73.998625,
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
    return 0;
}

@end
