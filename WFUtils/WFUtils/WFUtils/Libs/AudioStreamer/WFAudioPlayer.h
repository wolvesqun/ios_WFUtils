//
//  WFAudioPlayer.h
//  WFUtils
//
//  Created by PC on 4/8/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import <CFNetwork/CFNetwork.h>
#include <pthread.h>

@interface WFAudioPlayer : NSObject

@property (copy, readonly) NSURL *aURL;

- (instancetype)initWithURL:(NSURL *)aURL;

- (void)play;

@end
