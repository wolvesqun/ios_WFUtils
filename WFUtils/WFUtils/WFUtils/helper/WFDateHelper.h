//
//  WFDateHelper.h
//  WFUtils
//
//  Created by PC on 4/5/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  日期帮助类（yyyyMMddHHmmss）
 *
 */
@interface WFDateHelper : NSObject

#pragma mark - 时间转换
/**
 *  时间 -》字符串
 *
 *  @param srcDate 如果为空则返回空字符
 *  @param format  默认为 yyyy-MM-dd
 */
+ (NSString *)convertDateToString:(NSDate *)srcDate
                        andFormat:(NSString *)format;

/**
 *  字符串 -》时间 (注意如果时间少了时分秒，那么转换的时间就会少一天)
 *
 *  @param srcDate 如果为空则返回 nil
 *  @param format  默认为 yyyy-MM-dd
 */
+ (NSDate *)convertStringToDate:(NSString *)srcDateString
                      andFormat:(NSString *)format;

#pragma mark - 时间格式化
/**
 *  格式化时间
 *
 *  @param srcDate      源时间字符串
 *  @param srcFormat    源时间字符串格式
 *  @param targetFormat 要转换的目标格式
 *
 *  @return 返回目标时间格式
 */
+ (NSString *)formatToDateStringWithDateString:(NSString *)srcDate
                                  andSrcFormat:(NSString *)srcFormat
                               andTargetFormat:(NSString *)targetFormat;

@end
