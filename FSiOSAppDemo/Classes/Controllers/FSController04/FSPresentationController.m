//
//  FSPresentationController.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSPresentationController.h"

@interface FSPresentationController ()

@property (nonatomic, weak) UIControl *backgroundControl;

@end

@implementation FSPresentationController

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    NSLog(@"%s",__func__);
    
}


- (void)containerViewDidLayoutSubviews
{
    [super containerViewDidLayoutSubviews];
    
    NSLog(@"%s",__func__);
}

- (void)presentationTransitionWillBegin
{
    [super presentationTransitionWillBegin];
    
    NSLog(@"%s",__func__);
    
    self.containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIControl *backgroundControl = [[UIControl alloc] init];
    
    self.backgroundControl = backgroundControl;
    
    [backgroundControl addTarget:self
                          action:@selector(clickBackgroundControl:)
                forControlEvents:UIControlEventTouchUpInside];
    
    backgroundControl.frame = self.containerView.bounds;
    
    [self.containerView addSubview:backgroundControl];
}

- (void)clickBackgroundControl:(UIControl *)control
{
    NSLog(@"来了");
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    [super presentationTransitionDidEnd:completed];
    
    NSLog(@"%s",__func__);
}


- (void)dismissalTransitionWillBegin
{
    [super dismissalTransitionWillBegin];
    
    NSLog(@"%s",__func__);
}


- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    [super dismissalTransitionDidEnd:completed];
    
    NSLog(@"%s",__func__);
}


- (CGRect)frameOfPresentedViewInContainerView
{
//    CGRect rect = [super frameOfPresentedViewInContainerView]; preferredContentSize
    
    NSLog(@"%@",self.containerView);
    
    NSLog(@"%@",self.presentedView);
    
    CGSize size = self.presentedViewController.preferredContentSize;
    
    CGRect rect = CGRectMake(100, 200, size.width, size.height);
    
    return rect;
}

@end
