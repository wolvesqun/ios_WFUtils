//
//  ViewController.m
//  WFUtils
//
//  Created by PC on 4/4/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "ViewController.h"
#import "WFSoundViewController.h"
#import "WFMusicViewController.h"
#import "WFOnlineMusicViewController.h"
#import "WFMusicListViewController.h"
#import "WFRecordViewController.h"
#import "TestMPMoviePlayerViewController.h"
#import "TestFullMPMoviePlayerViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tbView;

@property (strong, nonatomic) NSArray *dtArray;

@property (strong, nonatomic) WFMusicListViewController *musicListVC;
@property (strong, nonatomic) WFOnlineMusicViewController *onlineMusicVC;
@property (strong, nonatomic) WFRecordViewController *recondVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.musicListVC = [WFMusicListViewController new];
    self.onlineMusicVC = [WFOnlineMusicViewController new];
    self.recondVC = [WFRecordViewController new];
    
    self.dtArray = [NSArray arrayWithObjects:@"音频",@"音乐播放器",@"在线音乐播放器"
                    ,@"录音",
                    @"系统视频播放->MPMoviePlayerViewController",
                    @"全屏系统播放器", nil];
    
    self.tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self.view addSubview:self.tbView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dtArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = [self.dtArray objectAtIndex:indexPath.row];
    if([key isEqualToString:@"音频"])
    {
        [self.navigationController pushViewController:[WFSoundViewController new] animated:YES];
    }
    else if ([key isEqualToString:@"音乐播放器"])
    {
        [self.navigationController pushViewController:self.musicListVC animated:YES];
    }
    else if ([key isEqualToString:@"在线音乐播放器"])
    {
        [self.navigationController pushViewController:self.onlineMusicVC animated:YES];
    }
    else if ([key isEqualToString:@"录音"])
    {
        [self.navigationController pushViewController:self.recondVC animated:YES];
    }
    else if ([key isEqualToString:@"系统视频播放->MPMoviePlayerViewController"])
    {
        [self.navigationController pushViewController:[TestMPMoviePlayerViewController new] animated:YES];
    }
    else if ([key isEqualToString:@"全屏系统播放器"])
    {
        [self.navigationController pushViewController:[TestFullMPMoviePlayerViewController new] animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dtArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
