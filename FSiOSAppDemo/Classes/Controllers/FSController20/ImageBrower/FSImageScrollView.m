//
//  FSImageScrollView.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSImageScrollView.h"

static NSString * const kImagekey = @"image";

@interface FSImageScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FSImageScrollView

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
    self.delegate = self;
    
    if (@available(iOS 11, *)) {
     
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.multipleTouchEnabled = YES;
    self.showsVerticalScrollIndicator = YES;
    self.showsHorizontalScrollIndicator = YES;
    self.alwaysBounceVertical = YES;
    self.alwaysBounceHorizontal = NO;
    self.minimumZoomScale = 1;
    self.maximumZoomScale = 5;
    self.delegate = self;
    
    [self.imageView addObserver:self forKeyPath:kImagekey options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (![object isEqual:self.imageView] || ![keyPath isEqualToString:kImagekey])
    {
        return;
    }
    
    if (self.imageView.image == nil) {
        
        self.imageView.hidden = YES;
        
        return;
    }
    
    self.imageView.hidden = NO;
    
    [self setZoomScale:1.0 animated:YES];
    
    [self _updateFrame];
}

- (void)_updateFrame
{
    UIImage *image = self.imageView.image;
    
    if (image == nil) {
        return;
    }
    
    CGFloat selfW = CGRectGetWidth(self.frame);
    
    CGFloat selfH = CGRectGetHeight(self.frame);
    
    CGFloat needImageW = image.size.width;
    
    needImageW = MIN(selfW, needImageW);
    
    CGFloat ratio = needImageW / image.size.width;
    
    CGSize newSize = CGSizeMake(needImageW, ceilf(image.size.height * ratio));
    
    CGFloat x = (selfW - newSize.width) * 0.5;
    
    CGFloat y = 0;
    
    if (newSize.height < selfH)
    {
        y = (selfH - newSize.height) * 0.5;
    }
    
    self.imageView.frame = CGRectMake(x, y, newSize.width, newSize.height);
    
    self.contentSize = newSize;
}

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] init];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _imageView.clipsToBounds = YES;
        
        _imageView.backgroundColor = [UIColor redColor];
        
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void)dealloc
{
    [self.imageView removeObserver:self forKeyPath:kImagekey];
}

#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{    
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    CGRect rect = [self _resizeImageViewWithScrollView:scrollView];
    
    view.frame = rect;
    
    scrollView.contentSize = rect.size;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self _recenterImageWithScrollView:scrollView];
}

- (void)_recenterImageWithScrollView:(UIScrollView *)scrollView
{
    CGFloat contentWidth = scrollView.contentSize.width;
    CGFloat horizontalDiff = CGRectGetWidth(scrollView.bounds) - contentWidth;
    CGFloat horizontalAddition = horizontalDiff > 0.f ? horizontalDiff : 0.f;
    
    
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat verticalDiff = CGRectGetHeight(scrollView.bounds) - contentHeight;
    CGFloat verticalAdditon = verticalDiff > 0 ? verticalDiff : 0.f;
    
    self.imageView.center = CGPointMake((contentWidth + horizontalAddition) / 2.0f, (contentHeight + verticalAdditon) / 2.0f);
}

- (CGRect)_resizeImageViewWithScrollView:(UIScrollView *)scrollView
{
    CGFloat scrollW = scrollView.frame.size.width;
    
    CGFloat x = 0;
    
    CGFloat y = 0;
    
    if (scrollView.contentSize.width < scrollW)
    {
        x = (scrollW - scrollView.contentSize.width) * 0.5;
    }
    
    if (scrollView.contentSize.height < scrollView.frame.size.height)
    {
        y = (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5;
    }
    
    CGRect rect = CGRectMake(x, y, scrollView.contentSize.width, scrollView.contentSize.height);
    
    return rect;
}

@end
