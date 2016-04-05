//
//  WFDateHelper.m
//  WFUtils
//
//  Created by PC on 4/5/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFDateHelper.h"

@implementation WFDateHelper

+ (NSDateFormatter *)getDateFormat:(NSString *)dataFormat
{
    static NSDateFormatter *dtFormat = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(dtFormat == nil)
        {
            dtFormat = [[NSDateFormatter alloc] init];
            dtFormat.locale = [NSLocale currentLocale];
        }
    });
    if(dataFormat == nil)
    {
        dataFormat = @"yyyy-MM-dd";
    }
    dtFormat.dateFormat = dataFormat;
    return dtFormat;
}

#pragma mark - 时间转换
/**
 *  时间 -》字符串
 *
 *  @param srcDate 如果为空则返回空字符
 *  @param format  默认为 yyyy-MM-dd
 */
+ (NSString *)convertDateToString:(NSDate *)srcDate
                        andFormat:(NSString *)format
{
    if(srcDate == nil) return @"";
    NSDateFormatter *df = [self getDateFormat:format];
    return [df stringFromDate:srcDate];
}

/**
 *  字符串 -》时间
 *
 *  @param srcDate 如果为空则返回 nil
 *  @param format  默认为 yyyy-MM-dd
 */
+ (NSDate *)convertStringToDate:(NSString *)srcDateString
                      andFormat:(NSString *)format
{
    if(srcDateString == nil || srcDateString.length == 0) return nil;
    NSDateFormatter *df = [self getDateFormat:format];
    return [df dateFromString:srcDateString];
}

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
                               andTargetFormat:(NSString *)targetFormat
{
    if(srcDate.length == 0 || srcFormat.length == 0) return @"";
    NSDate *date = [self convertStringToDate:srcDate andFormat:srcFormat];
    return [self convertDateToString:date andFormat:targetFormat];
}

@end
