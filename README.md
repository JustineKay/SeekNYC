#SeekNYC - Uncover Your City
####Team Members: Christella Dolmo, Justine Kay, Felicia Weathers####

## Description  

How much do you really know New York City?  Don't get stuck in the same old routines!  SeekNYC is a fun way to discover places you haven’t visited in NYC’s five boroughs. Explore and uncover a map of NYC as you seek out new adventures.  
***[Now available in the iTunes App store](https://itunes.apple.com/ky/app/seeknyc-uncover-your-city/id1060650721?mt=8)***

## The Problem

Even with so much to see and do in the big apple, it's easy to get stuck in the same old routine and repeat the same paths to similar destinations.  

Most tourists only see a small percentage of what NYC has to offer.

Most geolocation apps (Foursquare, Swarm) reward us for repeatedly checking in to the same places, over and over again.

In NYC, how can we motivate people to discover other locations around the city outside of where they live and work, and encourage tourists to step outside of Manhattan and visit more of the other 4 boroughs?

## The Solution

A real-life game that reveals how much of NYC you've actually explored and gives you suggestions for uncovering more of the map.  
The app tracks your movement as you trek through the city and reveals an underlying map of NYC in full color and detail. It shows you what percentage of the 5 boroughs you've actually uncovered.  You can choose between 4 different skins for the opaque overlay on the map.

You can also shake your device to receive recommendations for exploring places outside of your uncovered area and then get directions. 

#### Features:
* User's map is saved in Core Data.  
* User can view percentage of uncovered area in each borough.  
* User can shake device for recommendations of landmarks, parks, and hidden spots outside of their uncovered area.  
* Recommendations are pulled from the Foursquare API and Atlas Obscura's Hidden spots of NYC.  
* User can obtain directions to recommended places by tapping on the "directions" icon in the map annotation callout view.

<img src="https://github.com/JustineKay/SeekNYC/blob/master/Images/SeekNYC-screenshot-website1.jpg" width=220 />
<img src="https://github.com/JustineKay/SeekNYC/blob/master/Images/SeekNYC-screenshot-website2.jpg" width=220 />
<img src="https://github.com/JustineKay/SeekNYC/blob/master/Images/SeekNYC-screenshot-website3.jpg" width=220 />
<img src="https://github.com/JustineKay/SeekNYC/blob/master/Images/SeekNYC-screenshot-website4.jpg" width=220 />
<img src="https://github.com/JustineKay/SeekNYC/blob/master/Images/SeekNYC-screenshot-website5.jpg" width=220 />
<img src="https://github.com/JustineKay/SeekNYC/blob/master/Images/SeekNYC-screenshot-website6.jpg" width=220 />
<img src="https://github.com/JustineKay/SeekNYC/blob/master/Images/SeekNYC-screenshot-website7.jpg" width=220 />


#### Timeline
| Week | Date | Sprint |
|----|----|---|
| Week 0 | Nov 3 - 5 | Research: Submit project proposal (11/5). Create wireframes. Research, research, research. |
| Week 1 | Nov 6 - 10 | Development I: Brainstorm awards and acheivements. Research custom map options.  More wireframing. |
| Week 2 | Nov 11 - 17 | Development II & FIRST RELEASE(11/17): Get MVP up & running. Set up Core Data. Set up map and overlay; draw a clear polyline where user is tracked. Calculate area of NYC uncovered.  |
| Week 3 | Nov 18 - 24 | Development III & SECOND RELEASE(11/24): Testing. Create map grid; transfer to tracking user's uncovered area by map grid. Conceptualize look & design. Design & create logo.  Revise demo script. |
| Week 4 | Nov 25 - Dec 1 | Testing & THIRD RELEASE(12/1): Testing.  Implement tracking user's borough info by zip code. Connect to Foursquare API for recommendations/suggestedVenues. Revise demo script. Add shake gesture feature.  Customize annotation markers.|
| Week 5 | Dec 2 - Dec 7 | Final Push & DEMO DAY- Dec 8, 7pm : Finalize app. Make userProfileVC constraints applicable to devices of all sizes.  Refine Foursquare API parsing. Add Atlas Obscura data. Create personal slides and revise final deck for presentation.  Revise final demo script.  |

#### Team Member Responsibilities

**Christella:**

- Wireframing in Sketch
- Presentation slides for first releases
- Progress Bar Implementation
- Foursquare API Implementation
- Randomization of suggested places and webview to Google maps

**Justine:**

- Backend and Core Data Management
- Map grid implementation
- Map overlay implementation & path clearing
- Borough tracking implementation
- Demo script and pitch
- Presentation slides for final release
- Logo Design
- User Interface Design
- Custom skin (map overlay color) alertVC implementation
- Custom mapview animated annotations

**Felicia:**

- Implement shake gesture and one time alertView notification for shake gesture (NSUserDefault)
- Alert View Controllers
- Research customizing map
- Atlas Obscura Data
- Menu Bar Implementation

**With endless thanks to Orta Therox :)**  
This project was inspired by the app "Fog Of World"  
http://en.fogofworld.com/  
  
  
#### Features On Our Wishlist To Implement In Future Versions:  
* User can acheive awards and obtain certain levels for visiting specific places, traveling new routes, and avoiding well-known tourist traps.
* User can view a Subway count of all the stations they've been to.  
* User can recieve notifications of places to visit just outside of routes they travel frequently.
* User's tracks appear different when they've taken the same route multiple times.
* User can share maps on twitter and facebook.
* User can track walking, biking and driving seperately
* User can view other user's maps in app
* User can drop markers, with photos and notes (Peek & Pop)
* User includes where they live in the sign up process to determine whether they experience the app as a visitor or resident. 
* User experience is slightly different depending on whether they are a visitor or resident.



