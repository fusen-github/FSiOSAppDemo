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

/*
 GCD理解:
 GCD = 队列 + 任务 + 任务的执行方式(同步 or 异步)
 1、将一个或多个任务添加到一个队列中，由队列统一管理
 2、针对每个任务都指定了该任务的执行方式(同步:dispatch_sync, 异步:dispatch_async)
 3、同步(dispatch_sync)指在当前线程执行该任务。
 4、异步(dispatch_async)指不在当前线程执行任务，而是在另一个线程(可以是一个子线程、也可以是主线程)执行该任务。
 5、线程:GCD底层维护了一个可调度线程池，需要使用线程时，直接从线程池拿一个线程来用。用完后再把线程还给线程池。在GCD中线程不会销毁，而是被缓存到线程池里，需要用的时候直接获取。区别于NSThread每次创建一个线程，用完后该线程就销毁。再需要用时再创建。
 */

/*
 GCD队列
 1、 主队列: dispatch_get_main_queue(),专门调度任务到主线程去执行
 2、 全局队列: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
 3、 串行队列: dispatch_queue_create("queue_id", DISPATCH_QUEUE_SERIAL)
 3、 并发队列: dispatch_queue_create("queue_id", DISPATCH_QUEUE_CONCURRENT)
 */

- (void)doRightAction
{
    [self demo13];
}

- (void)demo19
{
    
}

- (void)demo18
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        /* 循环是顺序执行的 */
        for (int i = 0; i < 20; i++)
        {
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSLog(@"main_queue: %@",[NSThread currentThread]);
        });
        
        NSLog(@"来了");
    });
}

- (void)demo17
{
    dispatch_queue_t queue = dispatch_queue_create("fusen", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
       
        /* 循环是顺序执行的 */
        for (int i = 0; i < 20; i++)
        {
            NSLog(@"%@ - %d", [NSThread currentThread], i);
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       
        NSLog(@"dispatch_group_notify: %@",[NSThread currentThread]);
    });
    
    /// 该log先打印
    NSLog(@"来了");
}

- (void)demo16
{
    dispatch_queue_t queue = dispatch_queue_create("fusen", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"begin");
    
    dispatch_sync(queue, ^{
        
        [NSThread sleepForTimeInterval:5];
        
        NSLog(@"111, %@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"222, %@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"333, %@",[NSThread currentThread]);
    });
    
    NSLog(@"end");
}

- (void)demo15
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSLog(@"1: %@",[NSThread currentThread]);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            NSLog(@"2: %@",[NSThread currentThread]);
            
        });
        
        NSLog(@"3: %@",[NSThread currentThread]);
    });
    
    NSLog(@"start: %@",[NSThread currentThread]);
    
    /*
     dispatch_main方法会唤醒主线程，但是在Runloop中主线程一直都是唤醒状态。所以调用该方法不会返回。
     */
//    dispatch_main();
    
    NSLog(@"end: %@",[NSThread currentThread]);
}

- (void)demo14
{
    /*
     全局并发队列
     */
    dispatch_queue_t global_concurrent_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(global_concurrent_queue, ^{
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.2];
            
            NSLog(@"a、i = %d, %@",i, [NSThread currentThread]);
        }
    });
    
    dispatch_async(global_concurrent_queue, ^{
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.05];
            
            NSLog(@"b、i = %d, %@",i, [NSThread currentThread]);
        }
    });
    
    dispatch_async(global_concurrent_queue, ^{
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.1];
            
            NSLog(@"c、i = %d, %@",i, [NSThread currentThread]);
        }
    });
}

- (void)demo13_1
{
    
}

/**
 dispatch_semaphore_t
 */
- (void)demo13
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    
    for (int i = 0; i < 10; i++)
    {
        /**
         并发执行，无序的
         */
        dispatch_group_async(group, queue, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            [NSThread sleepForTimeInterval:1];
            
//            [tmpArray addObject:@(i)];
            
            NSLog(@"%@, i = %i", [NSThread currentThread], i);
            
            dispatch_semaphore_signal(semaphore);
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        
        NSLog(@"结束了，用时: %lf",(end - start));
    });
    
    NSLog(@"end");
}


/**
 dispatch_semaphore_t
 */
- (void)demo12
{
    /*
     dispatch_semaphore_t: 持有计数的信号
     
     */
    
    /// 创建信号量变量(计数的初始值设置为1)
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    
    /*
     当信号量(semaphore)的值 >= 1时，做减法并将结果从dispatch_semaphore_wait函数返回，此时不等待
     当信号量(semaphore)的值 == 0时，等待
     */
    long rst = dispatch_semaphore_wait(semaphore, timeout);
    
    if (rst == 0)
    {
        
    }
    else
    {
        //
    }
    
//    [NSStream ]
    
}


/**
 dispatch_semaphore_t
 */
- (void)demo11
{
    /*
     在for 循环中使用dispatch_queue_t，由于内存错误导致程序崩溃，使用dispatch_semaphore_t解决
     */
    
    
    /**
     该程序会崩溃
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < 10000; i++)
    {
        dispatch_async(queue, ^{

            [tmpArray addObject:@(i)];
        });
    }
    
    NSLog(@"end");
}

/**
 队列挂起：dispatch_suspend
 队列恢复：dispatch_resume
 */
- (void)demo10
{
    /*
     在一个队列中有时需要暂停队列的执行，在某个时刻恢复队列的执行
     */
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
       
        /// 任务1
    });
    
    dispatch_async(queue, ^{
        
        /// 任务2
        
        BOOL condition1 = YES;
        
        if (condition1)
        {
            dispatch_suspend(queue);
        }
        
        BOOL condition2 = YES;
        
        if (condition2)
        {
            dispatch_resume(queue);
        }
        
    });
    
//    dispatch_suspend(<#dispatch_object_t  _Nonnull object#>)
    
//    dispatch_resume(<#dispatch_object_t  _Nonnull object#>)
    
}


/**
 dispatch_apply
 */
- (void)demo09
{
    /*
     dispatch_apply函数按指定的次数将block里的任务追加到指定的队列(queue)中，并等待全部处理执行结束
     */
    
    NSArray *array = @[@"张三",@"李四",@"王五",@"赵六",@"刘七",@"宋八"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
       
        dispatch_apply(array.count, queue, ^(size_t index) {
            
            NSInteger tmp = arc4random() % 5;
            
            [NSThread sleepForTimeInterval:tmp * 0.01];
            
            NSLog(@"index = %ld, %@",index, [NSThread currentThread]);
        });
        
        NSLog(@"end-------");
    });
    
    NSLog(@"end");
    
}

- (void)demo08_02
{
    NSArray *array = @[@"张三",@"李四",@"王五",@"赵六",@"刘七",@"宋八"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
//        for (int i = 0; i < array.count; i++)
//        {
//            NSLog(@"index = %@, obj = %@, thread = %@",@(i), array[i], [NSThread currentThread]);
//        }
        
        dispatch_apply(array.count, queue, ^(size_t index) {
            
            [NSThread sleepForTimeInterval:0.1 * (arc4random() % array.count)];
            
            NSLog(@"index = %@, obj = %@, thread = %@",@(index), array[index], [NSThread currentThread]);
        });
        
        NSLog(@"done");
    });
    
    NSLog(@"end");
}

- (void)demo08_01
{
    NSArray *array = @[@"张三",@"李四",@"王五",@"赵六",@"刘七",@"宋八"];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
       
        for (int i = 0; i < array.count; i++)
        {
            NSLog(@"index = %@, obj = %@, thread = %@",@(i), array[i], [NSThread currentThread]);
        }
        
        NSLog(@"done");
    });
    
    NSLog(@"end");
}

/**
 dispatch_apply
 */
- (void)demo08
{
    NSArray *array = @[@"张三",@"李四",@"王五",@"赵六",@"刘七",@"宋八"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply(10, queue, ^(size_t index) {
       
        NSInteger tmp = arc4random() % 5;
        
        [NSThread sleepForTimeInterval:tmp * 0.01];
        
        NSLog(@"index = %ld, %@",index, [NSThread currentThread]);
        
    });
    
    NSLog(@"end");
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
       
        [NSThread sleepForTimeInterval:0.2];
        
        NSLog(@"操作1---读取, data1: %@, %@",data, [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:3];
        
        NSLog(@"操作2---读取, data1: %@, %@",data, [NSThread currentThread]);

    });
    
//    dispatch_barrier_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)

//    dispatch_barrier_sync(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)

    /* 同步任务:在当前线程。 异步任务:在一个新线程 */
    dispatch_barrier_sync(queue, ^{
       
        NSLog(@"dispatch_barrier_async start");
        
        [NSThread sleepForTimeInterval:3];
        
        data = @"456789";
        
        NSLog(@"操作3---修改操作, data1: %@, %@",data, [NSThread currentThread]);

    });
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:0.5];
        
        NSLog(@"操作4---读取, data1: %@, %@",data, [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:0.4];
        
        NSLog(@"操作5---读取, data1: %@, %@",data, [NSThread currentThread]);

    });
    
    
}

/**
 dispatch_group_t 队列组
 */
- (void)demo06
{
    /*
     在一个队列中的所有任务都执行完成后拿到一个通知消息
     1、对于一个串行队列(DISPATCH_QUEUE_SERIAL)，由于在该队列中添加的所有的任务都是按顺序执行的，所以只需要在这个串行队列的最后追加一个“全部完成”的任务即可
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
