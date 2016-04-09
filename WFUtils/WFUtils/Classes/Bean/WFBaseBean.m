//
//  WFBaseBean.m
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFBaseBean.h"

@implementation WFBaseBean


+ (instancetype)beanWithDict:(NSDictionary *)dict
{
    return [self mj_objectWithKeyValues:dict];
}
@end
