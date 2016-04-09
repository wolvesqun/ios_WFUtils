//
//  WFMusicViewController.h
//  WFUtils
//
//  Created by PC on 4/8/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFBaseViewController.h"
#import "WFMusicBean.h"

// 音乐播放器
@interface WFMusicViewController : WFBaseViewController



//+ (instancetype)sharedIntanced;

//- (void)showWithParentVC:(UIViewController *)parentVC;

- (void)playerWithBean:(WFMusicBean *)bean;

@end
