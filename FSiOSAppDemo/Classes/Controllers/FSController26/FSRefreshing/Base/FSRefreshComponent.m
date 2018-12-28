//
//  FSRefreshComponent.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSRefreshComponent.h"
#import <objc/runtime.h>

static CGFloat const kHeaderHeight = 54;

static NSString * const kUIScrollViewContentOffsetKey = @"contentOffset";

@interface FSRefreshComponent ()

@property (nonatomic, assign) FSRefreshStatus status;

@end

@implementation FSRefreshComponent

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

- (void)removeObserver
{
    if ([self.superview isKindOfClass:[UIScrollView class]])
    {
        [self.superview removeObserver:self forKeyPath:kUIScrollViewContentOffsetKey];
    }
}

- (UIEdgeInsets)scrollViewEdgeInsets:(UIScrollView *)scrollView
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    
    if (scrollView == nil) {
        return edgeInsets;
    }
    
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
    if ([keyPath isEqualToString:kUIScrollViewContentOffsetKey])
    {
        [self scrollViewContentOffsetDidChange:change];
    }
    
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
    
    if (self.status == FSRefreshStatusRefreshing)
    {
        
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
            
//            self.showArrow = NO;
//
//            [self.activityView startAnimating];
        }
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary<NSKeyValueChangeKey,id> *)change
{
    /// 父类 空实现
}

@end


@implementation UIScrollView (FSRefresh)

- (void)setFs_refreshHeader:(UIView *)fs_refreshHeader
{
    UIView *oldHeader = self.fs_refreshHeader;
    
    if ([oldHeader isEqual:fs_refreshHeader]) {
        return;
    }
    
    [oldHeader removeFromSuperview];
    
    objc_setAssociatedObject(self, @selector(fs_refreshHeader), fs_refreshHeader, OBJC_ASSOCIATION_ASSIGN);
    
    [self insertSubview:fs_refreshHeader atIndex:0];
}

- (UIView *)fs_refreshHeader
{
    UIView *header = objc_getAssociatedObject(self, @selector(fs_refreshHeader));
    
    return header;
}

@end
