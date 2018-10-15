//
//  AppDelegate.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/8/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FSNavigationController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

/*
 app状态总结：
 1、未运行(not running)
 2、活跃(Active)
 3、后台(Background)
 4、挂起(suspended)
 5、不活跃(Inactive)
 
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *root = [[ViewController alloc] init];
    
    FSNavigationController *navController = [[FSNavigationController alloc] initWithRootViewController:root];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    NSLog(@"%s",__func__);
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"%s",__func__);
    
    /* app进入后台后会有5s的挂起状态，之后app有可能会被系统杀死。
       下面的方法可以在app进入到后台后申请更多的时间来处理一些事情
     在事情处理完成后再次调用endBackgroundTask:方法，结束后台任务
     */
    __block UIBackgroundTaskIdentifier identifier = [application beginBackgroundTaskWithExpirationHandler:^{
        
        [application endBackgroundTask:identifier];
    }];
    
    if (identifier == UIBackgroundTaskInvalid)
    {
        NSLog(@"UIBackgroundTaskInvalid");
        
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSLog(@"开始执行后台任务");
        
        
        [application endBackgroundTask:identifier];
        
    });
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"%s",__func__);
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSLog(@"%s",__func__);
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    
    NSLog(@"%s",__func__);
}


@end
