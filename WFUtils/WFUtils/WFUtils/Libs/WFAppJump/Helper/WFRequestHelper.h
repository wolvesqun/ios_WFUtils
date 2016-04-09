//
//  WFRequestHelper.h
//  testAppJump
//
//  Created by mba on 16/3/18.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFRequestHelper : NSObject

+ (NSString *)getString:(NSString *)key;

+ (NSInteger)getInteger:(NSString *)key;

+ (float)getFloat:(NSString *)key;

+ (BOOL)getBOOL:(NSString *)key;

@end
