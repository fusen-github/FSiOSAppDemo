//
//  FSRefreshHeader.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSRefreshHeader.h"

static CGFloat const kHeaderHeight = 54;

static NSString * const kUIScrollViewContentOffsetKey = @"contentOffset";

@interface FSRefreshHeader ()

@property (nonatomic, assign) FSRefreshStatus status;

@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, weak) UIActivityIndicatorView *activityView;

@property (nonatomic, assign) BOOL showArrow;

@end

@implementation FSRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.backgroundColor = [UIColor clearColor];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        self.activityView = activityView;
        
        [self addSubview:activityView];
        
        UILabel *textLabel = [[UILabel alloc] init];
        
        textLabel.textColor = [UIColor lightGrayColor];
        
        self.textLabel = textLabel;
        
        textLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:textLabel];
        
        self.showArrow = YES;
        
        self.status = FSRefreshStatusIdle;
    }
    return self;
}

- (void)setStatus:(FSRefreshStatus)status
{
    _status = status;
    
    if (status == FSRefreshStatusIdle)
    {
        self.textLabel.text = @"下拉刷新";
    }
    else if (status == FSRefreshStatusWillRefresh)
    {
        self.textLabel.text = @"松开立即刷新";
    }
    else if (status == FSRefreshStatusRefreshing)
    {
        self.textLabel.text = @"正在刷新......";
    }
    else if (status == FSRefreshStatusNoMoreData)
    {
        self.textLabel.text = @"无更多数据";
    }
    
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
    CGFloat width = self.superview.bounds.size.width;
    
    CGRect newFrame = CGRectMake(0, -kHeaderHeight, width, kHeaderHeight);
    
    [super setFrame:newFrame];
}


- (void)scrollViewContentOffsetDidChange:(NSDictionary<NSKeyValueChangeKey,id> *)change
{
    UIScrollView *scrollView = (id)self.superview;
    
    if (![scrollView isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    CGFloat newOffsetY = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue].y;
    
    //    NSLog(@"newOffsetY = %f", newOffsetY);
    
    CGFloat top = [self scrollViewEdgeInsets:scrollView].top;
    
    //    NSLog(@"top = %f", top);
    
    CGFloat addi = top + newOffsetY;
    
    if (addi > 0)
    {
//        NSLog(@"向上滑动");
        
        return;
    }
    
    if (scrollView.isDragging)
    {
        if (ABS(addi) >= kHeaderHeight)
        {
            if (self.status == FSRefreshStatusIdle)
            {
                self.status = FSRefreshStatusWillRefresh;
            }
        }
        else
        {
            if (self.status == FSRefreshStatusWillRefresh)
            {
                self.status = FSRefreshStatusIdle;
            }
        }
    }
    else
    {
        if (self.status == FSRefreshStatusWillRefresh)
        {
            self.status = FSRefreshStatusRefreshing;
            
            __block UIEdgeInsets oldInsets = scrollView.contentInset;
            
            [UIView animateWithDuration:0.35 animations:^{
                oldInsets.top += kHeaderHeight;
                
                scrollView.contentInset = oldInsets;
            }];
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            
            self.showArrow = NO;
            
            [self.activityView startAnimating];
        }
    }
}

- (UIScrollView *)superScrollView
{
    if ([self.superview isKindOfClass:[UIScrollView class]])
    {
        return (id)self.superview;
    }
    
    return nil;
}

- (void)setShowArrow:(BOOL)showArrow
{
    _showArrow = showArrow;
    
    self.activityView.hidden = showArrow;
    
    [self setNeedsDisplay];
}


- (void)beginRefreshing
{
    UIScrollView *scrollView = (id)self.superview;
    
    if (![scrollView isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    self.status = FSRefreshStatusWillRefresh;
    
    scrollView.contentOffset = CGPointMake(0, -kHeaderHeight);
}

- (void)endRefreshing
{
    UIScrollView *scrollView = [self superScrollView];
    
    if (scrollView == nil) {
        return;
    }
    
    if (self.status != FSRefreshStatusRefreshing)
    {
        return;
    }
    
    if ([self.activityView isAnimating])
    {
        [self.activityView stopAnimating];
        
        self.showArrow = YES;
    }
    
    __block UIEdgeInsets oldInsets = scrollView.contentInset;
    
    [UIView animateWithDuration:.5 animations:^{
        
        oldInsets.top -= kHeaderHeight;
        
        scrollView.contentInset = oldInsets;
    }];
    
    self.status = FSRefreshStatusIdle;
}



- (void)drawRect:(CGRect)rect
{
    if (self.showArrow)
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGFloat top = 15;
        
        CGFloat x = self.activityView.center.x;
        
        [path moveToPoint:CGPointMake(x, top)];
        
        [path addLineToPoint:CGPointMake(x, kHeaderHeight - top)];
        
        [path addLineToPoint:CGPointMake(x - 5, kHeaderHeight - top - 5)];
        
        [path moveToPoint:CGPointMake(x, kHeaderHeight - top)];
        
        [path addLineToPoint:CGPointMake(x + 5, kHeaderHeight - top - 5)];
        
        path.lineCapStyle = kCGLineCapRound;
        
        path.lineJoinStyle = kCGLineJoinRound;
        
        [[UIColor lightGrayColor] setStroke];
        
        path.lineWidth = 2.5;
        
        [path stroke];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat activityWH = 30;
    
    CGFloat activityY = (kHeaderHeight - activityWH) * 0.5;
    
    CGFloat activityX = self.bounds.size.width * 0.5 - activityWH - 20;
    
    self.activityView.frame = CGRectMake(activityX, activityY, activityWH, activityWH);
    
    CGFloat labelX = self.bounds.size.width * 0.5 - 10;
    
    CGFloat labelY = 10;
    
    CGFloat labelW = self.bounds.size.width * 0.5 - 10;
    
    CGFloat labelH = (kHeaderHeight - labelY * 2);
    
    self.textLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}


- (void)dealloc
{
//    NSLog(@"%s", __func__);
}

@end
