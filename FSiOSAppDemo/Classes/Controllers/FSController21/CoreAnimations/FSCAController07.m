//
//  FSCAController07.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController07.h"

@interface FSCAController07 ()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *redLayer;

@end

@implementation FSCAController07

/*
 CAAnimation : NSObject 一个抽象基类，定义了动画的一些通用属性和方法
 CAPropertyAnimation : CAAnimation 属性动画，一个抽象子类。作用于图层的某一特定属性
 CABasicAnimation : CAPropertyAnimation 具体子类  通过一个keyPath对一个单一属性动画
 CAKeyframeAnimation : CAPropertyAnimation 具体子类
 CASpringAnimation : CABasicAnimation
 CATransition : CAAnimation
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *redLayer = [CALayer layer];
    
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    
    self.redLayer = redLayer;
    
    redLayer.frame = CGRectMake(0, 0, 300, 300);
    
    redLayer.position = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    
    [self.view.layer addSublayer:redLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self demo09];
}

/**
 关键帧动画: path
 */
- (void)demo10
{
   
}

/**
 关键帧动画:values
 */
- (void)demo09
{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    
    keyFrameAnimation.duration = 10;
    
    id red = (__bridge id)[UIColor redColor].CGColor;
    
    id green = (__bridge id)[UIColor greenColor].CGColor;
    
    id blue = (__bridge id)[UIColor blueColor].CGColor;
    
    id gray = (__bridge id)[UIColor grayColor].CGColor;
    
    NSArray *values = @[red, green, blue, gray];
    
    keyFrameAnimation.values = values;
    
    [self.redLayer addAnimation:keyFrameAnimation forKey:nil];
}

- (void)demo08
{
    NSLog(@"%@", NSStringFromCGAffineTransform([self.redLayer affineTransform]));
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    /// CAValueFunction类是专门为transform属性设计的辅助类
    CAValueFunction *valueFunc = [CAValueFunction functionWithName:kCAValueFunctionTranslateY];
    
    animation.valueFunction = valueFunc;
    
    animation.byValue = @(100);
    
    animation.duration = 1.5;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.delegate = self;
    
    [self.redLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%@", NSStringFromCGAffineTransform([self.redLayer affineTransform]));
}

- (void)demo07
{
    /* 修改CALayer的某个属性(affineTransform)值会立即生效 */
    NSLog(@"%@",NSStringFromCGAffineTransform(self.redLayer.affineTransform));
    
    self.redLayer.affineTransform = CGAffineTransformMakeTranslation(0, 100);
    
    NSLog(@"%@",NSStringFromCGAffineTransform(self.redLayer.affineTransform));
}

- (void)demo06
{
    CGPoint center = self.redLayer.position;

    NSLog(@"%@", NSStringFromCGPoint(self.redLayer.position));

    CABasicAnimation *animation = [CABasicAnimation animation];

    center.y += 50;
    
    animation.toValue = [NSValue valueWithCGPoint:center];
    
    animation.duration = 0.5;
    
    [self.redLayer addAnimation:animation forKey:nil];
    
    NSLog(@"%@", NSStringFromCGPoint(self.redLayer.position));
}

- (void)demo05
{
    /* 修改translation并没有影响到position和anchorPoint，
     Frame是translation和position、bounds共同作用的结果 */
    
    NSLog(@"%@", NSStringFromCGPoint(self.redLayer.position));
    
    NSLog(@"anchorPoint: %@", NSStringFromCGPoint(self.redLayer.anchorPoint));
    
    self.redLayer.affineTransform = CGAffineTransformMakeTranslation(0, 100);
    
    NSLog(@"%@", NSStringFromCGPoint(self.redLayer.position));
    
    NSLog(@"anchorPoint: %@", NSStringFromCGPoint(self.redLayer.anchorPoint));
}

- (void)demo04
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.toValue = @(2 * M_PI);

//    animation.keyPath = @"transform.rotation.z";
    
    CAValueFunction *valueFunc = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];

    animation.valueFunction = valueFunc;
    
    animation.repeatCount = CGFLOAT_MAX;
    
    animation.duration = 2.5;
    
//    animation.fillMode = kCAFillModeRemoved;
    
    [self.redLayer addAnimation:animation forKey:nil];
}

- (void)demo03
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
    
    animation.duration = .5;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    [self.redLayer addAnimation:animation forKey:nil];
}

- (void)demo02
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath = @"bounds.size";
    
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
    
    animation.delegate = self;
    
    [self.redLayer addAnimation:animation forKey:nil];
}

- (void)_animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%s",__func__);
    
    if (flag)
    {
        if ([anim isKindOfClass:[CABasicAnimation class]])
        {
            [CATransaction begin];
            
            /// 禁用隐式动画
            [CATransaction setDisableActions:YES];
            
            CABasicAnimation *basic = (id)anim;
            
            [self.redLayer setValue:basic.toValue forKeyPath:basic.keyPath];
            
            [CATransaction commit];
        }
    }
}

- (void)demo01
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
 
//    basicAnimation.fromValue =
    
    basicAnimation.keyPath = @"backgroundColor";
    
    basicAnimation.toValue = (__bridge id)(UIColorRandom.CGColor);
    
    CALayer *tmpLayer = self.redLayer.presentationLayer ?: self.redLayer;

    basicAnimation.fromValue = [tmpLayer valueForKeyPath:basicAnimation.keyPath];
    
    basicAnimation.duration = .25;
    
    [self.redLayer setValue:basicAnimation.toValue forKeyPath:basicAnimation.keyPath];
    
    [self.redLayer addAnimation:basicAnimation forKey:nil];
}


@end
