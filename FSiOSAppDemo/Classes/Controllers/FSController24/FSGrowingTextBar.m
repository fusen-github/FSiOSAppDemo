//
//  FSGrowingTextBar.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSGrowingTextBar.h"

static NSString * const kTextViewBoundsKey = @"bounds";

@interface FSGrowingTextBar ()<UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, strong) NSLayoutConstraint *textViewHeightConstraint;

@end

@implementation FSGrowingTextBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn1.translatesAutoresizingMaskIntoConstraints = NO;
    
    btn1.backgroundColor = UIColorRandom;
    
    [self addSubview:btn1];
    
    UITextView *textView = [[UITextView alloc] init];
    
    textView.delegate = self;
    
    self.textView = textView;
    
    textView.layer.cornerRadius = 3;
    
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    textView.layer.borderWidth = 0.5;
    
    textView.layer.masksToBounds = YES;
    
    [textView addObserver:self
               forKeyPath:kTextViewBoundsKey
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
    textView.scrollEnabled = NO;
    
    textView.inputAccessoryView = [UIView new];
    
    textView.font = [UIFont systemFontOfSize:16];
    
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:textView];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn2.translatesAutoresizingMaskIntoConstraints = NO;
    
    btn2.backgroundColor = UIColorRandom;
    
    [self addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn3.translatesAutoresizingMaskIntoConstraints = NO;
    
    btn3.backgroundColor = UIColorRandom;
    
    [self addSubview:btn3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    CGFloat itemWH = 32;
    CGFloat marginH = 7;
    CGFloat marginV = 8;
    
    /// 布局btn1
    [btn1.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:marginH].active = YES;
    [btn1.widthAnchor constraintEqualToConstant:itemWH].active = YES;
    [btn1.heightAnchor constraintEqualToConstant:itemWH].active = YES;
    [btn1.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-marginV].active = YES;
    
    /// 布局textView
    /*
    // 方式1. 不能做到高度自动增长
    CGFloat textViewRightMargin = -(itemWH * 2 + 3 * marginH);
    [textView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:textViewRightMargin].active = YES;
    [textView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-marginV].active = YES;
    [textView.leftAnchor constraintEqualToAnchor:btn1.rightAnchor constant:marginH].active = YES;
    [textView.topAnchor constraintEqualToAnchor:self.topAnchor constant:marginV].active = YES;
    */
    
    CGFloat textViewRightMargin = -(itemWH * 2 + 3 * marginH);
    [textView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:textViewRightMargin].active = YES;
    [textView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-marginV].active = YES;
    [textView.leftAnchor constraintEqualToAnchor:btn1.rightAnchor constant:marginH].active = YES;
    [textView.topAnchor constraintEqualToAnchor:self.topAnchor constant:marginV].active = YES;
    
    /// 布局btn2
    [btn2.leftAnchor constraintEqualToAnchor:textView.rightAnchor constant:marginH].active = YES;
    [btn2.widthAnchor constraintEqualToConstant:itemWH].active = YES;
    [btn2.heightAnchor constraintEqualToConstant:itemWH].active = YES;
    [btn2.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-marginV].active = YES;
    
    /// 布局btn3
    [btn3.leftAnchor constraintEqualToAnchor:btn2.rightAnchor constant:marginH].active = YES;
    [btn3.widthAnchor constraintEqualToConstant:itemWH].active = YES;
    [btn3.heightAnchor constraintEqualToConstant:itemWH].active = YES;
    [btn3.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-marginV].active = YES;

}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.scrollEnabled)
    {
        CGFloat contentH = textView.contentSize.height;
        
        CGFloat frameH = textView.bounds.size.height;
        
        if (contentH <= frameH)
        {
            NSLog(@"11111");
            
            NSLog(@"%f, %f", contentH, frameH);
            
            NSLayoutConstraint *textViewHeightConstraint = [textView.heightAnchor constraintEqualToConstant:contentH];
            
            self.textViewHeightConstraint = textViewHeightConstraint;
            
            textViewHeightConstraint.active = YES;
            
            textView.scrollEnabled = NO;
            
            [textView updateConstraintsIfNeeded];
            
            [textView.superview updateConstraintsIfNeeded];
            
            return;
        }
        
        if (self.textViewHeightConstraint.active)
        {
            self.textViewHeightConstraint.active = NO;
        }
    }
    else
    {
        NSLog(@"scrollEnabled = NO");
        
        if (self.textViewHeightConstraint.active)
        {
            self.textViewHeightConstraint.active = NO;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:kTextViewBoundsKey])
    {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue].size;
        
        self.textView.scrollEnabled = newSize.height > 60;
    }
}

- (void)dealloc
{
    [self.textView removeObserver:self forKeyPath:kTextViewBoundsKey];
}

/*
 2018-12-19 21:05:51.338401+0800 FSiOSAppDemo[1870:1400885] NSConcreteNotification 0x1c0447350 {name = UIKeyboardWillShowNotification; userInfo = {
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 216}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 775}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 559}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 216}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 451}, {375, 216}}";
 UIKeyboardIsLocalUserInfoKey = 1;
 }}
 2018-12-19 21:05:51.644361+0800 FSiOSAppDemo[1870:1400885] NSConcreteNotification 0x1c0443bd0 {name = UIKeyboardWillShowNotification; userInfo = {
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 289.5}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 559}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 522.25}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 451}, {375, 216}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 377.5}, {375, 289.5}}";
 UIKeyboardIsLocalUserInfoKey = 1;
 }}
 2018-1
 */



- (void)_keyboardWillShow:(NSNotification *)noti
{
    /*
     warning: ios11，当键盘第一次弹出时该回调会连续调用两次.原因未知
     */
    
    if ([self.delegate respondsToSelector:@selector(bar:keyboardWillAppearWithUserInfo:)])
    {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        
        id frame = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        
        [userInfo setObject:frame forKey:UIKeyboardFrameEndUserInfoKey];
        
        id duration = [noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        
        [userInfo setObject:duration forKey:UIKeyboardAnimationDurationUserInfoKey];
        
        [self.delegate bar:self keyboardWillAppearWithUserInfo:userInfo];
    }
}


- (void)_keyboardWillHidden:(NSNotification *)noti
{
    if ([self.delegate respondsToSelector:@selector(bar:keyboardWillDisappearWithUserInfo:)])
    {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        
        id frame = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        
        [userInfo setObject:frame forKey:UIKeyboardFrameEndUserInfoKey];
        
        id duration = [noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        
        [userInfo setObject:duration forKey:UIKeyboardAnimationDurationUserInfoKey];
        
        [self.delegate bar:self keyboardWillDisappearWithUserInfo:userInfo];
    }
}

@end
