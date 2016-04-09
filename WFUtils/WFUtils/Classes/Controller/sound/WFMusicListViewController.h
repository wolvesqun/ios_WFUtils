//
//  WFMusicListViewController.h
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFBaseViewController.h"
#import "WFMusicBean.h"

@interface WFMusicListViewController : WFBaseViewController

- (void)pushViewToAudioPlayer:(WFMusicBean *)bean;

@end
