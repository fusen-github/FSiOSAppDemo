//
//  FSController02.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController02.h"
#import "FSView.h"


@interface FSController02 ()

@end

@implementation FSController02

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor redColor];
    
    button.frame = CGRectMake(100, 100, 80, 30);
    
    //    [button addTarget:self
    //               action:@selector(touchUpInside_2:)
    //     forControlEvents:UIControlEventTouchUpInside];
    //
    [button addTarget:self action:@selector(touchUpInside_1:) forControlEvents:UIControlEventTouchUpInside];
    
    //    [button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    
    //    [button addTarget:self action:@selector(touchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
    
    //    [button addTarget:self action:@selector(doSomething) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    FSView *fs_view = [[FSView alloc] init];
    
    fs_view.tag = 100;
    
    fs_view.frame = CGRectMake(100, 200, 80, 80);
    
    fs_view.backgroundColor = [UIColor blueColor];
    
    fs_view.autoresizesSubviews = NO;
    
    [self.view addSubview:fs_view];
    
}


- (void)doSomething
{
    UIView *fsView = [self.view viewWithTag:100];
    
    //    {
    //        CGFloat y = fsView.frame.origin.y;
    //
    //        y = y + 10;
    //
    //        fsView.frame = CGRectMake(100, y, 80, 80);
    //    }
    
    //    {
    //        CGAffineTransform transform = fsView.transform;
    //
    //        fsView.transform = CGAffineTransformTranslate(transform, 0, 10);
    //    }
    
    //    {
    //        CGFloat width = fsView.frame.size.width;
    //
    //        width += 10;
    //
    //        fsView.frame = CGRectMake(100, 300, width, 80);
    //    }
    
    //    {
    //        CGFloat x = fsView.frame.origin.x;
    //
    //        x += 10;
    //
    //        fsView.frame = CGRectMake(x, 300, 100, 100);
    //    }
    
    {
        CGFloat x = fsView.bounds.origin.x;
        
        x += 5;
        
        NSLog(@"x = %f",x);
        
        fsView.bounds = CGRectMake(x, 0, 100, 100);
    }
    
}

- (void)touchUpInside_1:(UIButton *)button
{
    NSLog(@"%s",__func__);
}

- (void)touchUpInside_2:(UIButton *)button
{
    NSLog(@"%s",__func__);
}

- (void)touchDown:(UIButton *)button
{
    NSLog(@"%s",__func__);
}

- (void)touchDownRepeat:(UIButton *)button
{
    NSLog(@"%s",__func__);
}

@end
