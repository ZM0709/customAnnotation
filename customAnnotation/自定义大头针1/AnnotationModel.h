//
//  AnnotationModel.h
//  customAnnotation
//
//  Created by Z on 2017/11/21.
//  Copyright © 2017年 Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Data;
@interface AnnotationModel : NSObject


@property (nonatomic, assign) NSInteger pageindex;

@property (nonatomic, strong) NSArray<Data *> *data;

@property (nonatomic, assign) NSInteger pagesize;

@property (nonatomic, assign) NSInteger total;

@end


@interface Data : NSObject

@property (nonatomic, copy) NSString *star;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *range;

@property (nonatomic, copy) NSString *thumbimg;

@property (nonatomic, copy) NSString *lng;

@property (nonatomic, copy) NSString *dec;

@property (nonatomic, copy) NSString *lat;

@end

