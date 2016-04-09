//
//  WFServletActionContext.h
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFRequestServlet.h"
#import "WFResponseServlet.h"
#import "WFActionCtrollerContext.h"

@interface WFServletActionContext : NSObject

+ (instancetype)shareInstanced;

- (BOOL)handleURL:(NSURL *)URL;

- (id)getRequestServlet;

- (id)getResponseServlet;

@end
