//
//  LocationAnnotationView.m
//  customAnnotation
//
//  Created by Z on 2018/3/9.
//  Copyright © 2018年 Z. All rights reserved.
//

#import "LocationAnnotationView.h"
#import "LocationView.h"
#import "LocationAnnoation.h"

@interface LocationAnnotationView ()

@property (nonatomic, strong) LocationView *locview;
@end


@implementation LocationAnnotationView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.locview = [[NSBundle mainBundle] loadNibNamed:@"LocationView" owner:self options:nil][0];
        self.bounds = self.locview.bounds;
        [self addSubview:self.locview];
    }
    return self;
}



+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView {
    static NSString *ItemID = @"LocationAnnotationView";
    
    //不知道为什么，在iOS11上创建不出来，在iOS9上可以创建出来。
    //LocationAnnotationView *annotationview = (LocationAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ItemID];
   
    LocationAnnotationView *annotationview = [[LocationAnnotationView alloc] initWithFrame:CGRectZero];
    
    if (!annotationview) {
        annotationview = [[LocationAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ItemID];
    }
    return annotationview;
}


- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    LocationAnnoation *anno = (LocationAnnoation *)annotation;
    
    NSLog(@"%@",anno.location.title);
       
    [self.locview.titleLabel setText:anno.location.title];
    
    [self.locview.iconImage sd_setImageWithURL:[NSURL URLWithString:anno.location.thumbimg] placeholderImage:[UIImage imageNamed:@"lufei"]];
    
}



@end
