//
//  FSCATextLayerVC.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/30.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCATextLayerVC.h"
#import <CoreText/CoreText.h>

@interface FSCATextLayerVC (Extention)

- (void)demo02;

- (void)demo03;

- (void)demo04;

@end

@interface FSCATextLayerVC ()

@end

@implementation FSCATextLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo04];
}

/**
 用CATextLayer模拟UILable来显示文本信息
 */
- (void)demo01
{
    CATextLayer *layer = [CATextLayer layer];
    
    layer.frame = CGRectMake(100, 100, 200, 100);
    
    layer.string = @"asdfasdcaksdcmalksdmclkasmdkcmaklsdmk";
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    
    CGFontRef cg_font = CGFontCreateWithFontName(fontName);
    
    layer.font = cg_font;
    
    CGFontRelease(cg_font);
    
    layer.fontSize = 14;
    
    layer.contentsScale = [UIScreen mainScreen].scale;
    
    /// 修改文本的字体颜色
    layer.foregroundColor = [UIColor blueColor].CGColor;
    
    /// 是否换行
//    layer.wrapped = YES;
    
    /// 当文本内容过长时的截断模式
    layer.truncationMode = kCATruncationEnd;
    
    /// 对齐方式
    layer.alignmentMode = kCAAlignmentNatural;
    
    [self.view.layer addSublayer:layer];
}

@end

@implementation FSCATextLayerVC (CAGradientLayer)

/**
 CAGradientLayer
 */
- (void)demo02
{
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    
    layer.frame = CGRectMake(100, 100, 200, 50);
    
    id red = (__bridge id)([UIColor redColor].CGColor);

    id green = (__bridge id)[UIColor greenColor].CGColor;

    id blue = (__bridge id)[UIColor blueColor].CGColor;
    
    layer.colors = @[red, green, blue];
    
    /// 定义每一个渐变色停止的位置
    layer.locations = @[@(0.25), @(0.65), @(1.0)];
    
    ///
    layer.startPoint = CGPointMake(0, 0);
    
    layer.endPoint = CGPointMake(1, 0.5);
    
    [self.view.layer addSublayer:layer];
}

@end

@implementation FSCATextLayerVC (xx)

/**
 CAReplicatorLayer
 */
- (void)demo03
{
    UIView *containerView = [[UIView alloc] init];
    
    containerView.frame = self.view.bounds;
    
    [self.view addSubview:containerView];
    
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    
    layer.frame = containerView.bounds;
    
    layer.instanceCount = 10;
    
    CATransform3D transform3D = CATransform3DIdentity;
    
    transform3D = CATransform3DTranslate(transform3D, 0, 100, 0);
    
    transform3D = CATransform3DRotate(transform3D, M_PI / 3, 0, 0, 1);
    
    transform3D = CATransform3DTranslate(transform3D, 0, -100, 0);
    
    /// 第k个实例相对于第k-1个实例的转换
    layer.instanceTransform = transform3D;
    
//    layer.instanceDelay = 2;
    
    CALayer *subLayer = [CALayer layer];
    
    subLayer.frame = CGRectMake(100, 100, 100, 100);
    
    subLayer.backgroundColor = [UIColor redColor].CGColor;
    
    [layer addSublayer:subLayer];
    
    [containerView.layer addSublayer:layer];
}

- (void)demo04
{
    UIView *view = [UIView new];
    
    view.frame = CGRectMake(0, 0, 250, 250);
    
    view.center = self.view.center;
    
    [self.view addSubview:view];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.backgroundColor = [UIColor redColor].CGColor;
    
    shapeLayer.bounds = CGRectMake(0, 0, 20, 20);
    
    shapeLayer.position = CGPointMake(view.width * 0.5, view.height * 0.5);
    
    shapeLayer.cornerRadius = 10;
    
    
    
    CATransform3D transform3D = CATransform3DMakeScale(10, 10, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue = [NSValue valueWithCATransform3D:transform3D];
    
    animation.duration = 2;
    
    animation.repeatCount = NSIntegerMax;
    
    [shapeLayer addAnimation:animation forKey:nil];
    
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    
    [replicatorLayer addSublayer:shapeLayer];
    
    replicatorLayer.instanceCount = 3;
    
    replicatorLayer.instanceDelay = .5;
    
    replicatorLayer.instanceAlphaOffset = -0.1;
    
    replicatorLayer.instanceRedOffset = -0.1;
    
    [view.layer addSublayer:replicatorLayer];
    
}

@end
