//
//  UIView+WFExtension.h
//  WFUtils
//
//  Created by PC on 4/4/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WFExtension)

@end

@interface UIView (WFExtensionFrame)

#pragma mark - 设置视图中心
// - 设置自身在父视图中心
- (void)setCenterInParentWithParent:(UIView *)view;
- (void)setVerticleCenterInParentWithParent:(UIView *)view;
- (void)setHorizontalCenterInParentWithParent:(UIView *)view;

#pragma mark - 移动中心距离
- (void)moveCenterHorizontal:(CGFloat)x;
- (void)moveCenterVertical:(CGFloat)y;

#pragma mark - 获取frame相关
- (CGFloat)getWidth;
- (CGFloat)getHeight;
- (CGFloat)getOringinX;
- (CGFloat)getOringinY;



@end
