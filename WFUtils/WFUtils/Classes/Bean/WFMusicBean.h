//
//  WFMusicBean.h
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFBaseBean.h"
#import <UIKit/UIKit.h>

@interface WFMusicBean : WFBaseBean

/**
 *  歌曲名字
 */
@property (copy, nonatomic) NSString *name;
/**
 *  歌曲大图
 */
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) UIImage *iconImage;
/**
 *  歌曲的文件名
 */
@property (copy, nonatomic) NSString *filename;
@property (copy, nonatomic) NSString *filepath;
/**
 *  歌词的文件名
 */
@property (copy, nonatomic) NSString *lrcname;
/**
 *  歌手
 */
@property (copy, nonatomic) NSString *singer;
/**
 *  歌手图标
 */
@property (copy, nonatomic) NSString *singerIcon;

@end
