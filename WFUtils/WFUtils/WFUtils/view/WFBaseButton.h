//
//  WFBaseButton.h
//  WFUtils
//
//  Created by PC on 4/10/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFBaseButton : UIButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType andClickEvent:(void(^)())clickEvent;

@end
