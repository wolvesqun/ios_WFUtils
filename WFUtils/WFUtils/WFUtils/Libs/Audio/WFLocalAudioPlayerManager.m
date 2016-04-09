//
//  WFLocalAudioPlayerManager.m
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFLocalAudioPlayerManager.h"

@interface WFLocalAudioPlayerManager ()

@property (strong, nonatomic) NSMutableDictionary *dictAudioPlayer;

@end

@implementation WFLocalAudioPlayerManager

#pragma mark - 初始化相关
+ (instancetype)defaultManager
{
    static WFLocalAudioPlayerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(manager == nil)
        {
            manager = [[self alloc] init];
            [manager _initCtrl];
        }
    });
    return manager;
}

- (void)_initCtrl
{
    // *** 如果需要锁屏播放，请在plist添加 Required background modes，对应的value为
    //     App plays audio or streams audio/video using AirPlay
    // *** 1. 设置后台播放模式
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //        [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
    [audioSession setActive:YES error:nil];
    // *** 2. 添加通知，拔出耳机后暂停播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChangeNotification:) name:AVAudioSessionRouteChangeNotification object:nil];
    
    // *** 3. 容器
    self.dictAudioPlayer = [NSMutableDictionary dictionary];
}

#pragma makr - 音乐相关
// - 播放音乐
- (AVAudioPlayer *)playWithFilepath:(NSString *)filepath
{
    if(filepath == nil || filepath.length == 0) return nil;
    AVAudioPlayer *audioPlayer = [self.dictAudioPlayer objectForKey:filepath];
    if(audioPlayer == nil)
    {
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filepath] error:nil];
        [self.dictAudioPlayer setObject:audioPlayer forKey:filepath];
    }
    if(![audioPlayer isPlaying])
    {
        [audioPlayer play];
    }

    return audioPlayer;
}
// - 暂停播放
- (void)pauseWithFilepath:(NSString *)filepath
{
    if(filepath == nil || filepath.length == 0) return;
    AVAudioPlayer *audioPlayer = [self.dictAudioPlayer objectForKey:filepath];
    if(audioPlayer && [audioPlayer isPlaying])
    {
        [audioPlayer pause];
    }
}
// - 停止播放
- (void)stopWithFilepath:(NSString *)filepath
{
    if(filepath == nil || filepath.length == 0) return;
    AVAudioPlayer *audioPlayer = [self.dictAudioPlayer objectForKey:filepath];
    if(audioPlayer && [audioPlayer isPlaying])
    {
        [audioPlayer stop];
    }
}
- (BOOL)isPlayingWithFilepath:(NSString *)filepath
{
    if(filepath == nil || filepath.length == 0) return NO;
    AVAudioPlayer *audioPlayer = [self.dictAudioPlayer objectForKey:filepath];
    if(audioPlayer)
    {
        return [audioPlayer isPlaying];
    }
    return NO;
}

#pragma mark -
- (void)routeChangeNotification:(NSNotification *)notification
{
    NSDictionary *dic=notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    // *** 1. 等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        // *** 2. 原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            if(self.BLock_pullHeadPhonesEvent)
            {
                self.BLock_pullHeadPhonesEvent();
            }
        }
    }
}

@end
