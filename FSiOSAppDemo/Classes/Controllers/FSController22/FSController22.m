//
//  FSController22.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/11.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController22.h"
#import "FSViscosityView.h"


@interface FSController22 ()

@property (nonatomic, weak) UIView *redView;

@property (nonatomic, strong) NSArray <UIView *> *array;

@end

@implementation FSController22

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo05];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSLog(@"redView.frame = %@", NSStringFromCGRect(self.redView.frame));
    
    for (UIView *view in self.view.subviews)
    {
        NSLog(@"view.frame = %@",NSStringFromCGRect(view.frame));
    }
}

- (void)demo05
{
    FSViscosityView *viscosityView = [[FSViscosityView alloc] initWithTitle:@"6"];
    
    viscosityView.center = self.view.center;
    
    [self.view addSubview:viscosityView];
}

/**
 多个view同时布局
 */
- (void)demo04
{
    NSMutableArray<__kindof UIView *> *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++)
    {
        UIView *view = [[UIView alloc] init];
        
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        view.backgroundColor = UIColorRandom;
        
        [self.view addSubview:view];
        
        [tmpArray addObject:view];
    }
    
//    CGFloat width = self.view.width -
    
    [tmpArray[0].topAnchor constraintEqualToAnchor:self.view.topAnchor constant:80].active = YES;
    
    [tmpArray[0].leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    
//    [tmpArray[0].widthAnchor constraintEqualToConstant:<#(CGFloat)#>];
    
    [tmpArray[0].heightAnchor constraintEqualToConstant:100].active = YES;
    
    
    [tmpArray[1].topAnchor constraintEqualToAnchor:tmpArray[0].topAnchor].active = YES;
    
    [tmpArray[1].leadingAnchor constraintEqualToAnchor:tmpArray[0].trailingAnchor constant:20].active = YES;
    
    [tmpArray[1].heightAnchor constraintEqualToConstant:100].active = YES;
    
//    [tmpArray[0].widthAnchor constraintEqualToConstant:100].active = YES;
    
//    NSLog(@"%@", NSStringFromCGRect(tmpArray[0].frame));
    
}

- (void)demo03
{
    UIView *redView = [[UIView alloc] init];
    
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.redView = redView;
    
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
    UIView *greenView = [[UIView alloc] init];
    
    greenView.translatesAutoresizingMaskIntoConstraints = NO;
    
    greenView.backgroundColor = [UIColor greenColor];
    
//    [self.view addSubview:greenView];
    
    /*
     leadingAnchor 前边沿(左边沿)
     trailingAnchor 后边沿(右边沿)
     */
    
    
    
    [redView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:50].active = YES;
    
    [redView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:64].active = YES;
    
    [redView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.5];
    
//    [redView.widthAnchor constraintLessThanOrEqualToAnchor:self.view.widthAnchor multiplier:0.5];
    
//    [redView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-50].active = YES;
    
    [redView.heightAnchor constraintEqualToConstant:300].active = YES;
    
    
//    [greenView.leadingAnchor constraintEqualToAnchor:redView.trailingAnchor constant:50].active = YES;
//
//    [greenView.topAnchor constraintEqualToAnchor:redView.topAnchor constant:0].active = YES;
    
    
    
    
}

/**
 布局
 */
- (void)demo02
{
    UIView *view1 = [[UIView alloc] init];
    
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    
    view1.backgroundColor = UIColorRandom;
    
//    NSLayoutConstraint *left = [view1.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
//
//    NSLayoutConstraint *top = [view1.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100];
    
    NSLayoutConstraint *centerX = [view1.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0];
    
    NSLayoutConstraint *centerY = [view1.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:0];
    
//    NSLayoutConstraint *xx = [view1.leadingAnchor ]
    
    NSLayoutConstraint *width = [view1.widthAnchor constraintEqualToConstant:200];
    
    NSLayoutConstraint *height = [view1.heightAnchor constraintEqualToConstant:500];
    
//    [NSLayoutConstraint activateConstraints:@[left, top, width, height]];
    
    [NSLayoutConstraint activateConstraints:@[width, height]];
    
    [self.view addSubview:view1];
}

- (void)demo01
{
    FSViscosityView *viscosity = [[FSViscosityView alloc] init];
    
    //    viscosity.frame = CGRectMake(100, 100, 20, 20);
    
    viscosity.center = self.view.center;
    
    [self.view addSubview:viscosity];
}



@end
