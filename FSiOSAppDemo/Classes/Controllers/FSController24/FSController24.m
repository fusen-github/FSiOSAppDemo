//
//  FSController24.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController24.h"
#import "FSGrowingTextBar.h"
#import "IQKeyboardManager.h"


@interface FSController24 ()

@property (nonatomic, weak) UILabel *lb1;

@property (nonatomic, weak) UILabel *lb2;

@property (nonatomic, weak) FSGrowingTextBar *bar;

@end

@implementation FSController24

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
    
    [self demo02];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)demo02
{
    FSGrowingTextBar *bar = [[FSGrowingTextBar alloc] init];
    
    bar.delegate = (id<FSGrowingTextBarDelegate>)self;
    
//    CGFloat barH = 49;
//
//    CGFloat barW = self.view.width;
//
//    CGFloat barY = self.view.height - barH;
//
//    bar.frame = CGRectMake(0, barY, barW, barH);
    
    bar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.bar = bar;
    
    [self.view addSubview:bar];
    
    /// 布局
    [bar.leftAnchor constraintEqualToAnchor:bar.superview.leftAnchor].active = YES;
    
    [bar.rightAnchor constraintEqualToAnchor:bar.superview.rightAnchor].active = YES;
    
    [bar.bottomAnchor constraintEqualToAnchor:bar.superview.bottomAnchor].active = YES;
    
    [bar.heightAnchor constraintGreaterThanOrEqualToConstant:49].active = YES;
//    [bar.heightAnchor constraintLessThanOrEqualToConstant:49].active = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark FSGrowingTextBarDelegate
- (void)bar:(FSGrowingTextBar *)bar keyboardWillAppearWithUserInfo:(NSDictionary *)userInfo
{
    CGRect frame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    float duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    NSLog(@"kbH = %f", frame.size.height);
    
    [UIView animateWithDuration:duration animations:^{
       
        bar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
    }];
}

- (void)bar:(FSGrowingTextBar *)bar keyboardWillDisappearWithUserInfo:(NSDictionary *)userInfo
{
    float duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
       
        bar.transform = CGAffineTransformIdentity;
    }];
}

- (void)doRightAction
{
    self.lb1.text = @"lb1";
    
    self.lb2.text = @"lb2";
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    NSString *title = self.lb1.text;
    
    title = title ? : @"";
    
    title = [title stringByAppendingString:@"asjflkascdlkasdklcmklasdmkckamsdlkmcklad_0000"];
    
    self.lb1.text = title;
    
    self.lb2.text = [title substringToIndex:title.length * 0.5];
}



@end

@implementation FSController24 (Demo01)

- (void)demo01
{
    UIView *baseView = [[UIView alloc] init];
    
    baseView.translatesAutoresizingMaskIntoConstraints = NO;
    
    baseView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:baseView];
    
    NSString *title = @"11可带出马拉喀什的名称看了吗三大块咔擦上看了订餐卡收到吗没打开擦扩散到门口擦拭没看出马上道路名称拉克丝的仓库拉吗什么打开门擦拭的莱卡棉收到老蔡库吗三大块摩擦倒是凉快充满了卡速度慢11";
    
    title = nil;
    
    UILabel *lb1 = [self labelWithText:title];
    
    self.lb1 = lb1;
    
    [baseView addSubview:lb1];
    
    
    title = [title stringByAppendingString:title];
    
    UILabel *lb2 = [self labelWithText:title];
    
    self.lb2 = lb2;
    
    [baseView addSubview:lb2];
    
    
    [self fs2_layoutBaseView:baseView label1:lb1 label2:lb2];
}

- (void)fs2_layoutBaseView:(UIView *)baseView label1:(UILabel *)lb1 label2:(UILabel *)lb2
{
    /// 布局baseView
    [baseView.leftAnchor constraintEqualToAnchor:baseView.superview.leftAnchor constant:20].active = YES;
    [baseView.rightAnchor constraintEqualToAnchor:baseView.superview.rightAnchor constant:-20].active = YES;
    [baseView.topAnchor constraintEqualToAnchor:baseView.superview.topAnchor constant:100].active = YES;
    
    
    /// 布局lb1
    [lb1.leftAnchor constraintEqualToAnchor:lb1.superview.leftAnchor constant:20].active = YES;
    [lb1.topAnchor constraintEqualToAnchor:lb1.superview.topAnchor constant:20].active = YES;
    [lb1.rightAnchor constraintEqualToAnchor:lb1.superview.rightAnchor constant:-20].active = YES;
    
    
    /// 布局lb2
    [lb2.leftAnchor constraintEqualToAnchor:lb2.superview.leftAnchor constant:20].active = YES;
    [lb2.topAnchor constraintEqualToAnchor:lb1.bottomAnchor constant:20].active = YES;
    [lb2.rightAnchor constraintEqualToAnchor:lb2.superview.rightAnchor constant:-20].active = YES;
    
    
    /// 设置最底下subview到superview的底部的space。目的就是为了布局父视图的高度。将父视图的高度随子视图而变化
    [lb2.bottomAnchor constraintEqualToAnchor:baseView.bottomAnchor constant:-20].active = YES;
}

- (void)fs1_layoutBaseView:(UIView *)baseView label1:(UILabel *)lb1 label2:(UILabel *)lb2
{
    /// 布局baseView
    [baseView.leftAnchor constraintEqualToAnchor:baseView.superview.leftAnchor constant:20].active = YES;
    [baseView.rightAnchor constraintEqualToAnchor:baseView.superview.rightAnchor constant:-20].active = YES;
    [baseView.topAnchor constraintEqualToAnchor:baseView.superview.topAnchor constant:100].active = YES;
    
    
    /// 布局lb1
    [lb1.leftAnchor constraintEqualToAnchor:lb1.superview.leftAnchor constant:20].active = YES;
    [lb1.topAnchor constraintEqualToAnchor:lb1.superview.topAnchor constant:20].active = YES;
    [lb1.rightAnchor constraintEqualToAnchor:lb1.superview.rightAnchor constant:-20].active = YES;
    [lb1.heightAnchor constraintEqualToConstant:50].active = YES;
    
    /// 布局lb2
    [lb2.leftAnchor constraintEqualToAnchor:lb2.superview.leftAnchor constant:20].active = YES;
    [lb2.topAnchor constraintEqualToAnchor:lb1.bottomAnchor constant:20].active = YES;
    [lb2.rightAnchor constraintEqualToAnchor:lb2.superview.rightAnchor constant:-20].active = YES;
    [lb2.heightAnchor constraintEqualToConstant:200].active = YES;
    
    /// 设置最底下subview到superview的底部的space。目的就是为了布局父视图的高度。将父视图的高度随子视图而变化
    [lb2.bottomAnchor constraintEqualToAnchor:baseView.bottomAnchor constant:-20].active = YES;
}

- (UILabel *)labelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    
    label.numberOfLines = 0;
    
    label.font = [UIFont systemFontOfSize:14];
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    label.text = text;
    
    label.backgroundColor = UIColorRandom;
    
    //    [label sizeToFit];
    
    return label;
}

@end
