//
//  UINavigationController+WFExtension.h
//  WFUtils
//
//  Created by PC on 4/4/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <UIKit/UIKit.h>

// - 返回键点击回调协议
@protocol WFButtonBackProtocol <NSObject>

- (BOOL)navigationShouldPopOnBackButton;

@end

@interface UINavigationController (WFExtension)

// - 
- (void)popToViewControllerWithClass:(Class)clazz animated:(BOOL)animated;

@end
