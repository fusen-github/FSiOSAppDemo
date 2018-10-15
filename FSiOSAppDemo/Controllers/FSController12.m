//
//  FSController12.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/15.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController12.h"

@interface FSController12 ()

@end

@implementation FSController12

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)demo02
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
       
        /*  一个耗时任务  */
        
        /* 将一个任务细分，可以分成很小的块来完成，可以将部分小块添加到“分派组“内执行。 */
        /// 创建一个“分派组”。”分派组“可以添加一些小块任务，然后并发执行这些小块任务，以提高执行效率
        dispatch_group_t group_t = dispatch_group_create();
        
        /// 小任务块1
        dispatch_group_async(group_t, queue, ^{
            
        });
        
        /// 小任务块2
        dispatch_group_async(group_t, queue, ^{
            
        });
        
        // ..... n个小任务块
        
        /// 在”分派组“内添加的n个小任务块都执行完成后的通知方法
        dispatch_group_notify(group_t, queue, ^{
            
            /// ”分派组“group_t内的小任务块都执行完成后的通知方法
            
        });
        
        
        
    });
}

/**
 简单的开辟一个子线程，并在子线程中串行执行该任务的每条语句
 1、创建一个全局队列(queue)
 2、将block中的任务派发到全局队列中
 3、系统会自动开启一个子线程，并将子线程中的任务顺序的执行
 */
- (void)demo01
{
    /// priority
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        /// 代码块，gcd获取代码块，并将代码块放到队列中，在线程中运行并一次执行一步
        /*   需要在子线程中执行的代码   */
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}



@end
