//
//  FSOperation.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSOperation.h"

@interface FSOperation ()

@property (nonatomic, strong) NSString *identifier;

@end

@implementation FSOperation

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    if (self = [super init])
    {
        self.identifier = identifier;
    }
    return self;
}

- (void)main
{
    NSLog(@"begin_op, id = %@",self.identifier);
    
    NSLog(@"%@",[NSThread currentThread]);
    
    unsigned long long value = 1000000000000;
    
    unsigned long long sum = 0;
    
    for (int i = 0; i < value; i++)
    {
        sum += i;
    }
    
    NSLog(@"sum = %llu",sum);
    
    NSLog(@"end_op, id = %@",self.identifier);
}

@end
