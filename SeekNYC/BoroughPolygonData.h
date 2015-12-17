//
//  CountyPolygonData.h
//  CountyPolygons
//
//  Created by Justine Gartner on 12/16/15.
//  Copyright © 2015 Justine Kay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoroughPolygon.h"

@interface BoroughPolygonData : NSObject

@property (nonatomic) BoroughPolygon *BKPolygon;
@property (nonatomic) BoroughPolygon *MANPolygon1;
@property (nonatomic) BoroughPolygon *MANPolygon2;
@property (nonatomic) BoroughPolygon *MANPolygon3;
@property (nonatomic) BoroughPolygon *BRXPolygon;
@property (nonatomic) BoroughPolygon *QNSPolygon;
@property (nonatomic) BoroughPolygon *SIPolygon;

-(void) initializeData;

@end
