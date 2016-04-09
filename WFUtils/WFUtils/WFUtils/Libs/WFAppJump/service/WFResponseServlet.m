//
//  WFResponseServlet.m
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import "WFResponseServlet.h"

@implementation WFResponseServlet

- (BOOL)sendMessageToAppWithAppKey:(NSString *)appKey
                         andModule:(NSString *)module
                       andCtroller:(NSString *)ctroller
                         andAction:(NSString *)action
                      andParameter:(NSDictionary *)parameter
{
    if(appKey.length > 0 && module.length > 0 && ctroller.length > 0 && action.length > 0)
    {
        NSString *paramString = [WFAppJumpUtil buildParameterStringWithDict:parameter];
        NSString *URLString = [NSString stringWithFormat:@"%@://%@/%@/%@?%@",appKey, module, ctroller, action, paramString];
        return [self sendMessageToAppWithURLString:URLString];
    }
    return NO;
}

- (BOOL)sendBundleIdNameMessageToAppWithAppKey:(NSString *)appKey
                                     andModule:(NSString *)module
                                   andCtroller:(NSString *)ctroller
                                     andAction:(NSString *)action
                                  andParameter:(NSDictionary *)parameter
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if(parameter != nil)
    {
        [dict setDictionary:parameter];
    }
    [dict setObject:[WFAppJumpUtil getBundleIdentifier] forKey:kWFBundleIdentifier];
    [dict setObject:[WFAppJumpUtil getBundleName] forKey:kWFBundleDisplayName];
    
    return [self sendMessageToAppWithAppKey:appKey andModule:module andCtroller:ctroller andAction:action andParameter:dict];
}

- (BOOL)sendMessageToAppWithURLString:(NSString *)URLString
{
    if(URLString.length > 0)
    {
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }
    return NO;
}

- (void)sendMessageToAppWithAppKey:(NSString *)appKey
{
    if(appKey.length > 0)
    {
        if([appKey rangeOfString:@"://"].length == 0)
        {
            appKey = [appKey stringByAppendingString:@"://"];
        }
        [self sendMessageToAppWithURLString:appKey];
    }
    
}

@end
