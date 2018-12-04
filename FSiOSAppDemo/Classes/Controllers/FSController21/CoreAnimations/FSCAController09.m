//
//  FSCAController09.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/4.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController09.h"

@interface FSCAController09 ()<UITabBarControllerDelegate>

@end

@implementation FSCAController09

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *first = [[UIViewController alloc] init];
    
    UIViewController *second = [[UIViewController alloc] init];
    
    UIViewController *three = [[UIViewController alloc] init];
    
    UIViewController *four = [[UIViewController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    tabBarController.viewControllers = @[first, second, three, four];
    
    tabBarController.delegate = self;
    
    [self.navigationController pushViewController:tabBarController animated:YES];
    
    first.tabBarItem.title = @"first";
    first.view.backgroundColor = UIColorRandom;
    
    
    second.tabBarItem.title = @"second";
    second.view.backgroundColor = UIColorRandom;

    
    three.tabBarItem.title = @"three";
    three.view.backgroundColor = UIColorRandom;

    
    four.tabBarItem.title = @"four";
    four.view.backgroundColor = UIColorRandom;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CATransition *animation = [CATransition animation];
    
    animation.type = kCATransitionReveal;
    
    animation.subtype = kCATransitionFromLeft;
    
    animation.duration = 1;
    
    [tabBarController.view.layer addAnimation:animation forKey:nil];
}

@end
