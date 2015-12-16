//
//  CountyPolygonData.h
//  CountyPolygons
//
//  Created by Justine Gartner on 12/16/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountyPolygon.h"

@interface CountyPolygonData : NSObject

@property (nonatomic) CountyPolygon *BKPolygon;
@property (nonatomic) CountyPolygon *MANPolygon1;
@property (nonatomic) CountyPolygon *MANPolygon2;
@property (nonatomic) CountyPolygon *MANPolygon3;
@property (nonatomic) CountyPolygon *BRXPolygon;
@property (nonatomic) CountyPolygon *QNSPolygon;
@property (nonatomic) CountyPolygon *SIPolygon;

-(void) initializeData;

@end
