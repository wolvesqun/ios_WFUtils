//
//  WFMusicListTbView.h
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFBaseTbView.h"
#import "WFMusicBean.h"
#import "WFMusicListViewController.h"

@interface WFMusicListTbView : WFBaseTbView

@property (strong, nonatomic) NSMutableArray *dtArray;

@property (strong, nonatomic) WFMusicListViewController *parentVC;

@end
