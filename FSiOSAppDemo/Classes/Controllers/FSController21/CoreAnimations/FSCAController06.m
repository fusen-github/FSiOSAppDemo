//
//  FSCAController06.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/30.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController06.h"
#import "FSLayer.h"


@interface FSCAController06 ()

@property (nonatomic, weak) UIView *redView;

@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation FSCAController06

/*
 CATransition   过渡
 CATransaction  事务/交易
 CATransform3D  3D变换
 transport      交通、运输
 transportation 交通、运输
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *redView = [UIView new];
    
    self.redView = redView;
    
    redView.backgroundColor = [UIColor redColor];
    
    redView.frame = CGRectMake(0, 0, 200, 200);
    
    redView.center = self.view.center;
    
    [self.view addSubview:redView];
    
    FSLayer *blueLayer = [FSLayer layer];
    
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    self.blueLayer = blueLayer;
    
    blueLayer.frame = CGRectOffset(redView.frame, 300, 0);
    
    [self.view.layer addSublayer:blueLayer];
    
    CATransition *transitionAnnimation = [CATransition animation];
    
    transitionAnnimation.type = kCATransitionPush;
    
    transitionAnnimation.subtype = kCATransitionFromLeft;
    
//    blueLayer.actions = @{@"backgroundColor":transitionAnnimation};
    
    redView.layer.actions = @{@"backgroundColor":transitionAnnimation};
    
//    [blueLayer addAnimation:transitionAnnimation forKey:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAciton)];
}

- (void)doRightAciton
{
//    self.redView.transform = CGAffineTransformIdentity;
//
//    self.blueLayer.affineTransform = CGAffineTransformIdentity;
    
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    self.redView.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self demo09:touches.anyObject];
    
    [self demo13];
}

- (void)demo14
{
    self.blueLayer.backgroundColor = [UIColor greenColor].CGColor;
}

- (void)demo13
{
    /// CALayer 默认带有隐式动画，(单独设置Layer能看到一个轻微的过渡过程)
    self.blueLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    /// UIView 把它绑定的 CALayer的隐式动画给屏蔽掉了(没有过渡过程，瞬间就完成了颜色的改变)
    self.redView.backgroundColor = [UIColor greenColor];
}

/*--------------------------------------------------------------------------------*/

- (void)demo12
{
    id rst1 = [self.redView actionForLayer:self.redView.layer forKey:@"backgroundColor"];
    
    [UIView beginAnimations:nil context:nil];
    
    id rst2 = [self.redView actionForLayer:self.redView.layer forKey:@"backgroundColor"];
    
    [UIView commitAnimations];
}

/* Returns the action object associated with the event named by the
 * string 'event'. The default implementation searches for an action
 * object in the following places:
 *
 * 1. if defined, call the delegate method -actionForLayer:forKey:
 * 2. look in the layer's `actions' dictionary
 * 3. look in any `actions' dictionaries in the `style' hierarchy
 * 4. call +defaultActionForKey: on the layer's class
 *
 * If any of these steps results in a non-nil action object, the
 * following steps are ignored. If the final result is an instance of
 * NSNull, it is converted to `nil'. */

- (void)demo11
{
    id action1 = [self.blueLayer.delegate actionForLayer:self.blueLayer forKey:@"backgroundColor"];
    
    id action2 = self.blueLayer.actions;
    
    id action3 = self.blueLayer.style;
    
    id defaultAction = [CALayer defaultActionForKey:@"backgroundColor"];
    
    id action = [self.blueLayer actionForKey:@"backgroundColor"];
    
    NSLog(@"%@",action);
}

- (void)demo10
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.redView.transform = CGAffineTransformMakeTranslation(0, 100);
        
    } completion:^(BOOL finished) {
        
    }];
    
    self.blueLayer.affineTransform = CGAffineTransformMakeTranslation(0, 100);
}

- (void)demo09:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self.view];
    
    if ([self.blueLayer.presentationLayer hitTest:point])
    {
        self.blueLayer.backgroundColor = UIColorRandom.CGColor;
    }
    else
    {
        NSLog(@"没点中");
        
        [CATransaction begin];
        
        [CATransaction setAnimationDuration:5];
        
        self.blueLayer.position = point;
        
        [CATransaction commit];
    }
}

- (void)demo08
{
    NSLog(@"%@",self.blueLayer);
    
    NSLog(@"%@",self.blueLayer.presentationLayer);
    
    NSLog(@"%@", self.blueLayer.modelLayer);
}

- (void)demo07
{
    CGPoint position = self.blueLayer.position;
    
    NSLog(@"1、%@",NSStringFromCGPoint(position));
    
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:2.0];
    
    position = CGPointMake(position.x, position.y + 100);
    
    self.blueLayer.position = position;
    
    NSLog(@"2、%@",NSStringFromCGPoint(position));
    
    [CATransaction commit];
    
    NSLog(@"end");
}

- (void)demo06
{
//    self.blueLayer.backgroundColor = UIColorRandom.CGColor;
    
    id oldDelegate = self.redView.layer.delegate;
    
    self.redView.layer.delegate = nil;
    
    self.redView.layer.backgroundColor = UIColorRandom.CGColor;
    
    self.redView.layer.delegate = oldDelegate;
    
//    self.blueLayer.presentationLayer
    
//    self.blueLayer.modelLayer
}

- (void)demo05
{
//    [CATransaction setAnimationDuration:2];

    /* CALayer 默认自带隐式动画，所以只需要设置一个事务时间，就能看到明显的动画效果*/
    self.blueLayer.affineTransform = CGAffineTransformMakeTranslation(0, 100);
    
    /* UIView默认将CALayer的隐式动画给屏蔽了，所以无法显示出动画效果 */
    self.redView.transform = CGAffineTransformMakeTranslation(0, 100);
}

/**
 进一步验证UIView屏蔽了CALayer的隐式动画
 */
- (void)demo04
{
    /// 详情参考 actionForKey:的解释说明
    [self.redView.layer actionForKey:@"backgroundColor"];
}

/**
 验证UIView屏蔽了CALayer的隐式动画
 */
- (void)demo03
{
    /*
     先将layer.delegate清空，就可以恢复隐式动画了。
     说明UIView作为它绑定的CALayer的代理的同时，禁用了CALayer的隐式动画
    */
    id delegate = self.redView.layer.delegate;
    
    self.redView.layer.delegate = nil;
    
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:3];
    
    [CATransaction setCompletionBlock:^{
        
        NSLog(@"完成了");
        
        self.redView.layer.delegate = delegate;
    }];
    
    self.redView.layer.backgroundColor = [UIColor blueColor].CGColor;
    
    [CATransaction commit];
}

- (void)demo02
{
    /*
     UIView禁用了CALayer的隐式动画
     */
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:3];
    
    [CATransaction setCompletionBlock:^{
       
        NSLog(@"完成了");
    }];
    
    self.redView.layer.backgroundColor = [UIColor blueColor].CGColor;
    
    [CATransaction commit];
}

- (void)demo01
{
    [UIView beginAnimations:@"11" context:nil];
    
    [UIView setAnimationDuration:2];
    
    self.redView.backgroundColor = [UIColor blueColor];
    
    [UIView commitAnimations];
}

@end
