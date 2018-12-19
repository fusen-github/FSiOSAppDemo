//
//  FSViscosityView.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/11.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSViscosityView.h"

@interface FSViscosityView ()

@property (nonatomic, weak) UIButton *button;

@property (nonatomic, weak) UIView *positionView;

@end

@implementation FSViscosityView

+ (instancetype)new
{
    return [[self alloc] initWithTitle:@""];
}

- (instancetype)init
{
    return [self initWithTitle:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithTitle:nil];
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 30, 30)])
    {
        [self setupSubviewsWithTitle:title];
    }
    return self;
}

- (void)setupSubviewsWithTitle:(NSString *)title
{
    UIView *positionView = [[UIView alloc] init];
    
    positionView.backgroundColor = [UIColor redColor];
    
    self.positionView = positionView;
    
    [self addSubview:positionView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"100" forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    button.backgroundColor = [UIColor redColor];
    
    [button addTarget:self action:@selector(valueChangeAction:) forControlEvents:UIControlEventTouchDragInside];
    
    self.button = button;
    
    [self addSubview:button];
    
    self.layer.cornerRadius = self.bounds.size.height * 0.5;

    self.layer.masksToBounds = YES;
}

- (void)valueChangeAction:(UIButton *)button
{
    NSLog(@"%s",__func__);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button.frame = self.bounds;
}

@end
