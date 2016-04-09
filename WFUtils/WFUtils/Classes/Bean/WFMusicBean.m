//
//  WFMusicBean.m
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFMusicBean.h"
#import <UIKit/UIKit.h>

@implementation WFMusicBean

- (void)setFilename:(NSString *)filename
{
    _filename = filename;
    self.filepath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
}

- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    self.iconImage = [UIImage imageNamed:icon];
}

@end
