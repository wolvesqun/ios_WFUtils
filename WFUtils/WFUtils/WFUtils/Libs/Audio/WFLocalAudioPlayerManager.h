//
//  WFLocalAudioPlayerManager.h
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  本地音频播放管理器
 */
@interface WFLocalAudioPlayerManager : NSObject

/*** 原设备为耳机(Headphones),而且此时拔出耳机事件回调 ***/
@property (copy, nonatomic) void(^BLock_pullHeadPhonesEvent)();

+ (instancetype)defaultManager;


- (AVAudioPlayer *)playWithFilepath:(NSString *)filepath;

- (void)pauseWithFilepath:(NSString *)filepath;
- (void)stopWithFilepath:(NSString *)filepath;
- (BOOL)isPlayingWithFilepath:(NSString *)filepath;

@end
