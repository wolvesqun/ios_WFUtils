//
//  WFConfigHelper.m
//  BaiduWiki
//
//  Created by PC on 11/11/15.
//  Copyright © 2015 mplib. All rights reserved.
//

#import "WFConfigHelper.h"

#define WFUserDefault ([NSUserDefaults standardUserDefaults])

@implementation WFConfigHelper



#pragma mark - 系统配置项
// - get 方法
+ (BOOL)getBoolWithKey:(NSString *)key andDefaultValue:(BOOL)defaultValue{
    id obj = [WFUserDefault objectForKey:key];
    if(obj == nil){
        [self setBoolWithKey:key andValue:defaultValue];
        return defaultValue;
    }else{
        return [obj boolValue];
    }
}
+ (NSString *)getStringWithKey:(NSString *)key andDefaultValue:(NSString *)defaultValue{
    NSString *value = nil;
    id obj = [WFUserDefault objectForKey:key];
    if(obj == nil){
        [self setStringWithKey:key andValue:defaultValue];
        value =  defaultValue;
    }else{
        value = obj;
    }
    return value;
}
+ (NSInteger)getIntegerWithKey:(NSString *)key andDefaultValue:(NSInteger)defaultValue{
    NSInteger value;
    id obj = [WFUserDefault objectForKey:key];
    if(obj == nil){
        [self setIntegerWithKey:key andValue:defaultValue];
        value =  defaultValue;
    }else{
        value = [obj integerValue];
    }
    return value;
}
+ (float)getFloatWithKey:(NSString *)key andDefaultValue:(float)defaultValue{
    float value;
    id obj = [WFUserDefault objectForKey:key];
    if(obj == nil){
        [self setFloatWithKey:key andValue:defaultValue];
        value = defaultValue;
    }else{
        value = [obj floatValue];
    }
    return value;
}

// - set 方法
+ (void)setBoolWithKey:(NSString *)key andValue:(BOOL)value{
    NSNumber *objValue = [NSNumber numberWithBool:value];
    [[NSUserDefaults standardUserDefaults] setObject:objValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [WFUserDefault setObject:objValue forKey:key];
    
}
+ (void)setStringWithKey:(NSString *)key andValue:(NSString *)value{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [WFUserDefault setObject:value forKey:key];
}
+ (void)setIntegerWithKey:(NSString *)key andValue:(NSInteger)value{
    NSNumber *objValue = [NSNumber numberWithInteger:value];
    [[NSUserDefaults standardUserDefaults] setObject:objValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [WFUserDefault setObject:objValue forKey:key];
}
+ (void)setFloatWithKey:(NSString *)key andValue:(float)value{
    NSNumber *objValue = [NSNumber numberWithFloat:value];
    [[NSUserDefaults standardUserDefaults] setObject:objValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [WFUserDefault setObject:objValue forKey:key];
}

@end
