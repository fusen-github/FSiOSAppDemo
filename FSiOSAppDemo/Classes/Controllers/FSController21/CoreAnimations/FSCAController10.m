//
//  FSCAController10.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/5.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController10.h"

@interface FSCAController10 ()<UINavigationControllerDelegate>

@end

@implementation FSCAController10

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.navigationController.delegate = self;
    
    UIViewController *controller = [[UIViewController alloc] init];
    
    controller.title = @"xxxxx";
    
//    NSLog(@"%@",controller);
    
    [self.navigationController pushViewController:controller animated:YES];
    
    controller.view.backgroundColor = [UIColor redColor];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"%@",viewController);
    
    CATransition *transition = [CATransition animation];
    
    transition.duration = 2.5;
    
    transition.type = kCATransitionPush;
    
    transition.subtype = kCATransitionFromLeft;
    
//    transition.autoreverses = YES;
    
    [navigationController.view.layer addAnimation:transition forKey:nil];
    
}

@end
