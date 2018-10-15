//
//  FSController12.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/15.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController12.h"
#import <AVFoundation/AVFoundation.h>


@interface FSController12 ()

@end

@implementation FSController12

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"rigth" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
}

- (void)doRightAction
{
    [self demo07];
}


/**
 dispatch_barrier_async 处理数据竞争问题
 */
- (void)demo07
{
    /*
     利用串行(DISPATCH_QUEUE_SERIAL)队列可以防止多线程资源抢夺，但是效率低
     使用dispatch_barrier_async可以兼顾资源抢夺和低效率问题
     */
//    dispatch_barrier_sync(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
    
//    dispatch_barrier_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
    
    /*
     eg: 一个队列上有多个读写操作，实现在执行”读操作“时可以并发执行，在执行”写操作“时保证在“写操作”之前加到队列queue上的“读操作”
        能都并发执行完。此时执行”修改操作“,且同时只执行一个任务。待”修改操作“执行完后再并发执行”读操作“
     */
    
    __block NSString *data = @"123";
    
    /// 创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("dmeo07.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
       
        NSLog(@"data1: %@",data);
        
        NSLog(@"操作1---读取");
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"data2: %@",data);
        
        NSLog(@"操作2---读取");
    });
    
    dispatch_barrier_async(queue, ^{
       
        [NSThread sleepForTimeInterval:1];
        
        data = @"456789";
        
        NSLog(@"操作3---修改操作");
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"data4: %@",data);
        
        NSLog(@"操作4---读取");
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"data5: %@",data);
        
        NSLog(@"操作5---读取");
    });
    
    
}

/**
 dispatch_group_t 队列组
 */
- (void)demo06
{
    /*
     在一个队列中的所有任务都执行完成后拿到一个通知消息
     1、对于一个串行队列(DISPATCH_QUEUE_SERIAL)，由于在改队列中添加的所有的任务都是按顺序执行的，所以只需要在这个串行队列的最后追加一个“全部完成”的任务即可
     2、对于一个并发队列(DISPATCH_QUEUE_CONCURRENT),由于该队列中的所有任务是并发执行的，所以要想在该队列上的所有任务都执行完成后拿到一个通知，需要借助dispatch_group_t(队列组)
     */
    
    // eg:
    dispatch_queue_t concurrentQueue = dispatch_queue_create("demo06.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, concurrentQueue, ^{
       
        [NSThread sleepForTimeInterval:0.3];
        
        NSLog(@"任务块1");
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        
        [NSThread sleepForTimeInterval:0.3];
        
        NSLog(@"任务块2");
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        
        [NSThread sleepForTimeInterval:0.1];
        
        NSLog(@"任务块3");
    });
    
    // .....
    
    /// 方式一：
    {
        /// group中的任务都完成后的通知队列（异步的，上述不执行完，下面的NSLog也会执行）
//        dispatch_queue_t notify_queue = dispatch_get_main_queue();
//
//        dispatch_group_notify(group, notify_queue, ^{
//
//            NSLog(@"队列组中的所有任务都执行完成后的通知");
//        });
    }
    
    /// 方式二：
    {
        ///  等待group中的任务执行完后（同步的，在给定的等待时间内一直等待group中的任务，超过了等待时间则不再等待）
        
        /// 等待时间(5s)
        dispatch_time_t waitTime = dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);
        
        /// 一直等待
        waitTime = DISPATCH_TIME_FOREVER;
        
        long rst = dispatch_group_wait(group, waitTime);
        
        if (rst == 0)
        {
            /// 说明group中的任务全部执行完成
            /// 当waitTime == DISPATCH_TIME_FOREVER, rst 恒等于 0
        }
        else
        {
            /// 说明超过了等待时间，group中还有未完成的任务
        }
    }
    
    // 以上“方式一”和“方式二” 推荐使用“方式二”
    
    
    NSLog(@"laiel");
    
}

/**
 延时处理函数
 */
- (void)demo05
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        /// 延时3s后，在dispatch_get_main_queue队列上执行该block(任务)
    });
    
    /// NSEC_PER_SEC 秒
    /// NSEC_PER_MSEC 毫秒
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    
    dispatch_after(when, dispatch_get_main_queue(), ^{
       
        
    });
    
}

/**
 设置自定义queue的优先级
 */
- (void)demo04
{
    /// 自定义 串行队列
    dispatch_queue_t create_queue_SERIAL = dispatch_queue_create("demo04.queue", DISPATCH_QUEUE_SERIAL);
    
    /// 自定义 并发队列
    dispatch_queue_t create_queue_CONCURRENT = dispatch_queue_create("demo04.queue", DISPATCH_QUEUE_CONCURRENT);

    /*
     备注:上述通过dispatch_queue_create创建的队列的优先级默认是DISPATCH_QUEUE_PRIORITY_DEFAULT
         可以通过"dispatch_set_target_queue"函数修改优先级
     */
    
    /*
     参数1: 想要改变优先级的queue
     参数2: 用参数2队列的优先级来设置参数1的优先级
     */
//    dispatch_set_target_queue(<#dispatch_object_t  _Nonnull object#>, <#dispatch_queue_t  _Nullable queue#>)
    
}

/**
 队列 dispatch_queue_t
 */
- (void)demo03
{
    
    /*
     创建dispatch_queue_t，第2个参数指定队列的属性(常用的2个DISPATCH_QUEUE_SERIAL和DISPATCH_QUEUE_CONCURRENT)
     DISPATCH_QUEUE_SERIAL(串行):指定一个队列在同一时间只能执行一个任务。可以创建多个这种队列，实现并发执行效果
     DISPATCH_QUEUE_CONCURRENT(并发):指定一个队列在同一时间可以执行多个任务，真正的并发效果
     */
    dispatch_queue_attr_t queue_attr = DISPATCH_QUEUE_SERIAL;
    
    queue_attr = DISPATCH_QUEUE_CONCURRENT;
    
    /// 自己创建的队列
    dispatch_queue_t create_queue = dispatch_queue_create("fusen.queue", queue_attr);
    
    dispatch_async(create_queue, ^{
       
        NSLog(@"异步任务，被添加到队列queue上");
        
    });
    
    /// 四种优先级的全局并发队列 （优先级是一个标识，并不是很绝对）
    dispatch_queue_t global_queue_high = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_queue_t global_queue_default = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t global_queue_low = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    
    dispatch_queue_t global_queue_bg = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    /// 主队列
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    
}


/**
 简单实践
 */
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
