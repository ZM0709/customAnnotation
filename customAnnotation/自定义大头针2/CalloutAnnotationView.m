//
//  CalloutAnnotationView.m
//  customAnnotation
//
//  Created by Z on 2018/3/12.
//  Copyright © 2018年 Z. All rights reserved.
//

#import "CalloutAnnotationView.h"
#import "CalloutView.h"
#import "CalloutAnnotation.h"

@interface CalloutAnnotationView ()

@property (nonatomic, strong) CalloutView *calloutView;

@end


@implementation CalloutAnnotationView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.calloutView = [[NSBundle mainBundle] loadNibNamed:@"CalloutView" owner:self options:nil][0];
        self.bounds = self.calloutView.bounds;
        [self addSubview:self.calloutView];
    }
    return self;
}



+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView {
    static NSString *ItemID = @"CalloutAnnotationView";
    
    //不知道为什么，在iOS11上创建不出来，在iOS9上可以创建出来。
    //LocationAnnotationView *annotationview = (LocationAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ItemID];
    
    
    
    CalloutAnnotationView *annotationview = [[CalloutAnnotationView alloc] initWithFrame:CGRectZero];
    
    if (!annotationview) {
        annotationview = [[CalloutAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ItemID];
    }
    return annotationview;
}


- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    CalloutAnnotation *anno = (CalloutAnnotation *)annotation;
    
    NSLog(@"%@",anno.location.title);
    
    [self.calloutView.rightLabel setText:anno.location.title];

    
}


@end
