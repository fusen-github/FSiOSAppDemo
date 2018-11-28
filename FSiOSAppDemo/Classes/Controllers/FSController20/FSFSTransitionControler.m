//
//  FSFSTransitionControler.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSFSTransitionControler.h"
#import "FSPageViewControllerPrivate.h"


@interface FSFSTransitionControler ()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresenting;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, weak) FSPageViewController *employer;

@end

@implementation FSFSTransitionControler

- (instancetype)initWithEmployer:(FSPageViewController *)employer
{
    if (self = [super init])
    {
        self.employer = employer;
    }
    return self;
}

- (UIView *)coverView
{
    if (_coverView == nil)
    {
        _coverView = [[UIView alloc] init];
        
        _coverView.backgroundColor = [UIColor blackColor];
        
        _coverView.alpha = 0.25;
        
        _coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _coverView.clipsToBounds = YES;
        
        _coverView.multipleTouchEnabled = NO;
        
        _coverView.userInteractionEnabled = NO;
    }
    return _coverView;
}

#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isPresenting = YES;
    
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresenting = NO;
    
    return self;
}


#pragma mark UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    
    if (containerView == nil) {
        return;
    }
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *fromView = fromVC.view;
    
    if (fromView == nil) {
        return;
    }
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    
    if (toView == nil) {
        return;
    }
    
    if (self.isPresenting)
    {
        self.coverView.frame = containerView.bounds;
        
        [containerView addSubview:self.coverView];
        
        toVC.view.frame = containerView.bounds;
        
        [containerView addSubview:toVC.view];
        
        [self.employer p_willPresentFromView:fromView toView:toView];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

        NSTimeInterval duration = [self transitionDuration:transitionContext];
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:[self _animationOptions]
                         animations:^{
                             
                             self.coverView.alpha = 0.75;
                             
                             [self.employer p_isPresentingFromView:fromView toView:toView];
                         }
                         completion:^(BOOL finished) {
                             
                             [self.employer p_didPresentFromView:fromView toView:toView];
                             
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             
                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         }];
    }
    else
    {
        [containerView addSubview:fromView];
        
        [self.employer p_willDismissFromView:fromView toView:toView];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:[self _animationOptions]
                         animations:^{
                             
                             self.coverView.alpha = 0.05;
                             
                             [self.employer p_isDismissingFromView:fromView toView:toView];
                             
                         } completion:^(BOOL finished) {
                             
                             self.coverView.alpha = 0;
                             
                             [self.employer p_didDismissFromView:fromView toView:toView];
                             
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             
                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         }];

    }
    
    
}

- (UIViewAnimationOptions)_animationOptions
{
//    return 7 << 16;
    
    return UIViewAnimationOptionTransitionNone;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
