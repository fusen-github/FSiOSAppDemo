//
//  FSRefreshHeader.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSRefreshComponent.h"

@interface FSRefreshHeader : FSRefreshComponent

/**
 立即进入刷新状态
 */
- (void)beginRefreshing;

- (void)endRefreshing;

@end
