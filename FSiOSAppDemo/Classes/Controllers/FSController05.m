//
//  FSController05.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController05.h"

@interface FSController05 ()

@end

@implementation FSController05

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor greenColor];
    
    
    
}

- (BOOL)shouldAutorotate
{
    BOOL value = [super shouldAutorotate];
    
    return value;
}

/*
 屏幕旋转有app级别和UIViewController2个级别，其中app级别高于UIViewController级别
 在UIViewController中返回界面旋转的值只能是在app级别中已经勾选的值，否则程序会崩溃
 在UIViewController中方法shouldAutorotate和supportedInterfaceOrientations是控制界面旋转的方法
 */

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
//}

@end
