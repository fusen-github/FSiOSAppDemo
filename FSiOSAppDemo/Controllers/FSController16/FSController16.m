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

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",touches);
    
    NSLog(@"%@",event.allTouches);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
