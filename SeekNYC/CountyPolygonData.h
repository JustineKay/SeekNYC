//
//  CountyPolygonData.h
//  CountyPolygons
//
//  Created by Justine Gartner on 12/16/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYCPolygon.h"

@interface CountyPolygonData : NSObject

@property (nonatomic) NYCPolygon *BKPolygon;
@property (nonatomic) NYCPolygon *MANPolygon1;
@property (nonatomic) NYCPolygon *MANPolygon2;
@property (nonatomic) NYCPolygon *MANPolygon3;
@property (nonatomic) NYCPolygon *BRXPolygon;
@property (nonatomic) NYCPolygon *QNSPolygon;
@property (nonatomic) NYCPolygon *SIPolygon;

-(void) initializeData;

@end
