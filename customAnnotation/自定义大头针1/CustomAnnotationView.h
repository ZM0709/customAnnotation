//
//  CustomAnnotationView.h
//  customAnnotation
//
//  Created by Z on 2017/11/22.
//  Copyright © 2017年 Z. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomAnnotationView : MKAnnotationView
- (id)initWithAnnotation:(id <MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
                    icon:(NSString *)icon
                   label:(NSString *)label;
@end
