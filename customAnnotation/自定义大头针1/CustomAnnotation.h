//
//  CustomAnnotation.h
//  customAnnotation
//
//  Created by Z on 2017/11/22.
//  Copyright © 2017年 Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AnnotationModel.h"

@interface CustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic,strong) Data * annotModel;
@property (nonatomic,readwrite) CLLocationCoordinate2D coordinate;

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView
                                          annotation:(id <MKAnnotation>)annotation
                                                icon:(NSString *)icon
                                               label:(NSString *)label;

@end
