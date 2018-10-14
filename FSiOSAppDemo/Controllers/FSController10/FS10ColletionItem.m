//
//  FS10ColletionItem.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FS10ColletionItem.h"

@interface FS10ColletionItem ()

@property (nonatomic, copy) NSString *title;

@end

@implementation FS10ColletionItem

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init])
    {
        self.title = title;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    NSLog(@"%@",_title);
}

@end
