//
//  FSCAController04.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController04.h"
#import "FSCAView02.h"
#import <GLKit/GLKit.h>


@interface FSCAController04 ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIView *container;

@end

CGAffineTransform CGAffineTransformMakeShare(CGFloat x, CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform.c = -x;
    
    transform.b = y;
    
    return transform;
}

/*
 //    CGAffineTransformMake(0, 0, 0, 0, 0, 0);
 
 //    CGAffineTransformMake(<#CGFloat a#>, <#CGFloat b#>, <#CGFloat c#>, <#CGFloat d#>, <#CGFloat tx#>, <#CGFloat ty#>)
 
 //    CGAffineTransformMakeScale(<#CGFloat sx#>, <#CGFloat sy#>)
 
 //    CGAffineTransformMakeRotation(<#CGFloat angle#>)
 */

/*
 CG前缀代表Core Graphics
 CG框架定义就是处理2D绘图的API，严格来说只对2D变换有效
 CGAffineTransform只处理图层在2D空间的变化
 但是layer.zPosition属性，可以控制视图对用户视角的距离
 CATransform3D可以让图层在3D空间做变换
 */

@implementation FSCAController04

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews02];
    
}

/**
 制作方块
 */
- (void)setupSubviews02
{
    UIView *container = [[UIView alloc] init];
    
    self.container = container;
    
    container.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    container.backgroundColor = [UIColor blackColor];
    
    container.frame = self.view.bounds;
    
    [self.view addSubview:container];
    
    CATransform3D containerTransform = CATransform3DIdentity;
    
    containerTransform.m34 = -1 / 500;
    
    container.layer.sublayerTransform = containerTransform;
    
    CGFloat wh = 150;
    
    CGFloat x = (container.width - wh) * 0.5;
    
    CGFloat y = (container.height - wh) * 0.5;
    
    for (int i = 0; i < 6; i++)
    {
        FSCAView02 *numView = [[FSCAView02 alloc] init];
        
        numView.frame = CGRectMake(x, y, wh, wh);
        
//        numView.backgroundColor = UIColorRandom;
        
        numView.backgroundColor = [UIColor whiteColor];
        
        [numView setTitle:@(i + 1).stringValue color:UIColorRandom];
        
        [container addSubview:numView];
    }
    
    CATransform3D faceTransform3D = CATransform3DIdentity;
    
    wh = wh * 0.5;
    
    /// index 0
    faceTransform3D = CATransform3DMakeTranslation(0, 0, wh);
    container.subviews[0].layer.transform = faceTransform3D;
    [self applyLightingToFace:container.subviews[0]];
    
    /// index 1
    faceTransform3D = CATransform3DMakeTranslation(wh, 0, 0);
    faceTransform3D = CATransform3DRotate(faceTransform3D, M_PI_2, 0, 1, 0);
    container.subviews[1].layer.transform = faceTransform3D;
    [self applyLightingToFace:container.subviews[1]];
    
    /// index 2
    faceTransform3D = CATransform3DMakeTranslation(0, -wh, 0);
    faceTransform3D = CATransform3DRotate(faceTransform3D, M_PI_2, 1, 0, 0);
    container.subviews[2].layer.transform = faceTransform3D;
    [self applyLightingToFace:container.subviews[2]];
    
    /// index 3
    faceTransform3D = CATransform3DMakeTranslation(-wh, 0, 0);
    faceTransform3D = CATransform3DRotate(faceTransform3D, -M_PI_2, 0, 1, 0);
    container.subviews[3].layer.transform = faceTransform3D;
    [self applyLightingToFace:container.subviews[3]];
    
    /// index 4
    faceTransform3D = CATransform3DMakeTranslation(0, wh, 0);
    faceTransform3D = CATransform3DRotate(faceTransform3D, -M_PI_2, 1, 0, 0);
    container.subviews[4].layer.transform = faceTransform3D;
    [self applyLightingToFace:container.subviews[4]];
    
    /// index 5
    faceTransform3D = CATransform3DMakeTranslation(0, 0, -wh);
    faceTransform3D = CATransform3DRotate(faceTransform3D, M_PI, 1, 0, 0);
    container.subviews[5].layer.transform = faceTransform3D;
    [self applyLightingToFace:container.subviews[5]];
}

- (void)applyLightingToFace:(UIView *)face
{
    CALayer *layer = [CALayer layer];
    
    layer.frame = face.bounds;
    
    [face.layer addSublayer:layer];
    
    CATransform3D transform = face.layer.transform;
    
    GLKMatrix4 m4 = *(GLKMatrix4 *)&transform;
    
    GLKMatrix3 m3 = GLKMatrix4GetMatrix3(m4);
    
    
    GLKVector3 v3 = GLKVector3Make(0, 0, 1);
    
    v3 = GLKMatrix3MultiplyVector3(m3, v3);
    
    v3 = GLKVector3Normalize(v3);
    
    
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(0, 1, -0.5));
    
    float dotProduct = GLKVector3DotProduct(light, v3);
    
    
    CGFloat shadow = 1 + dotProduct - 0.5;
    
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    
    layer.backgroundColor = color.CGColor;
}

- (void)setupSubviews01
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    self.imageView = imageView;
    
    CGFloat wh = 300;
    
    CGFloat x = (self.view.bounds.size.width - wh) * 0.5;
    
    CGFloat y = (self.view.bounds.size.height - wh) * 0.5;
    
    imageView.frame = CGRectMake(x, y, wh, wh);
    
    imageView.image = [UIImage imageNamed:@"011.jpg"];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self demo05];
}

- (void)demo05
{
    CATransform3D transform3D = self.container.layer.transform;
    
    transform3D = CATransform3DRotate(transform3D, -M_PI_4, 1, 0, 0);
    
    transform3D = CATransform3DRotate(transform3D, -M_PI_4, 0, 1, 0);
    
    [UIView animateWithDuration:5 animations:^{
       self.container.layer.sublayerTransform = transform3D;
    }];
}

- (void)demo04
{
//    self.imageView.layer.doubleSided = NO;
    
    self.imageView.layer.transform = CATransform3DIdentity;
    
    CATransform3D transform3D = CATransform3DMakeRotation(M_PI_4 * 1.2, 0, 1, 0);
    
    transform3D.m34 = -1 / 100;
    
    [UIView animateWithDuration:1 animations:^{
        self.imageView.layer.transform = transform3D;
    }];
}

- (void)demo03
{
    UIView *imageView = self.imageView;
    
    self.imageView.hidden = NO;
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.view addSubview:imageView];
    
    CGSize imageViewSize = self.imageView.bounds.size;
    
    CGRect leftRect = CGRectMake(0, 0, imageViewSize.width * 0.5, imageViewSize.height);
    
    UIView *leftView = [self.imageView resizableSnapshotViewFromRect:leftRect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    leftView.backgroundColor = [UIColor greenColor];
    
    CGPoint imageViewCenter = self.imageView.center;
    
    leftView.center = CGPointMake(imageViewCenter.x - imageViewSize.width * 0.25, imageViewCenter.y);

    [self.view addSubview:leftView];
    
    CGRect rightRect = CGRectOffset(leftRect, imageViewSize.width * 0.5, 0);
    
    UIView *rightView = [self.imageView resizableSnapshotViewFromRect:rightRect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    rightView.frame = CGRectOffset(leftView.frame, leftView.frame.size.width, 0);
    
    rightView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:rightView];
    
    [self.view sendSubviewToBack:rightView];
    
//    self.imageView.backgroundColor = [UIColor redColor];
    
//    [self.imageView removeFromSuperview];
    
    self.imageView.hidden = YES;
    
    rightView.layer.anchorPoint = CGPointMake(0, 0.5);
    
    rightView.center = CGPointMake(leftView.maxX, rightView.center.y);
    
    CATransform3D transform = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
    
    transform.m34 = -0.002;
    
    rightView.layer.zPosition = 1000;
    
    [UIView animateWithDuration:3 animations:^{

        rightView.layer.transform = transform;
    }];
    
}

- (void)demo02
{
    /*
     旋转遵循左手原则:
     左手竖起大拇指其它4根手指自然蜷缩，保证拇指跟其它4指垂直
     如果旋转角度是正数，拇指指向坐标轴正方向；如果旋转角度是负数拇指指向坐标轴坐标轴负方向。
     其它4指的指向即为旋转方向
     */
    
    self.imageView.layer.transform = CATransform3DIdentity;
    
    /// 绕y轴旋转 M_PI_4（类似绕y轴正序翻页）
    CATransform3D transform3D = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    
    /// 绕x轴旋转 M_PI_4 (类似绕x轴逆序翻页)
    transform3D = CATransform3DMakeRotation(M_PI_4, 1, 0, 0);
    
    /// 绕z轴旋转 M_PI_4 (绕z轴顺时针旋转)
//    transform3D = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    
    transform3D.m34 = -1.0 / 100;
    
    [UIView animateWithDuration:5 animations:^{
        
        self.imageView.layer.transform = transform3D;
    }];
    
}

- (void)demo01
{
    [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.imageView.transform = CGAffineTransformMakeShare(1, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}



@end
