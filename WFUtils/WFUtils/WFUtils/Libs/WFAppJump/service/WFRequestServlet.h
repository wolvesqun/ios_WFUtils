//
//  WFRequestServlet.h
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFAppJumpCONST.h"

@interface WFRequestServlet : NSObject

/*** 原始请求地址 ***/
@property (strong, nonatomic) NSString *originURLString;

/**
 *  获取参数
 *
 *  @param key
 */
- (NSString *)getParameter:(NSString *)key;
- (NSDictionary *)getAllParam;

// - 获取源bundle identifier（由哪个应用跳转过来的bundle ID）
- (NSString *)getBundleIdentifier;
// - 获取源应用名称
- (NSString *)getBundleName;

// - 获取相关处理器
- (NSString *)getCtroller;
- (NSString *)getAction;


@end
