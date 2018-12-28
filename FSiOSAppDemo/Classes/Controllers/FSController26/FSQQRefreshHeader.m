//
//  FSQQRefreshHeader.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSQQRefreshHeader.h"

static CGFloat const kHeaderHeight = 54;

static NSString * const kUIScrollViewContentBoundsKey = @"bounds";

static NSString * const kUIScrollViewContentFrameKey = @"frame";

static NSString * const kUIScrollViewContentOffsetKey = @"contentOffset";

static NSString * const kUIScrollViewContentSizeKey = @"contentSize";

typedef NS_ENUM(NSInteger, FSQQRefreshStatus){
 
    /* 闲置状态 */
    FSQQRefreshStatusIdle,
    /* 即将刷新的状态(松手立即刷新) */
    FSQQRefreshStatusWillRefresh,
    /* 正在刷新状态 */
    FSQQRefreshStatusRefreshing,
    /* 没有更多数据的状态 */
    FSQQRefreshStatusNoMoreData,
    
};

@interface FSQQRefreshHeader ()

@property (nonatomic, assign) FSQQRefreshStatus status;

@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, weak) UIActivityIndicatorView *activityView;

@property (nonatomic, assign) BOOL showArrow;

@end

@implementation FSQQRefreshHeader

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
        
        self.status = FSQQRefreshStatusIdle;
    }
    return self;
}

- (void)setStatus:(FSQQRefreshStatus)status
{
    _status = status;
    
    if (status == FSQQRefreshStatusIdle)
    {
        self.textLabel.text = @"下拉刷新";
    }
    else if (status == FSQQRefreshStatusWillRefresh)
    {
        self.textLabel.text = @"松开立即刷新";
    }
    else if (status == FSQQRefreshStatusRefreshing)
    {
        self.textLabel.text = @"正在刷新......";
    }
    else if (status == FSQQRefreshStatusNoMoreData)
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

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview)
    {
        if ([newSuperview isKindOfClass:[UIScrollView class]])
        {
            [self addObserverWithSuperView:newSuperview];
        }
    }
    else
    {
        [self removeObserver];
    }
}

- (void)addObserverWithSuperView:(UIView *)superView
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    
    [superView addObserver:self forKeyPath:kUIScrollViewContentOffsetKey options:options context:nil];
}

- (UIEdgeInsets)scrollViewEdgeInsets:(UIScrollView *)scrollView
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    
    if (@available(iOS 11.0, *))
    {
        edgeInsets = scrollView.adjustedContentInset;
    }
    else
    {
        edgeInsets = scrollView.contentInset;
    }
    
    return edgeInsets;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    UIScrollView *scrollView = (id)self.superview;
    
    if (![scrollView isKindOfClass:[UIScrollView class]])
    {
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
    
    if (self.status == FSQQRefreshStatusRefreshing)
    {
        
    }
    
    if (scrollView.isDragging)
    {
        if (ABS(addi) >= kHeaderHeight)
        {
            if (self.status == FSQQRefreshStatusIdle)
            {
                self.status = FSQQRefreshStatusWillRefresh;
            }
        }
        else
        {
            if (self.status == FSQQRefreshStatusWillRefresh)
            {
                self.status = FSQQRefreshStatusIdle;
            }
        }
    }
    else
    {
        if (self.status == FSQQRefreshStatusWillRefresh)
        {
            self.status = FSQQRefreshStatusRefreshing;
            
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

- (void)endRefreshing
{
    UIScrollView *scrollView = [self superScrollView];
    
    if (scrollView == nil) {
        return;
    }
    
    if (self.status != FSQQRefreshStatusRefreshing)
    {
        return;
    }
    
    if ([self.activityView isAnimating])
    {
        [self.activityView stopAnimating];
        
        self.showArrow = YES;
    }
    
    __block UIEdgeInsets oldInsets = scrollView.contentInset;

    [UIView animateWithDuration:.75 animations:^{
        
        oldInsets.top -= kHeaderHeight;
        
        scrollView.contentInset = oldInsets;
    }];
    
    self.status = FSQQRefreshStatusIdle;
}

- (void)removeObserver
{
    if ([self.superview isKindOfClass:[UIScrollView class]])
    {
        [self.superview removeObserver:self forKeyPath:kUIScrollViewContentOffsetKey];
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.showArrow)
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGFloat top = 13;
        
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
    NSLog(@"%s", __func__);
}

@end
