//
//  FSController07.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/15.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController07.h"
#import "FSMasterController.h"



@interface FSController07 ()<FSMasterControllerDelegate>

@property (nonatomic, weak) UISplitViewController *splitViewController;

@end

@implementation FSController07

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    
    self.splitViewController = splitViewController;
    
    splitViewController.view.backgroundColor = [UIColor whiteColor];
    
    splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
 
    [self addChildViewController:splitViewController];
    
    [self.view addSubview:splitViewController.view];
    
    FSMasterController *master = [[FSMasterController alloc] init];
    
    master.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:master];
    
    splitViewController.viewControllers = @[nav];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%@",self.parentViewController);
    
    NSLog(@"%@",self.view.superview);
    
    NSLog(@"%@",[self.view.superview superview]);
    
    NSLog(@"%@",[UIApplication sharedApplication].keyWindow);
    
    NSLog(@"%@",[UIApplication sharedApplication].keyWindow.rootViewController);
    
    NSLog(@"%@",self.presentedViewController);
    
    NSLog(@"%@",self.presentingViewController);
    
    NSLog(@"%@",self.presentationController);
}

- (void)master:(FSMasterController *)master wantToShowViewController:(UIViewController *)controller
{
    [self.splitViewController showDetailViewController:controller sender:nil];
    
    NSLog(@"付森：%@",self.splitViewController.viewControllers);
}

@end
