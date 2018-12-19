//
//  FSCAController12.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/7.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController12.h"

@interface FSCAController12 ()

@property (nonatomic, weak) CALayer *redLayer;

@end

@implementation FSCAController12

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    layer.bounds = CGRectMake(0, 0, 200, 200);
    
    layer.position = self.view.center;
    
    self.redLayer = layer;
    
    [self.view.layer addSublayer:layer];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self demo02];
}

- (void)demo02
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    
    animation.duration = 10.0;
    
    id blue = (__bridge id)[UIColor blueColor].CGColor;
    
    id red = (__bridge id)[UIColor redColor].CGColor;
    
    id green = (__bridge id)[UIColor greenColor].CGColor;
    
    animation.values = @[blue, red, green, blue];
    
    CAMediaTimingFunction *timingFunc = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    animation.timingFunctions = @[timingFunc, timingFunc, timingFunc];
    
    [self.redLayer addAnimation:animation forKey:nil];
}

- (void)demo01
{
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:2];
    
    CAMediaTimingFunction *timingFunc = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    [CATransaction setAnimationTimingFunction:timingFunc];
    
    CGPoint toPoint = CGPointMake(150, self.view.height - 150);
    
    self.redLayer.position = toPoint;
    
    [CATransaction commit];
    
}

@end
