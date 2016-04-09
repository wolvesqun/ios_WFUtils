//
//  WFOnlineMusicViewController.m
//  WFUtils
//
//  Created by PC on 4/8/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFOnlineMusicViewController.h"
#import "AudioStreamer.h"

@interface WFOnlineMusicViewController ()

@property (strong, nonatomic) AudioStreamer *musicPlayer;

@property (strong, nonatomic) UIButton *btnPlay;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) UISlider *slider;


@end

@implementation WFOnlineMusicViewController

- (NSTimer *)timer
{
    if(_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }
    return _timer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *URLString = @"https://sdl63.yunpan.360.cn/share.php?method=Share.download&cqid=cdabd27afb5e7ff4f85c37f0ebdb4cdc&dt=63.6c16a526ff47db3866c31d925a189eae&e=1460290059&fhash=be099249620856560327c0cf5e795ff2f7d0d9e0&fname=%25E8%25BD%25BB%25E9%259F%25B3%25E4%25B9%2590%2B-%2B%25E9%259B%25AA%25E5%258D%2583%25E5%25AF%25BB.mp3&fsize=3272075&nid=13838740562947529&st=5b927e757af73341c7191178cfa7cd9c&xqid=191852906";
    self.musicPlayer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:URLString]];
//    [self.musicPlayer start];
    
    [self createProgress];
    
    [self createPlayButton];
}

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
}

- (void)createProgress
{
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width - 20, 20)];
    [self.slider addTarget:self action:@selector(actionToSlider:) forControlEvents:UIControlEventTouchUpInside];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    [self.view addSubview:self.slider];
}

- (void)actionToSlider:(UISlider *)slider
{
    NSTimeInterval duration = slider.value * self.musicPlayer.duration;
//    [self playMusicWithDuration:duration];
    
}

- (void)actionToPlay:(UIButton *)sender
{
    if(!sender.selected)
    {
        [self playMusic];
    }
    else
    {
        [self pauseMusic];
    }
    sender.selected = !sender.selected;
}

- (void)playMusic
{
    if(![self.musicPlayer isPlaying])
    {
        [self.musicPlayer start];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSTimeInterval duration = self.musicPlayer.duration * 0.5;
            
//            self.musicPlayer.currentTime = duration;
            
        });
        
        self.timer.fireDate = [NSDate distantPast]; // 重新启用计时器
    }
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
    [self.musicPlayer pause];
    self.timer.fireDate = [NSDate distantFuture]; // 暂停计时器
}

- (void)stopMusic
{
    [self.musicPlayer stop];
    self.btnPlay.selected = NO;
    [self.slider setValue:0];
    [self.timer invalidate];
    self.timer = nil;
}


- (void)updateProgress
{
    NSLog(@"========> currend = %f, andEnd =  %f", self.musicPlayer.progress, self.musicPlayer.duration);
//    float progress = self.musicPlayer.progress / self.musicPlayer.duration;
//    [self.slider setValue:progress animated:YES];
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
