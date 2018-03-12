//
//  CustomAnnotation.m
//  customAnnotation
//
//  Created by Z on 2017/11/22.
//  Copyright © 2017年 Z. All rights reserved.
//

#import "CustomAnnotation.h"
#import "CustomAnnotationView.h"

@implementation CustomAnnotation
+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id<MKAnnotation>)annotation icon:(NSString *)icon label:(NSString *)label {
    MKAnnotationView * annotationView =
    (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([CustomAnnotation class])];
    
    if (!annotationView) {
        annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([CustomAnnotation class]) icon:icon label:label];
    }
    return annotationView;
}

@end
