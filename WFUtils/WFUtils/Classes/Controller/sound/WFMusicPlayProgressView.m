//
//  WFMusicPlayProgressView.m
//  WFUtils
//
//  Created by PC on 4/9/16.
//  Copyright © 2016 ibmlib. All rights reserved.
//

#import "WFMusicPlayProgressView.h"

@interface WFMusicPlayProgressView ()

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIView *foreView;

@end

@implementation WFMusicPlayProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.bgView = [UIView new];
        [self addSubview:self.bgView];
        
        self.foreView = [UIView new];
        [self addSubview:self.foreView];
    }
    return self;
}

- (void)updateSkin
{
    self.bgView.backgroundColor = [UIColor grayColor];
    self.foreView.backgroundColor = [UIColor blueColor];
}

- (void)updateUI
{
    self.bgView.frame = CGRectMake(0, 0, self.frame.size.width, 5);
    self.bgView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    self.foreView.frame = self.foreView.frame;
}

- (void)setProgress:(float)progress
{
    if(progress < 0)return;
    [UIView animateWithDuration:0.5 animations:^{
        float width = self.bgView.frame.size.width * progress;
        self.foreView.frame = CGRectMake(self.bgView.frame.origin.x, self.bgView.frame.origin.y, width, self.bgView.frame.size.height);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
