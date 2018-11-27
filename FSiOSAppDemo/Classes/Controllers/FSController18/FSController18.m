//
//  FSController18.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/7.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController18.h"

@interface FSController18 ()

@end

static void xxxxx(CGPoint l1_p1, CGPoint l1_p2, CGPoint l2_p1, CGPoint l2_p2)
{
    
}

@implementation FSController18

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGPoint line[2];
    
    line[0] = CGPointMake(1, 2);
    
    CGPoint second = line[1];
    
    NSLog(@"");
    
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touchObj = [touches anyObject];
    
    CGPoint previousPoint = [touchObj previousLocationInView:self.view];
    
    NSLog(@"previousPoint: %@",NSStringFromCGPoint(previousPoint));
    
    CGPoint currentPoint = [touchObj locationInView:self.view];
    
    NSLog(@"currentPoint: %@", NSStringFromCGPoint(currentPoint));
}

@end
