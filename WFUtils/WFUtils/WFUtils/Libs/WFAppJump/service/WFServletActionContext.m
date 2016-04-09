//
//  WFServletActionContext.m
//  testAppJump
//
//  Created by mba on 16/3/17.
//  Copyright © 2016年 ibmlib. All rights reserved.
//

#import "WFServletActionContext.h"



@interface WFServletActionContext ()

/*** request ***/
@property (strong, nonatomic) WFRequestServlet  *requestServlet;
/*** response ***/
@property (strong, nonatomic) WFResponseServlet *responseServlet;
/*** actionContext -> 处理器容器 ***/
@property (strong, nonatomic) WFActionCtrollerContext   *actionCtrollerContext;

@end

@implementation WFServletActionContext

#pragma mark - init
+ (instancetype)shareInstanced
{
    static WFServletActionContext *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(context == nil)
        {
            context = [WFServletActionContext new];
        }
    });
    return context;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.requestServlet = [[WFRequestServlet alloc] init];
        self.responseServlet = [[WFResponseServlet alloc] init];
        self.actionCtrollerContext = [WFActionCtrollerContext getContext];
    }
    return self;
}

#pragma mark - appDelegate 里调用
- (BOOL)handleURL:(NSURL *)URL
{
    NSRange range = [URL.absoluteString rangeOfString:@"mbalib-wiki2://wiki?"];
    
    BOOL bHandle = NO;
    
    if(range.length > 0)
    {
        NSString *back = [URL.absoluteString substringWithRange:NSMakeRange(range.length, URL.absoluteString.length - range.length)];
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"mbalib-wiki2://open/wiki/detail?%@",back]];
        
        NSString *URLString = URL.absoluteString;
        if(URLString.length > 0)
        {
            [self.requestServlet setOriginURLString:URLString];
            
            NSString *ctrollerKey = [self.requestServlet getCtroller];
            if(ctrollerKey.length > 0)
            {
                bHandle = YES;
                id actionCtrl = [self.actionCtrollerContext ctrollerForKey:ctrollerKey];
                NSString *actionKey = [self.requestServlet getAction];
                [self executeActionWithActionCtrl:actionCtrl andActionKey:actionKey];
                
            }
            
        }
    }
    
    
    
   
    return bHandle;
}

#pragma mark -
- (void)executeActionWithActionCtrl:(id)actionCtrl andActionKey:(NSString *)key
{
    if(actionCtrl && key.length > 0 && ![key isEqualToString:@""])
    {
        key = [key lowercaseString];
        SEL actionSeletor = NSSelectorFromString([NSString stringWithFormat:@"action%@",key]); // 小写
        // 1. 实现小写
        if([actionCtrl respondsToSelector:actionSeletor])
        {
            [actionCtrl performSelector:actionSeletor];
            return;
        }
        actionSeletor = NSSelectorFromString([NSString stringWithFormat:@"action%@:",key]); // 小写
        if([actionCtrl respondsToSelector:actionSeletor])
        {
            [actionCtrl performSelector:actionSeletor withObject:[self.requestServlet getAllParam]];
            return;
        }
        
        
        // 2. 实现大写
        key = [[key substringToIndex:1].uppercaseString stringByAppendingString:[key substringFromIndex:1]];
        SEL actionSelector2 = NSSelectorFromString([NSString stringWithFormat:@"action%@",key]); // 大写
        if([actionCtrl respondsToSelector:actionSelector2])
        {
            [actionCtrl performSelector:actionSelector2];
            return;
        }
        actionSelector2 = NSSelectorFromString([NSString stringWithFormat:@"action%@:",key]); // 大写
        if([actionCtrl respondsToSelector:actionSelector2])
        {
            [actionCtrl performSelector:actionSelector2 withObject:[self.requestServlet getAllParam]];
            return;
        }
        else if([actionCtrl respondsToSelector:@selector(actionExecute)])
        {
            [actionCtrl actionExecute];
        }
    }
}

#pragma mark - 获取容器相关参数
- (id)getRequestServlet
{
    return self.requestServlet;
}
- (id)getResponseServlet
{
    return self.responseServlet;
}

@end
