//
//  WFPhotoView.h
//  testWFPhotoBrowser
//
//  Created by mba on 15/12/17.
//  Copyright © 2015年 ubmlib. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WFPhotoBrowser, WFPhoto, WFPhotoView;

@protocol WFPhotoViewDelegate <NSObject>
- (void)photoViewImageFinishLoad:(WFPhotoView *)photoView;
- (void)photoViewSingleTap:(WFPhotoView *)photoView;
@end

@interface WFPhotoView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, weak) id<WFPhotoViewDelegate> photoViewDelegate;

// 图片
@property (nonatomic, strong) WFPhoto *photo;

- (void)requestImage;

- (void)updateUI;

@end
