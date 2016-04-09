//
//  WFActionCtrollerContext.h
//  testAppJump
//
//  Created by mba on 16/3/18.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFActionProtocol.h"
#import "WFDefaultActionCtroller.h"

@interface WFActionCtrollerContext : NSObject

#pragma mark - init
+ (instancetype)getContext;


#pragma mark -
- (void)setCtroller:(id)ctroller forKey:(NSString *)key;
- (void)setDefaultActionCtroller:(id)defaultActionCtroller;

- (id)ctrollerForKey:(NSString *)key;

- (BOOL)hasActionCtroller;

#pragma mark -
- (id)defaultActionCtroller;

@end
