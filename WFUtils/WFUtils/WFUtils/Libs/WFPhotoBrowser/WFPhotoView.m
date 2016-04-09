//
//  WFPhotoView.m
//  testWFPhotoBrowser
//
//  Created by mba on 15/12/17.
//  Copyright © 2015年 ubmlib. All rights reserved.
//

#import "WFPhotoView.h"
#import "WFPhoto.h"
#import "UIImageView+WebCache.h"

@interface WFPhotoView ()
{
    UIImageView *_imageView;
}


@end

@implementation WFPhotoView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;
        // 图片
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        //        _imageView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageView];
        
        // 进度条
        //        _photoLoadingView = [[MJPhotoLoadingView alloc] init];
        
        // 属性
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //设置最大伸缩比例
        self.maximumZoomScale=2.0;
        //设置最小伸缩比例
        self.minimumZoomScale=1;
        
        // 监听点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        [self updateUI];
    }
    return self;
}

#pragma mark - photoSetter
//- (void)setPhoto:(WFPhoto *)photo {
//    _photo = photo;
//
//    [self showImage];
//}

- (void)requestImage
{
    [_imageView sd_setImageWithURL:self.photo.url
                  placeholderImage:self.photo.placeholder
                           options:SDWebImageRetryFailed|SDWebImageLowPriority
                          progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         self.photo.image = image;
         dispatch_async(dispatch_get_main_queue(), ^{
             _imageView.image = image;
             if([self.photoViewDelegate respondsToSelector:@selector(photoViewImageFinishLoad:)])
             {
                 [self.photoViewDelegate photoViewImageFinishLoad:self];
             }
         });
         
     }];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    // 通知代理
    if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
        [self.photoViewDelegate photoViewSingleTap:self];
    }
}


- (void)updateUI
{
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _imageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
