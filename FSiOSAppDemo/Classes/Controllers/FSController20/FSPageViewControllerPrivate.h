//
//  FSPageViewControllerPrivate.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/26.
//  Copyright © 2018年 付森. All rights reserved.
//

#ifndef FSPageViewControllerPrivate_h
#define FSPageViewControllerPrivate_h

#import "FSPageViewController.h"

@interface FSPageViewController (Private)

- (void)p_willPresentFromView:(UIView *)fromView toView:(UIView *)toView;

- (void)p_isPresentingFromView:(UIView *)fromView toView:(UIView *)toView;

- (void)p_didPresentFromView:(UIView *)fromView toView:(UIView *)toView;


- (void)p_willDismissFromView:(UIView *)fromView toView:(UIView *)toView;

- (void)p_isDismissingFromView:(UIView *)fromView toView:(UIView *)toView;

- (void)p_didDismissFromView:(UIView *)fromView toView:(UIView *)toView;

@end

#endif /* FSPageViewControllerPrivate_h */
