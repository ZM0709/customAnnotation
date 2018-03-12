//
//  LocationModel.h
//  customAnnotation
//
//  Created by Z on 2018/3/9.
//  Copyright © 2018年 Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject
@property (nonatomic,assign) NSInteger star;
@property (nonatomic,assign) NSInteger nameID;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * thumbimg;
@property (nonatomic,copy) NSString * lng;
@property (nonatomic,copy) NSString * lat;
@property (nonatomic,copy) NSString * dec;

@end
