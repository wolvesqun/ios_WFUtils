//
//  WFMusicListViewController.m
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFMusicListViewController.h"
#import "WFMusicListTbView.h"
#import "WFMusicViewController.h"

@interface WFMusicListViewController ()

@property (strong, nonatomic) WFMusicListTbView *tbView;

@property (strong, nonatomic) WFMusicViewController *playerVC;

@end

@implementation WFMusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playerVC = [WFMusicViewController new];
    
    self.title = @"音乐列表";
    
    self.tbView = [[WFMusicListTbView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tbView.parentVC = self;
    [self.view addSubview:self.tbView];
}

#pragma mark -
- (void)updateUI
{
    self.tbView.frame = CGRectMake(0, 0, WF_UI_IPHONE_WIDTH, WF_UI_IPHONE_HEIGHT);
    [self.tbView updateUI];
}

#pragma mark -
- (void)pushViewToAudioPlayer:(WFMusicBean *)bean
{
    [self.playerVC playerWithBean:bean];
//    [[WFMusicViewController sharedIntanced] playerWithBean:bean];
//    [[WFMusicViewController sharedIntanced] showWithParentVC:self];
    [self presentViewController:self.playerVC animated:YES completion:nil];
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
