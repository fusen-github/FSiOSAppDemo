//
//  FSPageController.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSBaseViewController.h"

@class FSPageViewController;
@protocol FSPageViewControllerDataSource <NSObject>

@required
/// 获取一共有多少页(必须实现)
- (NSUInteger)numberOfPagesInViewController:(FSPageViewController *)controller;

/// 获取图片(必须实现) PS:如果是加载本地图片直接提供最后要显示的图片，如果是加载网络图片可以先提供一个缩略图
- (UIImage *)viewController:(FSPageViewController *)controller imageForPageAtIndex:(NSUInteger)index;

/**
 获取缩略图
 */
- (UIView *)thumbViewForPageAtIndex:(NSInteger)index;

@optional

- (void)viewController:(FSPageViewController *)controller presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progressHandler;


@end

@protocol FSPageViewControllerDelegate <NSObject>

@optional
- (void)viewController:(FSPageViewController *)controller singleTapAtIndex:(NSUInteger)index presentedImage:(UIImage *)image;

- (void)viewController:(FSPageViewController *)controller longPressAtIndex:(NSUInteger)index presentedImage:(UIImage *)image;

@end

@interface FSPageViewController : UIViewController

- (instancetype)initWithNavigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation startIndex:(NSUInteger)index;

//@property (nonatomic, assign, readonly) NSUInteger currentIndex;

@property (nonatomic, weak) id<FSPageViewControllerDataSource> dataSource;

@property (nonatomic, weak) id<FSPageViewControllerDelegate> delegate;

@end
