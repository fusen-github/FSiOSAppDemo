//
//  FSGestureRecognizer.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/7.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface FSGestureRecognizer ()
{
    CGPoint _lastPreviousPoint;
    
    CGPoint _lastCurrentPoint;
    
    CGFloat _lineLenghtSoFar;
}

@end

static NSNumber* angleBetweenToLines(CGPoint line1[2], CGPoint line2[2])
{
    // 1、先排除2条线是平行关系
    
    
    return nil;
}

@implementation FSGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touchObj = [touches anyObject];
    
    CGPoint point = [touchObj locationInView:self.view];
    
    _lastPreviousPoint = point;
    
    _lastCurrentPoint = point;
    
    _lineLenghtSoFar = 0;
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
