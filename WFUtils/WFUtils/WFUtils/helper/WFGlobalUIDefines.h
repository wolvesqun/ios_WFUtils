//
//  WFGlobalUIDefines.h
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <UIKit/UIKit.h>

//***************************** 设备相关属性 *****************************

/*** 设备屏幕尺寸 ***/
#define WF_UI_IPHONE_WIDTH    [UIScreen mainScreen].bounds.size.width
#define WF_UI_IPHONE_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define WF_UI_TABBAR_HEIGHT    49
#define WF_UI_NAVBAR_HEIGHT    44
#define WF_UI_STATUSBAR_HEIGHT 20

/*** 颜色设置 ***/
#define WF_COLOR_RGB(r, g, b, al) [UIColor colorWithRed:r green:g blue:b alpha:al]
#define WF_COLOR_RGB_ALPHA(r, g, b, al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]

/*** 16进制转成rgb ***/
#define WF_COLOR_HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define WF_DEVICE_IPhone ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
#define WF_DEVICE_IPad ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

@interface WFGlobalUIDefines : NSObject

@end
