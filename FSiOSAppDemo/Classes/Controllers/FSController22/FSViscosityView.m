//
//  FSViscosityView.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/11.
//  Copyright © 2018年 付森. All rights reserved.
//

/*
 参考地址
 https://blog.csdn.net/m0_37989980/article/details/78309158
 */

#import "FSViscosityView.h"

static CGFloat const kMaxDistance = 150;

@interface FSViscosityView ()

@property (nonatomic, weak) UIButton *button;

@property (nonatomic, weak) UIView *anchorView;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation FSViscosityView

- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil)
    {
        _shapeLayer = [[CAShapeLayer alloc] init];
    }
    return _shapeLayer;
}

+ (instancetype)new
{
    return [[self alloc] initWithTitle:@""];
}

- (instancetype)init
{
    return [self initWithTitle:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithTitle:nil];
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 30, 30)])
    {
        [self setupSubviewsWithTitle:title];
    }
    return self;
}


- (void)setupSubviewsWithTitle:(NSString *)title
{
    CGFloat radius = self.bounds.size.height * 0.5;
    
    /// 锚点视图
    UIView *anchorView = [[UIView alloc] init];
    
    anchorView.layer.cornerRadius = radius;
    
    anchorView.layer.masksToBounds = YES;
    
    anchorView.backgroundColor = [UIColor redColor];
    
    anchorView.frame = self.bounds;
    
    self.anchorView = anchorView;
    
    [self addSubview:anchorView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = self.bounds;
    
    [button setTitle:@"8" forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    button.backgroundColor = [UIColor redColor];
    
    self.button = button;
    
    button.layer.cornerRadius = radius;
    
    button.layer.masksToBounds = YES;
    
    [self addSubview:button];
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    
    [self addGestureRecognizer:panGesture];
    
    self.layer.cornerRadius = radius;
}


- (void)panGestureAction:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self];
    
    CGPoint tmpCenter = self.button.center;
    
    tmpCenter.x += point.x;
    tmpCenter.y += point.y;
    
    self.button.center = tmpCenter;
    
    [pan setTranslation:CGPointZero inView:self];
    
    CGPoint anchorCenter = self.anchorView.center;
    
    CGFloat distance = [self distanceFromPoint:anchorCenter toPoint:tmpCenter];
    
    CGFloat anchorRadius = self.bounds.size.width * 0.5;
    
    anchorRadius -= (distance / 16);

    if (distance > kMaxDistance)
    {
        if (!self.anchorView.hidden)
        {
            self.anchorView.hidden = YES;
        }
    }
    else
    {
        if (self.anchorView.hidden)
        {
            self.anchorView.hidden = NO;
        }
    }
    
    self.anchorView.bounds = CGRectMake(0, 0, anchorRadius * 2, anchorRadius * 2);

    self.anchorView.layer.cornerRadius = anchorRadius;
    
    self.shapeLayer.fillColor = [UIColor redColor].CGColor;

    [self.layer insertSublayer:self.shapeLayer atIndex:0];

    UIBezierPath *path = [self bezierPathWithBtn:self.button anchorView:self.anchorView distance:distance];

    if (!self.anchorView.hidden)
    {
        self.shapeLayer.path = path.CGPath;
    }
    else
    {
        [self.shapeLayer removeFromSuperlayer];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        // 距离小于最大距离
        if (distance < kMaxDistance)
        {
            // 添加一个弹簧动画
            [UIView animateWithDuration:0.25 delay:0.01 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                // 将绘制的图形清空
                [self.shapeLayer removeFromSuperlayer];
                
                // 和小圆重合
                self.button.center = self.anchorView.center;
                self.anchorView.hidden = NO;
                
            } completion:nil];
            
        }
        else
        {
            //播放一个动画消失
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
            
            imageV.center = self.button.center;
            
            imageV.backgroundColor = [UIColor blueColor];
            
//            CAEmitterLayer
            
            NSMutableArray *imageArray = [NSMutableArray array];
            
//            for (int i = 0 ; i < 8; i++)
//            {
//                UIImage *image =  [UIImage imageNamed:[NSString stringWithFormat:@"%d",i +1]];
//
//                [imageArray addObject:image];
//            }
            
            imageV.animationImages = imageArray;
            imageV.animationDuration = 2.5;
            [imageV startAnimating];
            
            [self addSubview:imageV];
            
            // 延迟1s后执行
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 将自己从父控件中移除
                [self removeFromSuperview];
            });
        }
    }
    
}

- (UIBezierPath *)bezierPathWithBtn:(UIView *)btn anchorView:(UIView *)anchorView distance:(double)distance
{
    if (distance <= 0)
    {
        return nil;
    }
    
    CGPoint anchorC = anchorView.center;
    CGPoint btnC = btn.center;
    
    
    CGFloat sinθ = (btnC.x - anchorC.x) / distance;
    CGFloat cosθ = (btnC.y - anchorC.y) / distance;
    
    CGFloat anchorR = anchorView.bounds.size.height * 0.5;
    CGFloat btnR = btn.bounds.size.height * 0.5;
    
    
    CGPoint p_a = CGPointMake(anchorC.x - anchorR * cosθ, anchorC.y + anchorR * sinθ);
    CGPoint p_b = CGPointMake(anchorC.x + anchorR * cosθ, anchorC.y - anchorR * sinθ);
    
    CGPoint p_c = CGPointMake(btnC.x + btnR * cosθ, btnC.y - btnR * sinθ);
    CGPoint p_d = CGPointMake(btnC.x - btnR * cosθ, btnC.y + btnR * sinθ);
    
    /// 控制点
    CGPoint p_1 = CGPointMake(p_a.x + distance * 0.5 * sinθ, p_a.y + distance * 0.5 * cosθ);
    CGPoint p_2 = CGPointMake(p_b.x + distance * 0.5 * sinθ, p_b.y + distance * 0.5 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:p_a];
    [path addLineToPoint:p_b];
    
    [path addQuadCurveToPoint:p_c controlPoint:p_2];
    
    [path addLineToPoint:p_d];
    
    [path addQuadCurveToPoint:p_a controlPoint:p_1];
    
    return path;
}

- (double)distanceFromPoint:(CGPoint)p1 toPoint:(CGPoint)p2
{
    CGFloat diffX = p1.x - p2.x;
    
    CGFloat diffY = p1.y - p2.y;
    
    CGFloat distance = sqrt(pow(diffX, 2) + pow(diffY, 2));
    
    return distance;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}


@end
