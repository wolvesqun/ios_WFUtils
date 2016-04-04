//
//  UIView+WFExtension.m
//  WFUtils
//
//  Created by PC on 4/4/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "UIView+WFExtension.h"

@implementation UIView (WFExtension)

@end

@implementation UIView (WFExtensionFrame)

#pragma mark - 设置视图中心
// - 设置自身在父视图中心
- (void)setCenterInParentWithParent:(UIView *)parentView
{
    self.center = CGPointMake(parentView.frame.size.width / 2, parentView.frame.size.height / 2);
}

- (void)setVerticleCenterInParentWithParent:(UIView *)parentView
{
    self.center = CGPointMake(self.center.x, parentView.frame.size.height / 2);
}

- (void)setHorizontalCenterInParentWithParent:(UIView *)parentView
{
    self.center = CGPointMake(parentView.frame.size.width / 2, self.center.y);
}

// - 设置子视图中心
- (void)setChildCenterWithChild:(UIView *)view
{
    [view setCenterInParentWithParent:self];
}

- (void)setChildVerticalCenterWithChild:(UIView *)view
{
    [view setVerticleCenterInParentWithParent:self];
}

- (void)setChildHorizontalCenterWithChild:(UIView *)view
{
    [view setVerticleCenterInParentWithParent:self];
}

#pragma mark - 移动中心距离
- (void)moveCenterHorizontal:(CGFloat)x
{
    self.center = CGPointMake(self.center.x + x, self.center.y);
}
- (void)moveCenterVertical:(CGFloat)y
{
    self.center = CGPointMake(self.center.x, self.center.y + y);
}
- (void)moveCenterHorizontalForChildWithView:(UIView *)view andX:(CGFloat)x
{
    [view moveCenterHorizontal:x];
}
- (void)moveCenterVerticalForchildWithView:(UIView *)view andY:(CGFloat)y
{
    [view moveCenterVertical:y];
}

#pragma mark - 获取frame相关参数
- (CGFloat)getWidth
{
    return self.frame.size.width;
}

- (CGFloat)getHeight
{
    return self.frame.size.height;
}

- (CGFloat)getOringinX
{
    return self.frame.origin.x;
}

- (CGFloat)getOringinY
{
    return self.frame.origin.y;
}

@end
