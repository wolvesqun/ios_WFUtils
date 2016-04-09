//
//  WFPhotoToolbar.m
//  testWFPhotoBrowser
//
//  Created by mba on 15/12/17.
//  Copyright © 2015年 ubmlib. All rights reserved.
//

#import "WFPhotoToolbar.h"
#import "WFPhoto.h"
//#import "MBProgressHUD.h"
//#import "MBProgressHUD+Add.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <PhotosUI/PhotosUI.h>

@interface WFPhotoToolbar ()

{
    // 显示页码
    UILabel *_indexLabel;
    UIButton *_saveImageBtn;
}

@end

@implementation WFPhotoToolbar

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (_photos.count > 1) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.font = [UIFont boldSystemFontOfSize:20];
        _indexLabel.frame = self.bounds;
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_indexLabel];
    }
    
    // 保存图片按钮
    CGFloat btnWidth = self.bounds.size.height;
    _saveImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveImageBtn.frame = CGRectMake(20, 0, btnWidth, btnWidth);
    _saveImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_saveImageBtn setImage:[UIImage imageNamed:@"WFPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    [_saveImageBtn setImage:[UIImage imageNamed:@"WFPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [_saveImageBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveImageBtn];
}

- (void)saveImage
{
    WFPhoto *photo = _photos[_currentPhotoIndex];
    [self createAlbumAndSaveImageWithAlbumName:@"MBA智库百科" andImageData:UIImagePNGRepresentation(photo.image)];
}




#pragma mark - 创建相册
- (void)createAlbumAndSaveImageWithAlbumName:(NSString *)albumName andImageData:(NSData *)imageData
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups=[[NSMutableArray alloc]init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group){
            [groups addObject:group];
            
        }else{
            BOOL haveHDRGroup = NO;
            
            for (ALAssetsGroup *gp in groups){
                NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                
                if ([name isEqualToString:albumName]){//folder name
                    haveHDRGroup = YES;
                }
            }
            
            if (!haveHDRGroup){
                
                //do add a group named "XXXX"
                if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
//                    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                        
//                        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
//                        
//                    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//                        if (!success) {
//                            NSLog(@"Error creating album: %@", error);
//                        }
//                    }];
                    
                }else{
                    
                    [assetsLibrary addAssetsGroupAlbumWithName:albumName//folder name
                                                   resultBlock:^(ALAssetsGroup *group)
                     {
                         if (group != nil) {
                             [groups addObject:group];
                         }
                         
                         
                     }failureBlock:nil];
                }
                
                
                
                
                haveHDRGroup = YES;
            }
        }
        
    };
    //创建相簿
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
    
    [self saveToAlbumWithMetadata:nil
                        imageData:imageData//[NSData dataWithContentsOfURL:[NSURL URLWithString:self.currentImgURL]]
                  customAlbumName:albumName//folder name
                  completionBlock:^{
                      //这里可以创建添加成功的方法
//                      [Toast show:@"保存成功"];
                      
                  }failureBlock:^(NSError *error){
                      //处理添加失败的方法显示alert让它回到主线程执行，不然那个框框死活不肯弹出来
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                          //添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
                          if([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound ||[error.localizedDescription rangeOfString:@"用户拒绝访问"].location!=NSNotFound){
                              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
                              
                              [alert show];
                          }
                      });
                  }];
}



//***
- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock
{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    __weak ALAssetsLibrary *weakSelf = assetsLibrary;
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock();
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [weakSelf assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        if (completionBlock) {
                            completionBlock();
                        }
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                } else {
                    AddAsset(weakSelf, assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(weakSelf, assetURL);
            }];
        } else {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}



- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _indexLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_currentPhotoIndex + 1, (int)_photos.count];
    
    WFPhoto *photo = _photos[_currentPhotoIndex];
    // 按钮
    _saveImageBtn.enabled = photo.image != nil && !photo.save;
}

- (void)updateUI
{
    CGFloat btnWidth = self.bounds.size.height;
    _saveImageBtn.frame = CGRectMake(20, 0, btnWidth, btnWidth);
}
@end
