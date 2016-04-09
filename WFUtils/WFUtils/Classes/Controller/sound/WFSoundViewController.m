//
//  WFSoundViewController.m
//  WFUtils
//
//  Created by PC on 4/8/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFSoundViewController.h"
#import "WFSoundHelper.h"

@interface WFSoundViewController ()

@end

@implementation WFSoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createButtonSound];
//    [self createButtonSoundAlert];
}

- (void)createButtonSound
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"播放系统音效, 请用真机" forState:UIControlStateNormal];
    button.frame = CGRectMake(30, 100, 100, 40);
    [button addTarget:self action:@selector(actionToPlaySound) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)createButtonSoundAlert
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"播放自定义音效, 请用真机" forState:UIControlStateNormal];
    button.frame = CGRectMake(30, 160, 100, 40);
    [button addTarget:self action:@selector(actionToPlaySound) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)actionToPlaySound
{
    [WFSoundHelper playWithSoundID:1005 andCompletion:^{
        NSLog(@"播放完成");
    }];
}

- (void)actionToPlaySoundAlert
{
//    [WFSoundHelper playAlertWithSoundID:1005];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
