//
//  FSFSTransitionControler.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSPageViewController;

@interface FSFSTransitionControler : NSObject<UIViewControllerTransitioningDelegate>

- (instancetype)initWithEmployer:(FSPageViewController *)employer;

@end
