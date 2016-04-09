//
//  WFPlayerMusicToolbar.m
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFPlayerMusicToolbar.h"

@implementation WFPlayerMusicToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSInteger index = 0;
        // 1.
        self.btnPlayer = [self createButton:index ++ andNormal:@"暂停"
                                  andSelect:@"播放"];
//        self.btnPlayer.selected = YES;
        
        // 2.
//        self.btnLast = [self createButton:index ++ andNormal:@"上一曲" andSelect:nil];
//        
//        self.btnNext = [self createButton:index ++ andNormal:@"下一曲" andSelect:nil];
    }
    return self;
}

- (UIButton *)createButton:(NSInteger)index andNormal:(NSString *)normal andSelect:(NSString *)select
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    [button setTitle:normal forState:UIControlStateNormal];
    if(select)
    {
        [button setTitle:select forState:UIControlStateSelected];
    }
    button.selected = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.frame = CGRectMake(0, 0, 70, 35);
    [button addTarget:self action:@selector(actionToTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    button.backgroundColor = [UIColor greenColor];
    return button;
}

- (void)actionToTap:(UIButton *)sender
{
    if(sender.tag == 0)
    {
        if(self.BLock_playOrPause)
        {
            self.BLock_playOrPause();
        }
        sender.selected = !sender.selected;
    }
    else if (sender.tag == 1)
    {
        if(self.BLock_playLast) self.BLock_playLast();
    }
    else
    {
        if(self.BLock_playNext) self.BLock_playNext();
    }
}

- (void)updateUI
{
    self.btnPlayer.center = CGPointMake(self.frame.size.width / 2, self.btnPlayer.center.y);
    self.btnLast.center = CGPointMake(self.btnPlayer.center.x - 100, self.btnPlayer.center.y);
    self.btnNext.center = CGPointMake(self.btnPlayer.center.x + 100, self.btnNext.center.y );
}

- (void)setupStatue:(BOOL)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.btnPlayer.selected = status;
    });

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
