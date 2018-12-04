//
//  FSShapLayerVC.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/30.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSShapLayerVC.h"

@interface FSShapLayerVC ()

@property (nonatomic, weak) UIView *redView;

@end

@implementation FSShapLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo03];
}



/**
 CAShapeLayer + UIBezierPath绘制部分圆角
 */
- (void)demo03
{
    UIView *view = [[UIView alloc] init];
    
    view.frame = CGRectMake(50, 100, 200, 200);
    
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
    
    // 给layer的部分角落设置圆角效果
    UIRectCorner rectCorner = UIRectCornerTopLeft;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(20, 20)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    view.layer.mask = shapeLayer;
}

/**
 用maskedCorners(iOS 11生效)属性自定义图层的部分圆角
 */
- (void)demo02
{    
    UIView *view = [[UIView alloc] init];
    
    view.frame = CGRectMake(50, 100, 200, 200);
    
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
    
    // 给layer的部分角落设置圆角效果
    view.layer.cornerRadius = 20;
    
    view.layer.masksToBounds = YES;
    
    if (@available(iOS 11.0, *))
    {
        view.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    }
    
}

- (void)demo01
{
    /*
     Description:
     CAShapeLayer 是一个特殊的图层，可以在设置‘path’属性后，不设置frame就能直接渲染
     
     */
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:CGPointMake(10, 100)];
    
    [path1 addLineToPoint:CGPointMake(300, 100)];
    
    path1.lineWidth = 20;
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    
    [path2 moveToPoint:CGPointMake(10, 200)];
    
    [path2 addLineToPoint:CGPointMake(300, 200)];
    
    path2.lineWidth = 10;
    
    [path2 appendPath:path1];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path2.CGPath;
    
    layer.strokeColor = [UIColor redColor].CGColor;
    
    layer.lineWidth = 5;
    
    layer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:layer];
}

@end
