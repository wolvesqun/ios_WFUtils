//
//  WFImageHelper.h
//  WFUtils
//
//  Created by PC on 4/9/15.
//  Copyright © 2015 ibmlib. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  图片帮助类
 */
@interface WFImageHelper : NSObject


/**
 *  压缩图片
 *
 *  @param img        原来的图片
 *  @param targetSize 要压缩的尺寸
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)imageCompress:(UIImage *)img targetSize:(CGSize)targetSize;

/**
 *  给一张图片添加文字描述
 *
 *  @param img   图片
 *  @param mark  文字
 *  @param rect  文字所在范围
 *  @param font  文字字体
 *  @param color 文字颜色
 *
 *  @return 图片
 */
+ (UIImage *)addTextOnImage:(UIImage *)img mark:(NSString *)mark rect:(CGRect)rect font:(UIFont *)font color:(UIColor *)color;

/**
 *  将图片裁剪为带边框圆形
 *
 *  @param srcImage    图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 被裁剪后的图片
 */
+ (UIImage *)circleImageWithName:(UIImage *)srcImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  创建图片
 *
 *  @param color    要创建的图片的颜色
 *  @param rect     图片大小
 */
+ (UIImage *)createImageWithColor:(UIColor *)color andRect:(CGRect)rec;

@end
