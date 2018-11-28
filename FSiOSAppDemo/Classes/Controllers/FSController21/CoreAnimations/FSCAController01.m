//
//  FSCAController01.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController01.h"

@interface FSCAController01 ()

@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, weak) CALayer *redLayer;

@end

@implementation FSCAController01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *contentView = [[UIView alloc] init];
    
    contentView.backgroundColor = [UIColor orangeColor];
    
    self.contentView = contentView;
    
    [self.view addSubview:contentView];
    
    CALayer *redLayer = [CALayer layer];
    
    self.redLayer = redLayer;
    
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    
//    [contentView.layer addSublayer:redLayer];
    
    CGFloat width = 300;
    
    CGFloat height = 300;
    
    CGFloat x = (self.view.bounds.size.width - width) * 0.5;
    
    CGFloat y = (self.view.bounds.size.height - height) * 0.5;
    
    self.contentView.frame = CGRectMake(x, y, width, height);
    
    self.redLayer.frame = CGRectInset(self.contentView.bounds, 100, 100);
    
//    [self demo01];
}

/**
 draw test
 */
- (void)demo02
{
    self.redLayer.delegate = (id<CALayerDelegate>)self;
    
    [self.redLayer setNeedsDisplay];
}

#pragma mark CALayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 1);
    
    CGContextMoveToPoint(ctx, 0, 0);
    
    CGContextAddLineToPoint(ctx, layer.bounds.size.width, layer.bounds.size.height);
    
    CGContextStrokePath(ctx);
}

/**
 寄宿图
 */
- (void)demo01
{
    UIImage *image = [UIImage imageNamed:@"pan"];
    
    [image setValue:@(1) forKey:@"scale"];
    
    self.redLayer.contents = (__bridge id _Nullable)(image.CGImage);
    
    self.redLayer.contentsScale = image.scale;
    
    self.redLayer.masksToBounds = YES;
    
    self.redLayer.contentsGravity = @"resizeAspectFill";
}

@end
