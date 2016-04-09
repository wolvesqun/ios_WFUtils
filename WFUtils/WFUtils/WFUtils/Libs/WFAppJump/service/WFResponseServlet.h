//
//  WFResponseServlet.h
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFAppJumpUtil.h"
#import "WFAppJumpCONST.h"

@interface WFResponseServlet : NSObject

/**
 *  向手机内部的其它应用发送消息(app跳转) (组成URLString结果为-> <appKey>://<module>/<ctroller>/<Action>?username=u1)
 *  
 *  @param appKey       app唯一标识（上面的myApp,与http作用一样，myApp表示自定义协议）
 *  @param actionKey    响应的处理器（上面的action）
 *  @param parameter    要传递的参数（username=u1）
 */
- (BOOL)sendMessageToAppWithAppKey:(NSString *)appKey
                         andModule:(NSString *)module
                       andCtroller:(NSString *)ctroller
                         andAction:(NSString *)action
                      andParameter:(NSDictionary *)parameter;

/**
 *  向手机内部的其它应用发送消息(参数多加 BundleId 和 BundleName)
 *
 *  @param appKey       app唯一标识
 *  @param action       响应的处理器
 *  @param parameter    要传递的参数
 *  
 *  @note            这个api带应用的bundleID和app名称
 */
- (BOOL)sendBundleIdNameMessageToAppWithAppKey:(NSString *)appKey
                                     andModule:(NSString *)module
                                   andCtroller:(NSString *)ctroller
                                     andAction:(NSString *)action
                                  andParameter:(NSDictionary *)parameter;


- (void)sendMessageToAppWithAppKey:(NSString *)appKey;

@end

























