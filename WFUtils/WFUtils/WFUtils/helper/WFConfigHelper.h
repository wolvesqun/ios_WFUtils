//
//  WFConfigHelper.h
//  BaiduWiki
//
//  Created by PC on 11/11/15.
//  Copyright © 2015 mplib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFConfigHelper : NSObject
// - get 方法
+ (BOOL)getBoolWithKey:(NSString *)key          andDefaultValue:(BOOL)defaultValue;
+ (NSString *)getStringWithKey:(NSString *)key  andDefaultValue:(NSString *)defaultValue;
+ (NSInteger)getIntegerWithKey:(NSString *)key  andDefaultValue:(NSInteger)defaultValue;
+ (float)getFloatWithKey:(NSString *)key        andDefaultValue:(float)defaultValue;

// - set 方法
+ (void)setBoolWithKey:(NSString *)key      andValue:(BOOL)value;
+ (void)setStringWithKey:(NSString *)key    andValue:(NSString *)value;
+ (void)setIntegerWithKey:(NSString *)key   andValue:(NSInteger)value;
+ (void)setFloatWithKey:(NSString *)key     andValue:(float)value;
@end
