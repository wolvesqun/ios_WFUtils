//
//  WFPlayerMusicToolbar.h
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFBaseView.h"

@interface WFPlayerMusicToolbar : WFBaseView

@property (copy, nonatomic) void(^BLock_playOrPause)();
@property (copy, nonatomic) void(^BLock_playLast)();
@property (copy, nonatomic) void(^BLock_playNext)();

@property (strong, nonatomic) UIButton *btnPlayer;

@property (strong, nonatomic) UIButton *btnLast;

@property (strong, nonatomic) UIButton *btnNext;

- (void)setupStatue:(BOOL)status;

@end
