//
//  FSController06.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController06.h"

@interface FSController06 ()

@end

@implementation FSController06

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    
//    effectView.backgroundColor = [UIColor redColor];
    
    effectView.frame = CGRectMake(100, 100, 500, 500);
    
    [self.view addSubview:effectView];
    
    UILabel *label = [[UILabel alloc] init];
    
    label.frame = CGRectMake(0, 0, 100, 35);
    
    label.text = @"asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfa";
    
    label.backgroundColor = [UIColor blueColor];
    
    [effectView.contentView addSubview:label];
    
//    UISplitViewController
    
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
