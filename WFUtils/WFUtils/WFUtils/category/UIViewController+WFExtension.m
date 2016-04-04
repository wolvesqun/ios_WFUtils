//
//  UIViewController+WFExtension.m
//  WFUtils
//
//  Created by PC on 4/4/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "UIViewController+WFExtension.h"

@implementation UIViewController (WFExtension)



@end

@implementation UIViewController (WFExtensionKeyboard)

- (void)addNotificationWithObserver:(id)observer andShowSelector:(SEL)showSelector andDismissSelector:(SEL)dismissSelector
{
    //键盘显示通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:showSelector name:UIKeyboardWillShowNotification object:nil];
    //键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:dismissSelector name:UIKeyboardWillHideNotification object:nil];
}

- (void)showKeyboardWithNotice:(NSNotification *)notification andOption:(void(^)(float keyBoardHeight, NSTimeInterval duration))option
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect endKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    if(option) option(endKeyboardRect.size.height, duration.floatValue);
}

- (void)dismissKeyboardWithNotice:(NSNotification *)notification andOption:(void(^)(CGRect frame, NSTimeInterval duration))option
{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect endKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if(option) option(endKeyboardRect ,duration.floatValue);
}


@end