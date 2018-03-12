//
//  LocationModel.m
//  customAnnotation
//
//  Created by Z on 2018/3/9.
//  Copyright © 2018年 Z. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"nameID" : @[@"id",@"ID",@"book_id"]};
}

@end
