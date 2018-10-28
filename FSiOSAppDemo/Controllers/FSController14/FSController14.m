//
//  FSController14.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController14.h"
#import "FSOperation.h"

/*
 queue:队列，可以理解成是车间里的一条生产线
 
 operate:操作，可以理解成是一条生产线上的一个员工
 
 */

@interface FSController14 ()<UITableViewDataSource>

@property (nonatomic, weak) NSOperationQueue *queue;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FSController14

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    tableView.frame = self.view.bounds;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    NSLog(@"viewDidLoad:%@",[NSOperationQueue currentQueue]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer *timer) {
//
//        NSLog(@"op_count = %ld, %@",self.queue.operationCount, self.queue);
//    }];
    
//    self.timer = timer;
//
//    [timer fire];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)doRightAction
{
    [self demo07];
}

- (void)demo08
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo08_NSThread:) object:@"sen"];
    
    [thread start];
}

- (void)demo08_NSThread:(id)obj
{
    NSLog(@"obj = %@",obj);
    
    NSLog(@"%@",[NSOperationQueue currentQueue]);
    
    for (int i = 0; i < 5; i++)
    {
        NSLog(@"i = %d, %@", i, [NSThread currentThread]);
    }
}

/*
 NSOperation 和 NSOperationQueue中对
 进程、队列、操作、任务、线程、的理解：
 
 Tips: (队列严格按照先进先出的原则，FIFO)
 如果把进程看做一个集团公司的运作过程，那么队列、线程、操作、任务可以理解成以下情况
 1、启动app，就是开启一个进程。【相当于创办一家集团公司】
 2、进程启动后就会开启一个主队列，此时主队列里有有一条线程叫做主线程。【相当于该公司有一条主产品线，维持着集团公司的正常运作】
 3、主队列中可以运行主线程，也可以运行子线程。除了主线程，新开启的线程都是子线程。
    3.1、主队列: [NSOperationQueue mainQueue]
 4、当需要的时候进程开启一个新的队列，叫子队列。【相当于公司开了一家子公司】
    4.1、子队列: [[NSOperationQueue alloc] init]
 5、子队列(子公司)中可以开启一条或多条线程，这些线程都是子线程(ps:子线程只能在子队列中执行)。【相当于子公司可以开启多条生产线】
    5.1、通过[[NSOperationQueue alloc] init]. 创建的子队列中可以开启一条线程、也可以开启多条线程
    5.2、设置 NSOperationQueue.maxConcurrentOperationCount = 1，只开启一个子线程
    5.3、设置 NSOperationQueue.maxConcurrentOperationCount = n(n > 1)，最多开启n条子线程。具体根据操作系统来分配
    5.3、NSOperationQueue.maxConcurrentOperationCount 默认值-1，意味着开几条子线程交给操作系统来分配
 6、操作，iOS SDK给了NSOperation、NSInvocationOperation、NSBlockOperation三种操作类
    NSOperation、NSInvocationOperation、操作可以直接调用-(void)start方法去执行任务，如果直接调用相当于在当前队列的当前线程执行
 7、每一个NSBlockOperation操作可以添加多个任务，如果添加了子块，会并发执行主块和子块
 
 
 一、进程:
 一个程序(app)的运行过程就是一个进程。iOS系统中一个app只能开启一个进程。
 当一个进程开启后，会开启一个主运行循环和一个主线程。主运行循环保证主线程不会被杀死，同时接收用户的交互事件。
 
 二、线程:
 app处理可以利用主线程干活，同时也可以开启多个子线程，子线程在后台干活。
 
 
 */

- (void)demo07
{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
       
        NSLog(@"1、%@",[NSOperationQueue currentQueue]);
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"a、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"2、%@",[NSOperationQueue currentQueue]);
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.1];
            
            NSLog(@"b、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"3、%@",[NSOperationQueue currentQueue]);
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.2];
            
            NSLog(@"c、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"4、%@",[NSOperationQueue currentQueue]);
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.3];
            
            NSLog(@"d、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    /*
     每个操作都会开启一个单独的线程，在每个操作内部都是顺序执行的
     */
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    /*
     maxConcurrentOperationCount = 1时，相当于串行队列
     maxConcurrentOperationCount > 1时，相当于并发队列
     */
    queue.maxConcurrentOperationCount = 1;
    
    NSLog(@"start、%@",[NSOperationQueue currentQueue]);
    
    [queue addOperations:@[op1, op2, op3, op4] waitUntilFinished:NO];
    
    NSLog(@"end、%@",[NSOperationQueue currentQueue]);
}

- (void)demo06
{
    /*
     会开启2条线程
     */
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.1];
            
            NSLog(@"a、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.2];
            
            NSLog(@"b、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.3];
            
            NSLog(@"c、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.1];
            
            NSLog(@"d、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:op];
}

- (void)demo05
{
    /*
     NSBlockOperation，此类型的操作可以创建只一个对象，在该操作对象上添加多个多个执行块。
     直接调用-(void)start方法，主块会在当前线程执行。追加的子执行块会开启一条线程，顺序执行
     */
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"1、%@",[NSOperationQueue currentQueue]);
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:1];
            
            NSLog(@"a、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        
        NSLog(@"2、%@",[NSOperationQueue currentQueue]);
        
        for (int i = 0; i < 3; i++)
        {
            [NSThread sleepForTimeInterval:0.2];
            
            NSLog(@"b、i = %d, %@",i, [NSThread currentThread]);
        }
    }];
    
//    [op addExecutionBlock:^{
//
//        for (int i = 0; i < 3; i++)
//        {
//            [NSThread sleepForTimeInterval:0.3];
//
//            NSLog(@"c、i = %d, %@",i, [NSThread currentThread]);
//        }
//    }];
//
//    [op addExecutionBlock:^{
//
//        for (int i = 0; i < 3; i++)
//        {
//            [NSThread sleepForTimeInterval:0.1];
//
//            NSLog(@"d、i = %d, %@",i, [NSThread currentThread]);
//        }
//    }];
    
    [op start];
}

- (void)demo04
{
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo04_NSInvocationOperation:) object:@"sen_01"];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo04_NSInvocationOperation:) object:@"sen_02"];
    
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo04_NSInvocationOperation:) object:@"sen_03"];
    
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo04_NSInvocationOperation:) object:@"sen_04"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    /*
     将操作添加到队列就会开启子线程。开启几条子线程是由maxConcurrentOperationCount的值和操作系统共同决定的
     */
    queue.maxConcurrentOperationCount = 1;
    
    [queue addOperations:@[op1,op2,op3,op4] waitUntilFinished:NO];
    
}

- (void)demo04_NSInvocationOperation:(id)param
{
    for (int i = 0; i < 5; i++)
    {
        [NSThread sleepForTimeInterval:0.2];
        
        NSLog(@"i = %d,%@, %@",i, param, [NSThread currentThread]);
    }
}

- (void)demo03
{
    /* 队列和操作的理解 */
    
    /*
     队列, NSOperationQueue
     1、队列可以理解成是工厂里的一条生产线
     2、分为主队列([NSOperationQueue mainQueue])和自定义队列([[NSOperationQueue alloc] init])
     3、主队列对应操作系统的主线程、自定义队列对应操作系统的子线程
     */
    
    /*
     操作, NSOperation、NSInvocationOperation、NSBlockOperation
     1、操作可以理解成生产线上的工人。
     2、操作有2种方式可以执行
        2.1、操作对象显示调用- (void)start方法，那么操作会执行
        2.2、将操作添加到一个队列中，操作会自动执行
     3、创建一个操作后如果不显式的添加到任何队列中，直接调用-(void)start方法，系统会隐式的将该操作添加到创建该操作的线程中执行
     
     */
    
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    queue = dispatch_queue_create("queue_id", DISPATCH_QUEUE_SERIAL);
    
//    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
    
}

- (void)demo02
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    self.queue = queue;
    
    for (int i = 0; i < 5; i++)
    {
        NSString *idx = [NSString stringWithFormat:@"%02d",i + 1];
        
        FSOperation *op = [[FSOperation alloc] initWithIdentifier:idx];
        
        [queue addOperation:op];
        
        [NSThread sleepForTimeInterval:0.5];
    }
    
    NSLog(@"end");
}

- (void)demo01
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    self.queue = queue;
    
    NSMutableArray *opArray = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++)
    {
        NSString *idx = [NSString stringWithFormat:@"%02d",i + 1];
        
        FSOperation *op = [[FSOperation alloc] initWithIdentifier:idx];
        
        [opArray addObject:op];
    }
    
    /*
     waitUntilFinished: NO不会阻塞主线程。YES会阻塞主线程，卡死UI
     */
    [queue addOperations:opArray waitUntilFinished:YES];
    
    NSLog(@"end");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"controller14_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"fs-%ld",indexPath.row + 1];
    
    return cell;
}

- (void)dealloc
{
    NSLog(@"FSController14 - dealloc");
}

@end
