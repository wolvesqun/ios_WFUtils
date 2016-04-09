//
//  WFPhotoBrowser.h
//  testWFPhotoBrowser
//
//  Created by mba on 15/12/17.
//  Copyright © 2015年 ubmlib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFPhoto.h"

@interface WFPhotoBrowser : UIViewController

// 退出图册回调
@property (strong, nonatomic) void(^block_dismissCallBack)(void);

// 所有的图片对象
@property (nonatomic, strong) NSArray *photoArray;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

// 显示
- (void)show;

@end
