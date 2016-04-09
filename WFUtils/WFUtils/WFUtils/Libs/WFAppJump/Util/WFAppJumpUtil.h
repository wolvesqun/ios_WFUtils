//
//  WFAppJumpUtil.h
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFAppJumpUtil : NSObject

+ (NSString *)buildParameterStringWithDict:(NSDictionary *)dict;

+ (NSString *)getBundleIdentifier;
// - 获取源应用名称
+ (NSString *)getBundleName;

+ (NSString *)encodeUTF_8:(NSString *)source;
+ (NSString *)decodeUTF_8:(NSString *)source;

@end
