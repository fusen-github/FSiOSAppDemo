//
//  FSCAController08.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/4.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController08.h"

@interface FSCAController08 ()

@property (nonatomic, strong) CALayer *redLayer;

@end

@implementation FSCAController08

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRedLayer];
}

- (void)setupRedLayer
{
    CALayer *redLayer = [CALayer layer];
    
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    
    redLayer.bounds = CGRectMake(0, 0, 200, 200);
    
    redLayer.position = self.view.center;
    
    self.redLayer = redLayer;
    
    [self.view.layer addSublayer:redLayer];
}

- (void)setupPathLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(100, 250)];
    
    [path addCurveToPoint:CGPointMake(400, 250)
            controlPoint1:CGPointMake(172, 100)
            controlPoint2:CGPointMake(325, 400)];
    
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    
    shapLayer.path = path.CGPath;
    
    shapLayer.lineWidth = 2;
    
    shapLayer.strokeColor = [UIColor redColor].CGColor;
    
    shapLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.view.layer addSublayer:shapLayer];
    
    CALayer *redLayer = [CALayer layer];
    
    self.redLayer = redLayer;
    
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    
    redLayer.bounds = CGRectMake(0, 0, 30, 30);
    
    redLayer.position = CGPointMake(100, 250);
    
    [self.view.layer addSublayer:redLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self demo04];
}

- (void)demo04
{
    static NSInteger index = 0;
    
    NSArray *array = @[[UIColor redColor], [UIColor greenColor],
                       [UIColor blueColor], [UIColor grayColor],];
    
    if (index >= array.count)
    {
        index = 0;
    }
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.5;
    
    animation.type = kCATransitionReveal;
    
    animation.subtype = kCATransitionFromLeft;
    
    UIColor *color = [array objectAtIndex:index];
    
    self.redLayer.backgroundColor = color.CGColor;
    
    [self.redLayer addAnimation:animation forKey:nil];
    
    index++;
}

/**
 动画组 CAAnimationGroup
 */
- (void)demo03
{
    CAShapeLayer *shapeLayer = (id)[self.view.layer.sublayers firstObject];
    
    if (shapeLayer == nil)
    {
        return;
    }
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animation];
    
    moveAnimation.keyPath = @"position";
    
    moveAnimation.path = shapeLayer.path;
    
    moveAnimation.duration = 5;
    
    moveAnimation.rotationMode = kCAAnimationRotateAuto;
    
    
    
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
    colorAnimation.toValue = (__bridge id)[UIColor blueColor].CGColor;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.animations = @[moveAnimation, colorAnimation];
    
    group.duration = 5;
    
    [self.redLayer addAnimation:group forKey:nil];
}

/**
 CAValueFunction的用法
 */
- (void)demo02
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 3;
    
    animation.fromValue = @(0);
    
    animation.toValue = @(2 * M_PI);
    
//    animation.repeatCount = CGFLOAT_MAX;
    
    CAValueFunction *valueFunc = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    
    animation.valueFunction = valueFunc;
    
    [self.redLayer addAnimation:animation forKey:nil];
}

/**
 关键帧动画: path
 */
- (void)demo01
{
    CAShapeLayer *shapeLayer = (id)[self.view.layer.sublayers firstObject];
    
    if (shapeLayer == nil)
    {
        return;
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    animation.path = shapeLayer.path;
    
    animation.duration = 5;
    
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    
    [self.redLayer addAnimation:animation forKey:nil];
}

@end
