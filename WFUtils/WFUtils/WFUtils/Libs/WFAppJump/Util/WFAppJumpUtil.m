//
//  WFAppJumpUtil.m
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import "WFAppJumpUtil.h"

@implementation WFAppJumpUtil

+ (NSString *)buildParameterStringWithDict:(NSDictionary *)dict
{
    NSMutableString *paramString;
    if(dict && dict.count > 0)
    {
        paramString = [NSMutableString string];
        for (NSString *key in dict.allKeys) {
            NSString *value = [dict objectForKey:key];
            if(key.length > 0 && value.length > 0)
            {
                value = [self decodeUTF_8:value];
                [paramString appendFormat:@"%@=%@&", key, [self encodeUTF_8:value]];
            }
        }
        [paramString deleteCharactersInRange:NSMakeRange(paramString.length - 2, 1)];
    }
    return paramString == nil ? @"" : paramString;
}

// - 获取源bundle identifier（由哪个应用跳转过来的bundle ID）
+ (NSString *)getBundleIdentifier
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *bundleID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return bundleID;
}
// - 获取源应用名称
+ (NSString *)getBundleName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}

+ (NSString *)encodeUTF_8:(NSString *)source
{
    if(source == nil) return source;
    return [source stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+ (NSString *)decodeUTF_8:(NSString *)source
{
    if(source == nil) return source;
    return [source stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
