//
//  WFSoundHelper.h
//  WFUtils
//
//  Created by PC on 4/8/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  音效帮助类
 */
@interface WFSoundHelper : NSObject

#pragma mark - 播放系统音效
+ (void)playWithSoundID:(NSInteger)soundID andCompletion:(void(^)(void))completion
;
// - 播放带振动
//+ (void)playAlertWithSoundID:(NSInteger)soundID;

@end
