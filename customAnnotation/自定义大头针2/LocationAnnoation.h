//
//  LocationAnnoation.h
//  customAnnotation
//
//  Created by Z on 2018/3/9.
//  Copyright © 2018年 Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationModel.h"

@interface LocationAnnoation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) LocationModel *location;

@end
