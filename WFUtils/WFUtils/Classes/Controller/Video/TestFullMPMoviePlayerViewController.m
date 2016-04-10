//
//  TestFullMPMoviePlayerViewController.m
//  WFUtils
//
//  Created by PC on 4/10/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "TestFullMPMoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TestFullMPMoviePlayerViewController ()


@property (strong, nonatomic) UIButton *btnLocal;
@property (strong, nonatomic) UIButton *btnOnline;

@property (strong, nonatomic) MPMoviePlayerViewController *playerVC;

@property (assign, nonatomic) BOOL isLocalPlayer;


@end

@implementation TestFullMPMoviePlayerViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.playerVC
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playerVC = [[MPMoviePlayerViewController alloc] init];
    
    
    // 1 . local
    //    self.playerController = [[MPMoviePlayerController alloc] init];
    
    self.btnLocal = [self createPlayButton:0 andTitle:@"播放本地"];
    self.btnOnline = [self createPlayButton:1 andTitle:@"播放网络"];
    
    [self addNotification];
}

- (UIButton *)createPlayButton:(NSInteger)index andTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(index == 0)
    {
        button.frame = CGRectMake(50, self.view.frame.size.height - 300, 100, 50);
        [button addTarget:self action:@selector(actionToPlayerLocal:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        button.frame = CGRectMake(50, self.view.frame.size.height - 200, 100, 50);
        [button addTarget:self action:@selector(actionToPlayerOnline:) forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitle:title forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:button];
    return button;
}

- (void)actionToPlayerLocal:(UIButton *)sender
{
    self.isLocalPlayer = YES;
    
    
    self.playerVC = nil;
    NSString *localPath = [[NSBundle mainBundle] pathForResource:@"1.互联网并发编程介绍.mp4" ofType:nil];
    
    self.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:localPath]];
    [self presentMoviePlayerViewControllerAnimated:self.playerVC];
    
    [self requestThumimage];
}

- (void)actionToPlayerOnline:(UIButton *)sender
{
    self.isLocalPlayer = NO;
    
    self.playerVC = nil;
    
    NSString *onlineStr = @"https://sdl71.yunpan.360.cn/share.php?method=Share.download&cqid=50989877416e5975b148b2a94e7fe1d0&dt=71.7589c6a97b70113bf911a405679d830b&e=1460421270&fhash=ac149472968cbf1e2dc69523f77bba50c2587583&fname=1.%25E4%25BA%2592%25E8%2581%2594%25E7%25BD%2591%25E5%25B9%25B6%25E5%258F%2591%25E7%25BC%2596%25E7%25A8%258B%25E4%25BB%258B%25E7%25BB%258D.mp4&fsize=15699470&nid=14527425939433865&st=e2413ecb258a143eba63edea05505246&xqid=191852906";
    self.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:onlineStr]];
    
    [self presentMoviePlayerViewControllerAnimated:self.playerVC];
    
    [self requestThumimage];
}

#pragma mark -
- (void)addNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 播放状态变化
    [center addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    // 播放完成
    [center addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //  请求缩略成
    [center addObserver:self selector:@selector(mediaPlayerPlaybackThumbImageFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    MPMoviePlayerController *vc = self.playerVC.moviePlayer;
    switch (vc.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",vc.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    if(self.isLocalPlayer)
    {
//        [self.localPlayerController.view removeFromSuperview];
        NSLog(@"TestFullMPMoviePlayerViewController ===》 本地播放完成");
    }
    else
    {
//        [self.onlinePlayerController.view removeFromSuperview];
        NSLog(@"TestFullMPMoviePlayerViewController ===》 网络播放完成");
    }
    
}

// 缩略图请求完成
-(void)mediaPlayerPlaybackThumbImageFinished:(NSNotification *)notification
{
    NSLog(@"TestFullMPMoviePlayerViewController ===》 请求缩略图片完成, 保存到图册了");
    
    UIImage *image=notification.userInfo[MPMoviePlayerThumbnailImageKey];
    //保存图片到相册(首次调用会请求用户获得访问相册权限)
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)requestThumimage
{
    if(self.isLocalPlayer)
    {
        [self.playerVC.moviePlayer requestThumbnailImagesAtTimes:@[@3, @10] timeOption:MPMovieTimeOptionNearestKeyFrame];
    }
    else
    {
        
        [self.playerVC.moviePlayer requestThumbnailImagesAtTimes:@[@3, @10] timeOption:MPMovieTimeOptionNearestKeyFrame];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
