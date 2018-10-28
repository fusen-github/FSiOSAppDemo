//
//  FSController15.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/26.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController15.h"


@interface FSController15 ()

@end

@implementation FSController15

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
}

- (void)doRightAction
{
    [self demo03];
}

- (void)demo03
{
    [NSThread detachNewThreadSelector:@selector(demo03_NSThread:) toTarget:self withObject:@"你好"];
}

- (void)demo03_NSThread:(id)obj
{
    /*
     开启一条子线程，没有队列的概念
     */
    
    NSLog(@"obj = %@",obj); // 你好
    
    NSLog(@"%@",[NSOperationQueue currentQueue]); // (null)
    
    for (int i = 0; i < 5; i++)
    {
        NSLog(@"%@",[NSThread currentThread]);
    }
}


- (void)demo02
{
    /*
     开启一条子线程，没有队列的概念
     */
    
    [NSThread detachNewThreadWithBlock:^{
        
        NSLog(@"%@",[NSOperationQueue currentQueue]); // (null)
        
        for (int i = 0; i < 5; i++)
        {
            NSLog(@"%@",[NSThread currentThread]);
        }
        
    }];
}

- (void)demo01
{
    /*
     只开启一条子线程，NSThread开启的线程没有队列的概念
     */
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo01_NSThread) object:nil];
    
    [thread start];
}

- (void)demo01_NSThread
{
    NSLog(@"%@",[NSOperationQueue currentQueue]); // (null)
    
    for (int i = 0; i < 5; i++)
    {
        NSLog(@"%@",[NSThread currentThread]);
    }
}


@end
