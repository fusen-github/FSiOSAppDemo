//
//  FSController01.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController01.h"

@interface FSController01 ()

@end

@implementation FSController01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)testNSBlockOperation
{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        
        srandom((int)time(NULL));
        
        for (int i = 0; i < 10; i++)
        {
            double x = (double)(random() & 0x3);
            
            [NSThread sleepForTimeInterval:x];
            
            NSLog(@"a:%@ - %d",[NSThread currentThread],i);
        }
    }];
    
    [op setCompletionBlock:^{
        
        NSLog(@"操作执行完了%@",[NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        
        srandom((int)time(NULL));
        
        for (int i = 0; i < 10; i++)
        {
            double x = (double)(random() & 0x3);
            
            [NSThread sleepForTimeInterval:x];
            
            NSLog(@"b:%@ - %d",[NSThread currentThread],i);
        }
    }];
    
    [op addExecutionBlock:^{
        
        srandom((int)time(NULL));
        
        for (int i = 0; i < 10; i++)
        {
            double x = (double)(random() & 0x3);
            
            [NSThread sleepForTimeInterval:x];
            
            NSLog(@"c:%@ - %d",[NSThread currentThread],i);
        }
    }];
    
    [op addExecutionBlock:^{
        
        srandom((int)time(NULL));
        
        for (int i = 0; i < 10; i++)
        {
            double x = (double)(random() & 0x3);
            
            [NSThread sleepForTimeInterval:x];
            
            NSLog(@"d:%@ - %d",[NSThread currentThread],i);
        }
    }];
    
    [op start];
    
    NSLog(@"laile,%@",[NSThread currentThread]);
}


- (void)testNSInvocationOperation
{
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationFunc:) object:@"付森"];
    
    [op start];
    
    id rst = op.result;
    
    NSLog(@"%@",rst);
}

- (id)operationFunc:(id)object
{
    NSLog(@"object = %@",object);
    
    if ([NSThread isMainThread])
    {
        NSLog(@"是主线程");
    }
    else
    {
        NSLog(@"不是");
    }
    
    return @"调用了operationFunc";
}

- (void)testNSBlockOperation02
{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 10; i++)
        {
            double time = (double)arc4random_uniform(30) / 10.0;
            
            [NSThread sleepForTimeInterval:time];
            
            NSLog(@"op1:%@ - %d",[NSThread currentThread], i);
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 10; i++)
        {
            double time = (double)arc4random_uniform(30) / 10.0;
            
            [NSThread sleepForTimeInterval:time];
            
            NSLog(@"op2:%@ - %d",[NSThread currentThread], i);
        }
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 10; i++)
        {
            double time = (double)arc4random_uniform(30) / 10.0;
            
            [NSThread sleepForTimeInterval:time];
            
            NSLog(@"op3:%@ - %d",[NSThread currentThread], i);
        }
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 10; i++)
        {
            double time = (double)arc4random_uniform(30) / 10.0;
            
            [NSThread sleepForTimeInterval:time];
            
            NSLog(@"op4:%@ - %d",[NSThread currentThread], i);
        }
    }];
    
    //    [op4 addDependency:op3];
    //
    //    [op3 addDependency:op2];
    //
    //    [op2 addDependency:op1];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:op1];
    
    [queue addOperation:op2];
    
    [queue addOperation:op3];
    
    [queue addOperation:op4];
    
    //    [queue addOperationWithBlock:^{
    //
    //        for (int i = 0; i < 10; i++)
    //        {
    //            double time = (double)arc4random_uniform(30) / 10.0;
    //
    //            [NSThread sleepForTimeInterval:time];
    //
    //            NSLog(@"op5:%@ - %d",[NSThread currentThread], i);
    //        }
    //    }];
    
    [queue setMaxConcurrentOperationCount:1];
    
    [queue waitUntilAllOperationsAreFinished];
    
    //    op4.queuePriority
    
    NSLog(@"liaile,%@",[NSThread currentThread]);
    
}

@end
