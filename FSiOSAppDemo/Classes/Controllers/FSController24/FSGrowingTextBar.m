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

@property (nonatomic, strong) NSLayoutConstraint *textViewBottomConstraint;

@property (nonatomic, strong) NSLayoutConstraint *textViewTopConstraint;

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
    
    UIEdgeInsets edgeInset = textView.textContainerInset;
    
    edgeInset.top = 6.5;

    edgeInset.bottom = 6.5;

    textView.textContainerInset = edgeInset;
    
    [self addSubview:textView];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn2.translatesAutoresizingMaskIntoConstraints = NO;
    
    btn2.backgroundColor = UIColorRandom;
    
    [self addSubview:btn2];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn3.translatesAutoresizingMaskIntoConstraints = NO;
    
    btn3.backgroundColor = UIColorRandom;
    
    [self addSubview:btn3];
    
    /// test
    btn1.hidden = btn2.hidden = btn3.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    CGFloat itemWH = 35;
    CGFloat marginH = 7;
    CGFloat marginV = 8;
    
    /// 布局btn1
    [btn1.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:marginH].active = YES;
    [btn1.widthAnchor constraintEqualToConstant:itemWH].active = YES;
    [btn1.heightAnchor constraintEqualToConstant:itemWH].active = YES;
    [btn1.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-marginV].active = YES;
    
    
    /// 布局textView
    CGFloat textViewRightMargin = -(itemWH * 2 + 3 * marginH);
    [textView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:textViewRightMargin].active = YES;
    NSLayoutConstraint *textViewBottomConstraint =
    [textView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-marginV];
    textViewBottomConstraint.active = YES;
    self.textViewBottomConstraint = textViewBottomConstraint;
    
    [textView.leftAnchor constraintEqualToAnchor:btn1.rightAnchor constant:marginH].active = YES;
    NSLayoutConstraint *textViewTopConstraint =
    [textView.topAnchor constraintEqualToAnchor:self.topAnchor constant:marginV];
    textViewTopConstraint.active = YES;
    self.textViewTopConstraint = textViewTopConstraint;
    
    
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
        CGPoint point = CGPointMake(0, textView.contentSize.height - textView.bounds.size.height);
        
        if (textView.contentOffset.y != point.y)
        {
            [self.textView setContentOffset:point animated:YES];
        }
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:kTextViewBoundsKey])
    {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue].size;
        
        CGSize oldSize = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue].size;
        
        if (oldSize.height < newSize.height)
        {
            CGFloat tvTopSpace = fabs(self.textViewTopConstraint.constant);
            
            CGFloat tvBottomSpace = fabs(self.textViewBottomConstraint.constant);
            
            CGFloat maxValue = self.maxHeightLayoutConstraint.constant - tvTopSpace - tvBottomSpace;

            if (newSize.height == maxValue && !self.textView.scrollEnabled)
            {
                self.textView.scrollEnabled = YES;
                
                CGPoint point = CGPointMake(0, self.textView.contentSize.height - self.textView.bounds.size.height);
                
                [self.textView setContentOffset:point animated:YES];
            }
        }
        else if (oldSize.height > newSize.height)
        {
            if (self.textView.scrollEnabled)
            {
                self.textView.scrollEnabled = NO;
                
                [self.textView setNeedsUpdateConstraints];
            }
        }
        else
        {
            CGSize contentSize = self.textView.contentSize;
            
            if (contentSize.height < newSize.height)
            {
                if (self.textView.scrollEnabled)
                {
                    self.textView.scrollEnabled = NO;
                    
                    [self.textView setNeedsUpdateConstraints];
                }
            }
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview)
    {
        NSLayoutConstraint *leftLayoutConstraint = [self.leftAnchor constraintEqualToAnchor:newSuperview.leftAnchor];
        _leftLayoutConstraint = leftLayoutConstraint;
        
        NSLayoutConstraint *rightLayoutConstraint = [self.rightAnchor constraintEqualToAnchor:newSuperview.rightAnchor];
        _rightLayoutConstraint = rightLayoutConstraint;

        NSLayoutConstraint *bottomLayoutConstraint = [self.bottomAnchor constraintEqualToAnchor:newSuperview.bottomAnchor];
        _bottomLayoutConstraint = bottomLayoutConstraint;

        
        NSLayoutConstraint *minHeightLayoutConstraint = [self.heightAnchor constraintGreaterThanOrEqualToConstant:52];
        _minHeightLayoutConstraint = minHeightLayoutConstraint;

        NSLayoutConstraint *maxHeightLayoutConstraint = [self.heightAnchor constraintLessThanOrEqualToConstant:119];
        _maxHeightLayoutConstraint = maxHeightLayoutConstraint;
    }
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSLog(@"%s",__func__);
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
