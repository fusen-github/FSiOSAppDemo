//
//  FSController04.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController04.h"
#import "FSPopoverContainer.h"
#import "FSPresentationController.h"



@interface FSController04 ()

@end

@implementation FSController04

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self demo02:button];
}

- (void)demo01:(UIButton *)button
{
    FSPopoverContainer *controller = [[FSPopoverContainer alloc] init];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
//    UIModalPresentationFullScreen
    
    UIPopoverPresentationController *ppc = controller.popoverPresentationController;
    
    id obj = controller.presentationController;
    
    if (ppc)
    {
        ppc.sourceView = button;
        
        ppc.sourceRect = button.bounds;
        
        ppc.backgroundColor = [UIColor cyanColor];
        
        [ppc addObserver:self forKeyPath:@"containerView" options:NSKeyValueObservingOptionNew context:nil];
        
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        
        [ppc addObserver:self forKeyPath:@"containerView.superview" options:options context:nil];
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"containerView"])
    {
        UIView *containerView = [change objectForKey:NSKeyValueChangeNewKey];
        
        if ([containerView isKindOfClass:[UIView class]])
        {
            containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            
            NSLog(@"%@",containerView.superview);
        }
    }
    else if ([keyPath isEqualToString:@"containerView.superview"])
    {
        UIView *superview = [change objectForKey:NSKeyValueChangeNewKey];
        
        if ([superview isKindOfClass:[UIView class]])
        {
            NSLog(@"%@",superview);
        }
        
        NSLog(@"%@",superview);
    }
}

- (void)demo02:(UIButton *)button
{
    FSPopoverContainer *container = [[FSPopoverContainer alloc] init];
    
    container.modalPresentationStyle = UIModalPresentationCustom;
    
    container.transitioningDelegate = (id<UIViewControllerTransitioningDelegate>)self;
    
    [self presentViewController:container animated:YES completion:nil];
}

//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
//    return nil;
//}
//
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    return nil;
//}
//
//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//    return nil;
//}
//
//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//    return nil;
//}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    FSPresentationController *controller = [[FSPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    NSLog(@"presented: %@",presented.view);

    NSLog(@"presenting: %@",presenting.view);

    NSLog(@"source: %@",source);

    return controller;
}

- (void)dealloc
{
//    [self removeObserver:<#(nonnull NSObject *)#> forKeyPath:<#(nonnull NSString *)#>]
}

@end

