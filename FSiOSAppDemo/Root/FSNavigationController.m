//
//  FSNavigationController.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSNavigationController.h"

@interface FSNavigationController ()

@end

@implementation FSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
