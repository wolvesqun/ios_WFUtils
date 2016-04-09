//
//  WFRequestHelper.m
//  testAppJump
//
//  Created by mba on 16/3/18.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import "WFRequestHelper.h"
#import "WFServletActionContext.h"

@implementation WFRequestHelper

+ (NSString *)getString:(NSString *)key
{
    WFRequestServlet *request = [[WFServletActionContext shareInstanced] getRequestServlet];
    NSString *value;
    if(request)
    {
        value = [request getParameter:key];
    }
    return value.length > 0 ? value : @"";
}

+ (NSInteger)getInteger:(NSString *)key
{
    return [[self getString:key] integerValue];
}

+ (float)getFloat:(NSString *)key
{
    return [[self getString:key] floatValue];
}

+ (BOOL)getBOOL:(NSString *)key
{
    return [[self getString:key] boolValue];
}

@end
