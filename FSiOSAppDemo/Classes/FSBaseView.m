//
//  FSBaseView.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/8/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSBaseView.h"
#import "FSBaseView+Sen.h"

@interface FSBaseView ()

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSBaseView

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

    [button setTitle:@"close" forState:UIControlStateNormal];
    
    [button setTitle:@"open" forState:UIControlStateSelected];

    button.titleLabel.font = [UIFont systemFontOfSize:14];

    self.button = button;

    [button addTarget:self
               action:@selector(clickButton:)
     forControlEvents:UIControlEventTouchDown];

    button.backgroundColor = [UIColor blueColor];

    [self addSubview:button];
    

//    UITableView *tableView = [[UITableView alloc] init];
//
//    self.tableView = tableView;
//
//    tableView.backgroundColor = [UIColor blueColor];
//
//    tableView.dataSource = (id<UITableViewDataSource>)self;
//
//    tableView.frame = self.bounds;
//
//    [self addSubview:tableView];
    
    
    
}

- (void)clickButton:(UIButton *)button
{
//    NSLog(@"来哦");
    button.selected = !button.selected;
    
    if (button.selected)
    {
        self.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
    }
    else
    {
        self.transform = CGAffineTransformIdentity;
    }
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil)
    {
        NSLog(@"nil");
        
        CGPoint clickPoint = [self.button convertPoint:point fromView:self];
        
        if (CGRectContainsPoint(self.button.bounds, clickPoint))
        {
            view = self.button;
        }
    }
    
    return view;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
    
    CGFloat btnW = 80;
    
    CGFloat btnH = 35;
    
    CGSize selfSize = self.bounds.size;
    
    CGFloat btnX = (selfSize.width - btnW) * 0.5;
    
    CGFloat btnY = selfSize.height;
    
    self.button.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

@end
