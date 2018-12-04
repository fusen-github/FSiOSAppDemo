//
//  FSCAController02.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController02.h"
#import "FSCAView01.h"


@interface FSCAController02 ()

@property (nonatomic, weak) FSCAView01 *blueView;

@property (nonatomic, weak) UIView *redView;

@end

@implementation FSCAController02

/*
 可视化界面包括UIView(视图)和CALayer(图层)，其中UIView是对CALayer的高级封装
 每个UIView都会绑定一个CALayer，只有CALayer才可以真正的显示内容
 视图、图层布局属性包括
 视图:frame、bounds、center
 图层:frame、bounds、position
 其中视图的frame、bounds、center等属性只是对图层frame、bounds、position属性的存取方法
 修改视图的frame、bounds、center，实际上是修改了视图所绑定图层的frame、bounds、position属性
 
 视图、图层的frame表示它们各自在父视图/父图层上的显示位置和大小(呈现效果)
 frame的值最终是由bounds、center、transform等属性的值综合计算后的结果
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = 300;
    
    CGFloat height = 300;
    
    CGFloat x = (self.view.bounds.size.width - width) * 0.5;
    
    CGFloat y = (self.view.bounds.size.height - height) * 0.5;
    
    UIView *redView = [[UIView alloc] init];
    
    self.redView = redView;
    
    redView.frame = CGRectMake(x, y, width, height);
    
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
    FSCAView01 *blueView = [[FSCAView01 alloc] init];
    
    self.blueView = blueView;
    
    blueView.frame = redView.frame;
    
    blueView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:blueView];
    
    /// 添加UISwitch控件调试
    UISwitch *sw = [[UISwitch alloc] init];
    
    [blueView addSubview:sw];
    
    sw = [UISwitch new];
    
    x = blueView.bounds.size.width - sw.bounds.size.width;
    
    y = blueView.bounds.size.height - sw.bounds.size.height;
    
    sw.frame = CGRectMake(x, y, sw.bounds.size.width, sw.bounds.size.height);
    
    sw.on = YES;
    
    [blueView addSubview:sw];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self demo09];
    
//    [self.view convertPoint:CGPointZero toView:nil];
}

- (void)demo09
{
    self.blueView.layer.anchorPoint = CGPointMake(1, 1);
}

/**
 layer.zPosition
 */
- (void)demo08
{
    self.redView.layer.zPosition = 1.0;
    
    NSLog(@"%@",self.view.subviews);
    /*
     layer.zPosition属性可以改变兄弟图层之间的显示顺序，默认是0。值越来显示越靠上层(离眼睛越近)
     但是该属性只影响了界面图层的显示效果，并不会改变父图层中所有子图层数组的顺序
     */
}

/**
 layer.position
 */
- (void)demo07
{
    NSLog(@"position: %@", NSStringFromCGPoint(self.blueView.layer.position));
    
    NSLog(@"center: %@", NSStringFromCGPoint(self.blueView.center));
    
    self.blueView.layer.anchorPoint = CGPointMake(-0.5, -0.5);
    
    // {512, 384}
    NSLog(@"position: %@", NSStringFromCGPoint(self.blueView.layer.position));
    
    NSLog(@"center: %@", NSStringFromCGPoint(self.blueView.center));
    
    /*
     默认情况下layer.position就是指图层的锚点(layer.anchorPoint)在父图层坐标系中的位置
     */
}

/**
 anchorPoint
 */
- (void)demo06
{
    NSLog(@"before: %@", NSStringFromCGRect(self.blueView.frame));
    
    NSLog(@"before_center: %@", NSStringFromCGPoint(self.blueView.center));
    
//    self.blueView.layer.anchorPoint = CGPointZero;
    
    self.blueView.layer.anchorPoint = CGPointMake(1, 1);
    
//    self.blueView.layer.anchorPoint = CGPointMake(-0.5, -0.5);
    
//    self.blueView.layer.anchorPoint = CGPointMake(-1, -1);
    
    NSLog(@"after: %@", NSStringFromCGRect(self.blueView.frame));
    
    NSLog(@"after_center: %@", NSStringFromCGPoint(self.blueView.center));
    
    /*
     结论
     修改锚点(anchorPoint)，会影响view.frame.origin的值，不会影响view.bounds,不会影响view.center
     所谓锚点就是指定一个位置当做视图的中心点。默认视图中心点为视图物理的中心点(或者是重心点)
     设置锚点后，那个指定为锚点的点将会被放置到view.center所表示的位置上
     但是CALayer提供了修改锚点(anchorPoint)的接口，可以指定视图上的一个位置为视图的中心点
     */
}

/**
 anchorPoint
 */
- (void)demo05
{
    CGPoint anchorPoint = self.blueView.layer.anchorPoint;
    
    NSLog(@"%@",NSStringFromCGPoint(anchorPoint));
    /*
     anchorPoint 锚点，是一个相对值默认值是{0.5, 0.5}，表示在视图的中心点
     */
}

- (void)demo04
{
    self.blueView.bounds = CGRectMake(0, 0, self.blueView.bounds.size.width, self.blueView.bounds.size.height);
    
    /*
     结论
     只有bounds值发生变化，才会调用view的layoutSubviews方法。否则不会调用
     修改view.bounds相当于修改view自己的坐标系在父视图中的位置和大小
     */
}

/**
 视图的bounds属性
 */
- (void)demo03
{
    NSLog(@"st: %@",NSStringFromCGRect(self.blueView.frame));
    
    CGSize size = self.blueView.bounds.size;
    
    self.blueView.bounds = CGRectMake(-50, -50, size.width, size.height);
    
    self.blueView.layer.backgroundColor = [UIColor grayColor].CGColor;
    
    NSLog(@"ed: %@",NSStringFromCGRect(self.blueView.frame));
    
    /*
     结论:
     1、blueView的frame没有改变，在父视图中的位置也不会发生变化
     2、视图的bounds属性代表一个视图的轮廓在自己坐标系中的位置
     3、单独修改视图的bounds的x、y属性相当于修改自己坐标系的起始点，以满足bounds的值
     4、因为子视图的frame是相对于父视图坐标系而设定的，所以修改视图的bounds会影响到视图内部子控件的布局
     */
}

- (void)demo02
{
    CGSize size = self.blueView.bounds.size;
    
    self.blueView.bounds = CGRectMake(0, 0, size.width * 0.5, size.height * 0.5);
    
    NSLog(@"%@",NSStringFromCGRect(self.blueView.frame));
    
    /*
     修改view.bounds，保持view.center不变
     view的frame.origin也改变了说明frame是由bounds和center属性共同决定的
     view.bounds属性发生改变，会调用view的layoutSubviews方法，
     view.frame属性发生改变，如果没有影响到bounds的话，layoutSubviews是不是调用的。
     因为layoutSubviews是否会调用取决于视图的bounds属性的值是否发生了变化
     */
}

/**
 transform属性
 */
- (void)demo01
{
    NSLog(@"beforeRotation: %@", NSStringFromCGRect(self.blueView.frame));
    
    self.blueView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    NSLog(@"afterRotation: %@", NSStringFromCGRect(self.blueView.frame));
    
    /*
     结论:
     视图的frame是一个虚拟的概念，是由center、bounds、tansform等属性共同作用的一个结果
     相反修改frame也会影响到center、bounds、tansform属性
     frame、center是参考父视图坐标系而衡量的
     bounds是参考自己的坐标系而衡量的
     而frame代表视图最终结果的大小和位置
     */
}

@end
