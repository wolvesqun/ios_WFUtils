//
//  WFBaseButton.m
//  WFUtils
//
//  Created by PC on 4/10/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFBaseButton.h"

@interface WFBaseButton ()

@property (copy, nonatomic) void(^BLock_clickHandle)();

@end

@implementation WFBaseButton


+ (instancetype)buttonWithType:(UIButtonType)buttonType
                 andClickEvent:(void(^)())clickEvent
{

    WFBaseButton *button = [self buttonWithType:buttonType];
    [button addTarget:button action:@selector(actionToTap) forControlEvents:UIControlEventTouchUpInside];
    button.BLock_clickHandle = clickEvent;
    return button;
}

- (void)actionToTap
{
    if(self.BLock_clickHandle)
    {
        self.BLock_clickHandle();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
