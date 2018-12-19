//
//  FSCAController11.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/7.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAController11.h"

@interface FSCAController11 ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation FSCAController11

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorRandom;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


/**
 自定义截图动画02
 */
- (void)demo02
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *snapScreen = [window snapshotViewAfterScreenUpdates:YES];
    
    [self.view addSubview:snapScreen];
    
    CGAffineTransform affineTransform = CGAffineTransformMakeScale(0.001, 0.001);
    
    affineTransform = CGAffineTransformRotate(affineTransform, M_PI_2);
    
    [UIView animateWithDuration:2 animations:^{
       
        snapScreen.transform = affineTransform;
        
        self.view.backgroundColor = UIColorRandom;
        
    } completion:^(BOOL finished) {
        
        [snapScreen removeFromSuperview];
    }];
}

/**
 自定义截图动画01
 */
- (void)demo01
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    [self.view.layer renderInContext:contextRef];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageView *transformImageView = [[UIImageView alloc] initWithImage:image];
    
    [self.view addSubview:transformImageView];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [UIView animateWithDuration:2 animations:^{
        
        CGAffineTransform affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
        
        affineTransform = CGAffineTransformRotate(affineTransform, M_PI_2);
        
        transformImageView.transform = affineTransform;
        
        self.view.backgroundColor = UIColorRandom;
        
    } completion:^(BOOL finished) {
        
        [transformImageView removeFromSuperview];
    }];
}


@end
