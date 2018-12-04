//
//  FSCAView02.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/30.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCAView02.h"

@interface FSCAView02 ()

@property (nonatomic, weak) UIButton *button;

@property (nonatomic, copy) NSString *btnTitle;

@end

@implementation FSCAView02

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.button = button;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button setTitle:self.btnTitle forState:UIControlStateNormal];
    
    [self addSubview:button];
}

- (void)setTitle:(NSString *)title color:(UIColor *)color
{
    self.btnTitle = title;
    
    [self.button setTitleColor:color forState:UIControlStateNormal];
    
    [self.button setTitle:title forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button.frame = CGRectInset(self.bounds, 50, 50);
}

@end
