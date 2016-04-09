//
//  WFPhotoBrowser.m
//  testWFPhotoBrowser
//
//  Created by mba on 15/12/17.
//  Copyright © 2015年 ubmlib. All rights reserved.
//

#import "WFPhotoBrowser.h"
#import "WFPhotoToolbar.h"
#import "WFPhoto.h"
#import "WFPhotoView.h"

#define kPadding 10

@interface WFPhotoBrowser ()<UIScrollViewDelegate, WFPhotoViewDelegate>
{
    // 滚动的view
    UIScrollView *_photoScrollView;
    // 所有的图片view
    NSMutableArray *_photoViewArray;
    
    // 工具条
    WFPhotoToolbar *_toolbar;
    
    // 一开始的状态栏
    BOOL _statusBarHiddenInited;
}

@end

@implementation WFPhotoBrowser

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.view.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 1;
    }];
    
    [self updateUI];
    
    [self showPhotos];
}



#pragma mark - Lifecycle
- (void)loadView
{
    _statusBarHiddenInited = [UIApplication sharedApplication].isStatusBarHidden;
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    self.view = [[UIView alloc] init];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark - 初始化相关
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createScrollView];
    
    for (int i = 0; i < self.photoArray.count; i ++)
    {
        WFPhoto *photo = [self.photoArray objectAtIndex:i];
        WFPhotoView *photoView = [[WFPhotoView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        photoView.photoViewDelegate = self;
        photoView.photo = photo;
        [_photoScrollView addSubview:photoView];
        [_photoViewArray addObject:photoView];
    }
    
    // 2.创建工具条
    [self createToolbar];
    
}
#pragma mark 创建UIScrollView
- (void)createScrollView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view.frame = frame;
    _photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _photoScrollView.pagingEnabled = YES;
    _photoScrollView.delegate = self;
    _photoScrollView.showsHorizontalScrollIndicator = NO;
    _photoScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_photoScrollView];
}


- (void)createToolbar
{
    _toolbar = [[WFPhotoToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _toolbar.photos = _photoArray;
    [self.view addSubview:_toolbar];
}

#pragma mark - 处理相关
#pragma mark 设置选中的图片
- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    for (int i = 0; i<_photoArray.count; i++) {
        WFPhoto *photo = _photoArray[i];
        photo.firstShow = i == currentPhotoIndex;
    }
    
    if ([self isViewLoaded]) {
        _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photoScrollView.frame.size.width, 0);
        
        // 显示所有的相片
        [self showPhotos];
    }
}
- (void)setPhotoArray:(NSArray *)photoArray
{
    _photoArray = photoArray;
    
    if (photoArray.count > 0) {
        _photoViewArray = [NSMutableArray arrayWithCapacity:photoArray.count];
    }
    
    for (int i = 0; i<_photoArray.count; i++) {
        WFPhoto *photo = _photoArray[i];
        photo.index = i;
        photo.firstShow = i == _currentPhotoIndex;
    }
    
}



- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}

- (void)showPhotos
{
    if(self.photoArray.count == 1)
    {
        [self showPhotoWithIndex:0];
        return;
    }
    // ***
    [self showPhotoWithIndex:self.currentPhotoIndex];
    
    [self requestNearImage];
}

- (void)showPhotoWithIndex:(NSInteger)index
{
    [self requestImageWithIndex:index];
    
    WFPhotoView *photoView = [_photoViewArray objectAtIndex:index];
    CGRect bounds = _photoScrollView.bounds;
    CGRect frame = bounds;
    frame.origin.x = (bounds.size.width * index) + kPadding;
    frame.size.width -= kPadding * 2;
    photoView.frame = frame;
}

- (void)requestNearImage
{
    // ***
    NSInteger backIndex = self.currentPhotoIndex - 1;
    NSInteger forwardIndex = self.currentPhotoIndex + 1;
    if(backIndex < 0) backIndex = 0;
    if(forwardIndex >= self.photoArray.count) forwardIndex = self.photoArray.count - 1;
    
    [self requestImageWithIndex:backIndex];
    [self requestImageWithIndex:forwardIndex];
}

- (void)requestImageWithIndex:(NSInteger)index
{
    
    WFPhotoView *photoView = [_photoViewArray objectAtIndex:index];
    [photoView requestImage];
}

- (void)updateTollbarState
{
    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateTollbarState];
    [self showPhotos];
}

- (void)photoViewSingleTap:(WFPhotoView *)photoView
{
    [UIApplication sharedApplication].statusBarHidden = _statusBarHiddenInited;
    //    self.view.backgroundColor = [UIColor clearColor];
    
    // 移除工具条
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [_toolbar removeFromSuperview];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        if(self.block_dismissCallBack)
        {
            self.block_dismissCallBack();
        }
    }];
    
}

- (void)photoViewImageFinishLoad:(WFPhotoView *)photoView
{
    [self updateTollbarState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI变化相关
- (BOOL)shouldAutorotate
{
    //    NSLog(@"是否旋转?");
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    //    NSLog(@"旋转方向");
    return UIInterfaceOrientationMaskAll;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self updateUI];
}

- (void)updateUI
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view.frame = frame;
    
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    frame.size.height -= 100;
    _photoScrollView.frame = frame;
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * self.photoArray.count, frame.size.height);
    _photoScrollView.center = CGPointMake(_photoScrollView.center.x, self.view.center.y);
    _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);
    
    CGFloat barHeight = 44;
    CGFloat barY = self.view.frame.size.height - barHeight;
    _toolbar.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
    [_toolbar updateUI];
    [self updateTollbarState];
    
    for (int i = 0; i < _photoViewArray.count; i ++)
    {
        WFPhotoView *photoView = [_photoViewArray objectAtIndex:i];
        photoView.frame = CGRectMake(frame.size.width * i + kPadding,
                                     0,
                                     frame.size.width - kPadding * 2,
                                     frame.size.height);
        
        [photoView updateUI];
    }
    
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
