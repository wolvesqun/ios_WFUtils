//
//  WFActionProtocol.h
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFRequestServlet.h"

@protocol WFActionProtocol <NSObject>

@optional
/**
 *  如果找不到action，就默认执行这个方法
 */
- (void)actionExecute;


@end
