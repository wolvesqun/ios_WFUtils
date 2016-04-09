//
//  WFRequestServlet.m
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import "WFRequestServlet.h"
#import "WFAppJumpUtil.h"

@interface WFRequestServlet ()
/*** 参数 ***/
@property (strong, nonatomic) NSMutableDictionary *paramDict;
/*** 模块，相当于原来的host ***/
@property (strong, nonatomic) NSString *module;
/*** 响应控制器 ***/
@property (strong, nonatomic) NSString *ctroller;
/*** 响应方法 ***/
@property (strong, nonatomic) NSString *action;

@end

@implementation WFRequestServlet

- (instancetype)init
{
    if(self = [super init])
    {
        self.paramDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setOriginURLString:(NSString *)originURLString
{
    _originURLString = originURLString;
    
    // 1. 清除上一次数据
    [self.paramDict removeAllObjects];
    self.module = nil;
    self.ctroller = nil;
    self.action = nil;
    
    NSRange range1= [self.originURLString rangeOfString:@"://"];
    NSRange range2= [self.originURLString rangeOfString:@"?"];
    
    if(range1.location != NSNotFound && range1.length > 0)
    {
        
        NSString *URLFront = nil;
        NSString *parameterString = nil;
        if(range2.location != NSNotFound && range2.length > 0)
        {
            URLFront = [self.originURLString substringWithRange:NSMakeRange(range1.location + range1.length, range2.location - range1.location - range1.length)];
            parameterString = [self.originURLString substringWithRange:NSMakeRange(range2.location + range2.length, self.originURLString.length - range2.location - 1)];
        }
        else
        {
            URLFront = [self.originURLString substringWithRange:NSMakeRange(range1.location + range1.length, self.originURLString.length - range1.location - range1.length)];
        }
        
        [self handleURLFront:URLFront];
        [self handleParameter:parameterString];
    }
    
    
    
}


#pragma mark -
// - 处理请求地址
- (void)handleURLFront:(NSString *)URLFront
{
    if(URLFront.length > 0)
    {
        NSArray *tempArray = [URLFront componentsSeparatedByString:@"/"];
        if(tempArray.count >= 1)
        {
            self.module = [tempArray objectAtIndex:0];
        }
        if (tempArray.count >= 2)
        {
            self.ctroller = [tempArray objectAtIndex:1];
        }
        if(tempArray.count >= 3)
        {
            self.action = [tempArray objectAtIndex:2];
        }
    }
    
}
// - 处理参数
- (void)handleParameter:(NSString *)paraStr
{
    if(paraStr.length > 0)
    {
        NSArray *tempArray = [paraStr componentsSeparatedByString:@"&"];
        for (NSString *keyValueString in tempArray) {
            if(keyValueString.length != 0 && ![keyValueString isEqualToString:@""])
            {
                NSRange myRange = [keyValueString rangeOfString:@"="];
                NSString *key = [keyValueString substringToIndex:myRange.location];
                NSString *value = [keyValueString substringFromIndex:myRange.location + 1];
                if(key && key.length > 0 && value && value.length > 0)
                {
                    [self.paramDict setObject:value forKey:key];
                    //                    NSLog(@"key = %@,   value = %@", key, value);
                }
                
            }
        }
    }
}

#pragma mark - 获取参数
- (NSString *)getParameter:(NSString *)key
{
    if(key && key.length > 0)
    {
        NSString *value = [self.paramDict objectForKey:key];
        if(value)
        {
            value = [WFAppJumpUtil decodeUTF_8:value];
        }
        return value;
    }
    return @"";
}

// - 获取源bundle identifier（由哪个应用跳转过来的bundle ID）
- (NSString *)getBundleIdentifier
{
    return [self getParameter:kWFBundleIdentifier];
}
// - 获取源应用名称
- (NSString *)getBundleName
{
    return [self getParameter:kWFBundleDisplayName];
}


- (NSString *)getCtroller
{
    return self.ctroller;
}

- (NSString *)getAction
{
    return self.action;
}
- (NSDictionary *)getAllParam
{
    return self.paramDict;
}

@end
