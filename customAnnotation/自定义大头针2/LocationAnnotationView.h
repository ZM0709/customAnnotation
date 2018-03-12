//
//  LocationAnnotationView.h
//  customAnnotation
//
//  Created by Z on 2018/3/9.
//  Copyright © 2018年 Z. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface LocationAnnotationView : MKAnnotationView

+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView;

@end
