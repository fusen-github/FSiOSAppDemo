//
//  FSController03.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController03.h"

@interface FSController03 ()

@end

@implementation FSController03

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightAction)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat btnX = (self.view.bounds.size.width - 100) * 0.5;
    
    button.frame = CGRectMake(btnX, 100, 100, 40);
    
    button.backgroundColor = [UIColor redColor];
    
    [button setTitle:@"title" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickRedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

- (void)clickRedButton:(UIButton *)button
{
    NSString *title = @"提示";
    
    NSString *message = @"描述信息";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"click ok");
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"cancelAction");
    }];
    
    [alertController addAction:okAction];

    [alertController addAction:cancelAction];

    alertController.transitioningDelegate = (id<UIViewControllerTransitioningDelegate>)self;
    
    UIPopoverPresentationController *popoverController = alertController.popoverPresentationController;
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return nil;
}

- (void)clickRightAction
{
    
    
    
}



@end
