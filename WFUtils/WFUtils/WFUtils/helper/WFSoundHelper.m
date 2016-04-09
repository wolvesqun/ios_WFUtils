//
//  WFSoundHelper.m
//  WFUtils
//
//  Created by PC on 4/8/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFSoundHelper.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation WFSoundHelper

+ (void)playWithSoundID:(NSInteger)soundID andCompletion:(void(^)(void))completion
{
    AudioServicesPlaySystemSoundWithCompletion((UInt32)soundID, completion);
}

//+ (void)playWithFilepath:(NSString *)filepath andCompletion:(void(^)(void))completion
//{
//    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
//    SystemSoundID soundID = 0;
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileURL), &soundID);
//    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, ^( SystemSoundID       ssID,void* clientData){}, NULL);
//    AudioServicesAddSystemSoundCompletion(0, NULL, NULL, completion, NULL);
//}

@end
