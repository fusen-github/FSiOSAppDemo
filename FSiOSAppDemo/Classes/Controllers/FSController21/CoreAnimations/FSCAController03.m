//
//  FSCAController03.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController03.h"

@interface FSCAController03 ()

@property (nonatomic, weak) UIView *redView;

@property (nonatomic, weak) UIView *blueView;

@end

@implementation FSCAController03

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupSubviews03];
    
}



- (void)setupSubviews01
{
    UIView *redView = [[UIView alloc] init];
    
    self.redView = redView;
    
    redView.backgroundColor = [UIColor redColor];
    
    CGFloat width = 200;
    
    CGFloat height = 200;
    
    CGFloat x = (self.view.bounds.size.width - width) * 0.5;
    
    CGFloat y = (self.view.bounds.size.height - height) * 0.5;
    
    redView.frame = CGRectMake(x, y, width, height);
    
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    
    self.blueView = blueView;
    
    blueView.backgroundColor = [UIColor blueColor];
    
    blueView.frame = CGRectOffset(redView.bounds, 50, 50);
    
    [redView addSubview:blueView];
}

- (void)setupSubviews02
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    CGFloat width = 250;
    
    CGFloat height = 250;
    
    CGFloat x = (self.view.bounds.size.width - width) * 0.5;
    
    CGFloat y = (self.view.bounds.size.height - height) * 0.5;
    
    imageView.frame = CGRectMake(x, y, width, height);
    
    UIImage *image = [UIImage imageNamed:@"005.jpg"];
    
    imageView.image = image;
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:imageView];
    
    CALayer *maskLayer = [CALayer layer];
    
    maskLayer.frame = imageView.bounds;
    
    UIImage *contents = [UIImage imageNamed:@"xx"];
    
    maskLayer.contents = (__bridge id _Nullable)(contents.CGImage);
    
//    NSLog(@"opacity = %f", maskLayer.opacity);
    
    maskLayer.opacity = 0.5;
    
    imageView.layer.mask = maskLayer;
}

- (void)setupSubviews03
{
    UIView *view1 = [[UIView alloc] init];
    
    view1.frame = CGRectMake(0, 0, 200, 200);
    
    view1.center = self.view.center;
    
//    view1.backgroundColor = [UIColor redColor];
    
    view1.layer.shadowColor = [UIColor blackColor].CGColor;
    
    view1.layer.shadowRadius = 3;
    
    view1.layer.shadowOpacity = 0.75;
    
    view1.layer.shadowOffset = CGSizeMake(5, 5);
    
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    
    view2.layer.cornerRadius = 30;
    
    view2.layer.masksToBounds = YES;
    
    view2.layer.borderColor = [UIColor orangeColor].CGColor;
    
    view2.layer.borderWidth = 5;
    
    view2.backgroundColor = [UIColor greenColor];
    
    view2.frame = view1.bounds;
    
    [view1 addSubview:view2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self demo07];
}

- (void)demo07
{
    
}

/**
 layer.mask遮罩效果
 */
- (void)demo06
{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    CGFloat width = 250;
    
    CGFloat height = 250;
    
    CGFloat x = (self.view.bounds.size.width - width) * 0.5;
    
    CGFloat y = (self.view.bounds.size.height - height) * 0.5;
    
    imageView.frame = CGRectMake(x, y, width, height);
    
    UIImage *image = [UIImage imageNamed:@"005.jpg"];
    
//    image = [UIImage imageNamed:@"pan"];
    
    imageView.image = image;

    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:imageView];
    
//    {
//        CALayer *maskLayer = [CALayer layer];
//
//        maskLayer.frame = CGRectInset(imageView.bounds, 80, 80);
//
//        image = [UIImage imageNamed:@"pan"];
//
//        maskLayer.contents = (__bridge id _Nullable)(image.CGImage);
//
//        maskLayer.contentsGravity = kCAGravityResizeAspect;
//
//        maskLayer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0].CGColor;
//
//        imageView.layer.mask = maskLayer;
//    }
    
    {
        CALayer *maskLayer = [CALayer layer];
        
        maskLayer.frame = CGRectInset(imageView.bounds, 50, 50);
        
        UIImage *contents = [UIImage imageNamed:@"xx"];
        
        maskLayer.contents = (__bridge id _Nullable)(contents.CGImage);
        
        imageView.layer.mask = maskLayer;
        
        [imageView.layer addSublayer:maskLayer];
    }
    
}

/**
 用CGPath实现阴影效果
 */
- (void)demo05
{
    self.redView.layer.shadowOpacity = 0.8;
    
    self.redView.layer.shadowOffset = CGSizeMake(0, 5);
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect rect = CGRectMake(0, 0, self.redView.bounds.size.width * 2, self.redView.bounds.size.height * 2);
    
    rect = self.redView.bounds;
    
    CGPathAddRect(pathRef, NULL, rect);
    
    self.redView.layer.shadowPath = pathRef;
    
    CGPathRelease(pathRef);
}

/**
 masksToBounds保留阴影
 */
- (void)demo04
{
    UIView *view = [[UIView alloc] init];
    
    view.frame = self.redView.frame;
    
    view.frame = CGRectOffset(view.frame, 0, 0);
    
    view.backgroundColor = self.redView.backgroundColor;
    
    [self.redView.superview insertSubview:view belowSubview:self.redView];
    
    view.layer.shadowOpacity = 0.8;
    
    view.layer.shadowRadius = 4;
    
    view.layer.shadowOffset = CGSizeMake(0, 5);
    
    view.layer.cornerRadius = 10;
    
    self.redView.layer.cornerRadius = 10;
    
    self.redView.layer.masksToBounds = YES;
    /*
     借助辅助图层，实现图层的裁剪和带阴影效果
     */
}

/**
 masksToBounds裁剪阴影
 */
- (void)demo03
{
    self.redView.layer.shadowOpacity = 0.8;
    
    self.redView.layer.shadowOffset = CGSizeMake(0, 5);
    
    self.redView.layer.shadowRadius = 4;
    
    self.redView.layer.cornerRadius = 10;
    
    /// 直接设置这个 masksToBounds = YES，会导致图层的阴影也被裁剪掉。
    self.redView.layer.masksToBounds = YES;
}

/**
 阴影
 */
- (void)demo02
{
    self.redView.layer.shadowOpacity = 0.8;
    
    self.redView.layer.shadowColor = [UIColor greenColor].CGColor;
    
//    self.redView.layer.shadowRadius = 10;
    
    self.redView.layer.shadowOffset = CGSizeMake(0, 5);
}

/**
 设置圆角
 */
- (void)demo01
{
    self.redView.layer.cornerRadius = 10;
    
    self.redView.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.redView.layer.borderWidth = 5;
    
    /// 如果不设置裁剪超出的区域，超出部分也是可以正常显示的，只是不能响应交互事件
//    self.redView.layer.masksToBounds = YES;
}

@end
