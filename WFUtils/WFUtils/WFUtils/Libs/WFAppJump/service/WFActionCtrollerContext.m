//
//  WFActionCtrollerContext.m
//  testAppJump
//
//  Created by mba on 16/3/18.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import "WFActionCtrollerContext.h"

@interface WFActionCtrollerContext ()

@property (strong, nonatomic) NSMutableDictionary *actionCtrDict;

@property (strong, nonatomic) id defaultActionCtroller;

@end

@implementation WFActionCtrollerContext

@synthesize defaultActionCtroller = _defaultActionCtroller;

#pragma mark - init
+ (instancetype)getContext
{
    static WFActionCtrollerContext *context;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(context == nil)
        {
            context = [WFActionCtrollerContext new];
        }
    });
    return context;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.actionCtrDict = [NSMutableDictionary dictionary];
        //        self.defaultAction = [WFActionSupport new];
    }
    return self;
}

#pragma mark -
- (void)setCtroller:(id)ctroller forKey:(NSString *)key
{
    if(key && ctroller)
    {
        [self.actionCtrDict setObject:ctroller forKey:key];
    }
}
- (void)setDefaultActionCtroller:(id)defaultActionCtroller
{
    if(defaultActionCtroller)
    {
        _defaultActionCtroller = defaultActionCtroller;
    }
}

- (id)ctrollerForKey:(NSString *)key
{
    id actionCtr = nil;
    if(key && key.length > 0)
    {
        actionCtr = [self.actionCtrDict objectForKey:key];
    }
    if(actionCtr == nil)
    {
        actionCtr = self.defaultActionCtroller;
    }
    return actionCtr;
}

- (BOOL)hasActionCtroller
{
    return self.actionCtrDict.count > 0;
}

#pragma mark -
- (id)defaultActionCtroller
{
    if(_defaultActionCtroller == nil)
    {
        _defaultActionCtroller = [WFDefaultActionCtroller new];
    }
    return _defaultActionCtroller;
}

@end
