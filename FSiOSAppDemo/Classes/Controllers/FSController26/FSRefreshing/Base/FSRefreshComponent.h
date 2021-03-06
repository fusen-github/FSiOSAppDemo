//
//  FSRefreshComponent.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FSRefreshStatus){
    
    /* 闲置状态 */
    FSRefreshStatusIdle,
    /* 即将刷新的状态(松手立即刷新) */
    FSRefreshStatusWillRefresh,
    /* 正在刷新状态 */
    FSRefreshStatusRefreshing,
    /* 没有更多数据的状态 */
    FSRefreshStatusNoMoreData,
};

@interface FSRefreshComponent : UIControl

- (UIEdgeInsets)scrollViewEdgeInsets:(UIScrollView *)scrollView;

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary<NSKeyValueChangeKey,id> *)change;

@end

@interface UIScrollView (FSRefresh)

@property (nonatomic, weak) FSRefreshComponent *fs_refreshHeader;

@end
