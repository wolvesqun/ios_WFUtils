//
//  WFMusicListTbView.m
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFMusicListTbView.h"
#import "MJExtension.h"
#import "WFImageHelper.h"

@interface WFMusicListTbView ()

//@property (strong, nonatomic) NSMutableArray *dtArray;

@end

@implementation WFMusicListTbView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self _initData];
    }
    return self;
}

- (void)_initData
{
    self.dtArray = [NSMutableArray array];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dict in tempArray) {
        [self.dtArray addObject:[WFMusicBean beanWithDict:dict]];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dtArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    WFMusicBean *bean = [self.dtArray objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageNamed:bean.singerIcon];
    image = [WFImageHelper circleImageWithName:image borderWidth:3 borderColor:[UIColor whiteColor]];
    
    cell.imageView.image = image;
    cell.textLabel.text = bean.name;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WFMusicBean *bean = [self.dtArray objectAtIndex:indexPath.row];
    [self.parentVC pushViewToAudioPlayer:bean];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    [ZYMusicTool setPlayingMusic:[ZYMusicTool musics][indexPath.row]];
//    
//    ZYMusic *preMusic = [ZYMusicTool musics][self.currentIndex];
//    preMusic.playing = NO;
//    ZYMusic *music = [ZYMusicTool musics][indexPath.row];
//    music.playing = YES;
//    NSArray *indexPaths = @[
//                            [NSIndexPath indexPathForItem:self.currentIndex inSection:0],
//                            indexPath
//                            ];
//    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
//    
//    self.currentIndex = (int)indexPath.row;
//    
//    [self.playingVc show];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
