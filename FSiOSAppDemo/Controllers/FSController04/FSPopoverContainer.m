//
//  FSPopoverContainer.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSPopoverContainer.h"

@interface FSPopoverContainer ()

@end

@implementation FSPopoverContainer

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
}

- (CGSize)preferredContentSize
{
    return CGSizeMake(300, 300);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    NSLog(@"%@",self.view.subviews);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    NSLog(@"%@",self.popoverPresentationController.presentedViewController.view);
    
    NSLog(@"%@",self.popoverPresentationController.presentingViewController.view);
    
    UIView *view = self.popoverPresentationController.presentingViewController.view;
    
    //    view.backgroundColor = [UIColor redColor];
    
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
