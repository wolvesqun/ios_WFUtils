//
//  WFMusicViewController.m
//  WFUtils
//
//  Created by PC on 4/8/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFMusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WFLocalAudioPlayerManager.h"
#import "WFPlayerMusicToolbar.h"
#import "WFImageHelper.h"
#import "WFMusicPlayProgressView.h"

@interface WFMusicViewController ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) WFMusicBean *bean;

@property (strong, nonatomic) WFLocalAudioPlayerManager *musicPlayerManater;
@property (strong, nonatomic) AVAudioPlayer *currentPlayer;

@property (strong, nonatomic) UIButton *btnCancer;
@property (strong, nonatomic) UIImageView *imgBgView;
@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) WFPlayerMusicToolbar *bottomToolbar;

//@property (strong, nonatomic) UISlider *progressView;
/*** 计时器 ***/
@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) BOOL isPlaying;

@end

@implementation WFMusicViewController


- (WFLocalAudioPlayerManager *)musicPlayerManater
{
    if(_musicPlayerManater == nil)
    {
        _musicPlayerManater = [WFLocalAudioPlayerManager defaultManager];
    }
    return _musicPlayerManater;
}



- (NSTimer *)timer
{
    if(_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - 
- (void)viewWillDisappear:(BOOL)animated
{
//    [self stopMusic];
    [super viewWillDisappear:animated];
}

#pragma mark - 初始化相关
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"雪千寻-轻音乐";
    
    //
    
    self.imgBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.imgBgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imgBgView];
    
    self.btnCancer = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnCancer addTarget:self action:@selector(actionToBackVC) forControlEvents:UIControlEventTouchUpInside];
    self.btnCancer.frame = CGRectMake(10, 30, 50, 30);
    self.btnCancer.backgroundColor = [UIColor greenColor];
//    self.btnCancer.layer.borderWidth = 1;
//    self.btnCancer.layer.borderColor = [UIColor blackColor].CGColor;
//    self.btnCancer.layer
    self.btnCancer.layer.cornerRadius = 5;
    [self.btnCancer setTitle:@"取消" forState:UIControlStateNormal];
    self.btnCancer.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.btnCancer];


    self.bottomToolbar = [[WFPlayerMusicToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    __block WFMusicViewController *selfBlock = self;
    self.bottomToolbar.BLock_playOrPause = ^
    {
        if(selfBlock.isPlaying)
        {
            [selfBlock pauseMusic];
        }
        else
        {
            [selfBlock playMusic];
        }

    };
    [self.view addSubview:self.bottomToolbar];
//    // *** 2. 初始化播放、暂停按钮
//    [self createPlayButton];
//    // *** 3. 初始化进度条
    [self createProgress];
}

- (void)initMusicPlayer
{
    // *** 1
}


- (void)createProgress
{
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 10)];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.userInteractionEnabled = NO;
    [self.view addSubview:self.slider];
    
    
}

- (void)playerWithBean:(WFMusicBean *)bean
{
    if(bean == self.bean) return;
    if(self.bean != nil)
    {
        self.currentPlayer.currentTime = 0;
        [self stopMusic];
    }
    self.bean = bean;
    [self playMusic];
}

- (void)updateProgress
{
    if(self.currentPlayer == nil) return;
    float progress = self.currentPlayer.currentTime / self.currentPlayer.duration;
    [self.slider setValue:progress animated:YES];
}


- (void)actionToSlider:(UISlider *)slider
{
//    NSTimeInterval duration = slider.value * self.musicPlayer.duration;

    
}

- (void)actionToBackVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playMusic
{
    if(![self.musicPlayerManater isPlayingWithFilepath:self.bean.filepath])
    {
        
        AVAudioPlayer *audioPlayer = [self.musicPlayerManater playWithFilepath:self.bean.filepath];
        if(audioPlayer)
        {
            self.currentPlayer = audioPlayer;
            audioPlayer.delegate = self;
            self.isPlaying = YES;
            self.timer.fireDate = [NSDate distantPast]; // 重新启用计时器
        }
    }
}

- (void)setIsPlaying:(BOOL)isPlaying
{
    _isPlaying = isPlaying;
    [self.bottomToolbar setupStatue:!isPlaying];
}


- (void)playMusicWithDuration:(NSTimeInterval)duration
{
    if(duration < 0) return;
//    [self stopMusic];
    [self pauseMusic];
//    [self.musicPlayer playAtTime:duration];
    self.timer.fireDate = [NSDate distantPast];
}

- (void)pauseMusic
{
    
    [self.musicPlayerManater pauseWithFilepath:self.bean.filepath];
    self.isPlaying = NO;
    self.timer.fireDate = [NSDate distantFuture]; // 暂停计时器
}

- (void)stopMusic
{
    [self.musicPlayerManater stopWithFilepath:self.bean.filepath];
    self.isPlaying = NO;
    [self.slider setValue:0];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate AVAudioPlayer
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"音乐播放结束");
    [self stopMusic];
}

#pragma mark - UI
- (void)updateUI
{
    self.imgBgView.frame = CGRectMake(0, 0, WF_UI_IPHONE_WIDTH, WF_UI_IPHONE_HEIGHT);
    self.slider.frame = CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 30);
    self.bottomToolbar.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    [self.bottomToolbar updateUI];
}

- (void)updateSkin
{
    self.imgBgView.image = self.bean.iconImage;
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
