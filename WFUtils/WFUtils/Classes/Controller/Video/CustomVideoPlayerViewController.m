//
//  CustomVideoPlayerViewController.m
//  WFUtils
//
//  Created by PC on 4/10/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "CustomVideoPlayerViewController.h"

@interface CustomVideoPlayerViewController ()

@property (strong, nonatomic) UIButton *btnQuickLast;
@property (strong, nonatomic) UIButton *btnQuickNext;
@property (strong, nonatomic) UIButton *btnPlay;

@property (strong, nonatomic) UIView *viewVideoContain;
@property (strong, nonatomic) AVPlayer *videoPlayer;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@property (strong, nonatomic) UISlider *slider;

@end

@implementation CustomVideoPlayerViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.videoPlayer pause];
    self.videoPlayer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // *** 1.
    [self createContain];
    // *** 2.
    [self createPlayButton];
    // *** 3.
    [self createPlayer];
    
}

// 创建视频播放容器
- (void)createContain
{
    self.viewVideoContain = [UIView new];
    [self.view addSubview:self.viewVideoContain];
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    [self.view addSubview:self.slider];
}
// 创建播放|暂停按钮
- (void)createPlayButton
{
    self.btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPlay.frame = CGRectMake(50, self.view.frame.size.height - 100, 100, 50);
    self.btnPlay.center = CGPointMake(self.view.center.x, self.btnPlay.center.y);
    self.btnPlay.backgroundColor = [UIColor greenColor];
    [self.btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    [self.btnPlay setTitle:@"暂停" forState:UIControlStateSelected];
    [self.btnPlay addTarget:self action:@selector(actionToPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnPlay];
    
    // 2.
    self.btnQuickLast = [self createButtonWithTitle:@"快退10秒" andClickEvent:^
    {
        int32_t timeScale = self.videoPlayer.currentItem.asset.duration.timescale;
        float second = MAX(CMTimeGetSeconds(self.videoPlayer.currentTime) - 10, 0);
        CMTime time = CMTimeMakeWithSeconds(second, timeScale);
        [self.videoPlayer seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }];
    
    self.btnQuickNext = [self createButtonWithTitle:@"快进10秒" andClickEvent:^
    {
        int32_t timeScale = self.videoPlayer.currentItem.asset.duration.timescale;
        float second = MIN(CMTimeGetSeconds(self.videoPlayer.currentTime) + 10, CMTimeGetSeconds(self.videoPlayer.currentItem.duration));
        CMTime time = CMTimeMakeWithSeconds(second, timeScale);
        [self.videoPlayer seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
        
    }];
}
- (WFBaseButton *)createButtonWithTitle:(NSString *)title andClickEvent:(void(^)())clickEvent
{
    WFBaseButton *button = [WFBaseButton buttonWithType:UIButtonTypeCustom andClickEvent:clickEvent];
    button.frame = CGRectMake(0, 0, 100, 50);
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
    return button;
}

// - 创建视频播放器
- (void)createPlayer
{
    // 1.
    NSString *onlineStr = @"https://sdl71.yunpan.360.cn/share.php?method=Share.download&cqid=50989877416e5975b148b2a94e7fe1d0&dt=71.7589c6a97b70113bf911a405679d830b&e=1460421270&fhash=ac149472968cbf1e2dc69523f77bba50c2587583&fname=1.%25E4%25BA%2592%25E8%2581%2594%25E7%25BD%2591%25E5%25B9%25B6%25E5%258F%2591%25E7%25BC%2596%25E7%25A8%258B%25E4%25BB%258B%25E7%25BB%258D.mp4&fsize=15699470&nid=14527425939433865&st=e2413ecb258a143eba63edea05505246&xqid=191852906";
    self.videoPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:onlineStr]];
    
    // 2.
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.videoPlayer];
    [self.viewVideoContain.layer addSublayer:self.playerLayer];
    
    // *** 3. 添加视频结束通知
    [self addNotification];

    // *** 4. 添加进度
    [self addVideoPlayerProgress];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)addVideoPlayerProgress
{
    AVPlayerItem *playerItem = [self.videoPlayer currentItem];
    
    [self.videoPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time)
    {
        float currentTime = CMTimeGetSeconds(time);
        float totalTime = CMTimeGetSeconds(playerItem.duration);
        float progress = currentTime / totalTime;
        NSLog(@"currentTime = %f, totalTime = %f", currentTime, totalTime);
        [self.slider setValue:progress animated:YES];
    }];
}

#pragma mark - 
- (void)actionToPlay:(UIButton *)sender
{
    if(sender.selected)
    {
        [self.videoPlayer pause];
    }
    else
    {
        [self.videoPlayer play];
    }
    sender.selected = !sender.selected;
}

- (void)stopPlayer
{
    
}

#pragma mark - 
- (void)videoPlayFinished:(NSNotification *)notification
{
    int32_t timeScale = self.videoPlayer.currentItem.asset.duration.timescale;
    CMTime time = CMTimeMakeWithSeconds(0, timeScale);
    [self.videoPlayer seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    NSLog(@"CustomVideoPlayerViewController =》视频播放完成");
    //
    
}

#pragma mark -
- (void)updateUI
{
    self.viewVideoContain.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 250);
    self.playerLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.viewVideoContain.frame), CGRectGetHeight(self.viewVideoContain.frame));
    
    // ***
    self.slider.frame = CGRectMake(0, 400, self.view.frame.size.width, 10);
    self.btnPlay.frame = CGRectMake(50, self.view.frame.size.height - 100, 100, 50);
    self.btnPlay.center = CGPointMake(self.view.center.x, self.btnPlay.center.y);
    // ***
    self.btnQuickLast.center = CGPointMake(self.btnPlay.center.x - 120, self.btnPlay.center.y);
    
    // ***
    self.btnQuickNext.center = CGPointMake(self.btnPlay.center.x + 120, self.btnPlay.center.y);
}

- (void)updateSkin
{
    self.viewVideoContain.backgroundColor = [UIColor grayColor];
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
