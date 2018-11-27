//
//  FSController16.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController16.h"
#import <CoreGraphics/CoreGraphics.h>
//#import <QuartzCore/QuartzCore.h>
#import "FSQuartzView.h"
#import <SpriteKit/SpriteKit.h>



@interface FSController16 ()

@end

@implementation FSController16

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSCache
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",touches);
    
    NSLog(@"%@",event.allTouches);
}



@end
