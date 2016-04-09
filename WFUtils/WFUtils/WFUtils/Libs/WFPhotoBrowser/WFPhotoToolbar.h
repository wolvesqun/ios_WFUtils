//
//  WFPhotoToolbar.h
//  testWFPhotoBrowser
//
//  Created by mba on 15/12/17.
//  Copyright © 2015年 ubmlib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFPhotoToolbar : UIView
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

- (void)updateUI;
@end
