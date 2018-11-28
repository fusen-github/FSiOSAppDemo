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
    self.maximumZoomScale = 1.5f;
    self.delegate = self;
    
    [self _addObserver];
}

/**
 在present过程中会自动调用该方法，在该方法内更新frame
 */
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    
    [self _updateUserInterfaces];
}

- (void)_addObserver
{
    [self.imageView addObserver:self forKeyPath:kImagekey options:NSKeyValueObservingOptionNew context:nil];
}

- (void)_removeObserver
{
    [self.imageView removeObserver:self forKeyPath:kImagekey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (![object isEqual:self.imageView] || ![keyPath isEqualToString:kImagekey])
    {
        return;
    }
    
    if (self.imageView.image == nil) {
        return;
    }
    
    [self _updateUserInterfaces];
}

- (void)_updateUserInterfaces
{
    [self setZoomScale:1.0 animated:YES];
    
    [self _updateFrame];
    
    [self _recenterImage];
    
    [self _setMaximumZoomScale];
}

- (void)_updateFrame
{
    UIImage *image = self.imageView.image;
    
    if (image == nil) {
        return;
    }
    
    CGFloat selfW = CGRectGetWidth(self.frame);
    
    CGFloat needImageW = image.size.width / image.scale;
    
    needImageW = MIN(selfW, needImageW);
    
    CGFloat ratio = needImageW / image.size.width;
    
    CGSize newSize = CGSizeMake(needImageW, ceilf(image.size.height * ratio));
    
    [UIView animateWithDuration:0.1 animations:^{
        self.imageView.frame = CGRectMake(0, 0, newSize.width, newSize.height);
    }];
    
    self.contentSize = newSize;
}

- (void)_recenterImage
{
    CGFloat contentW = self.contentSize.width;
    
    CGFloat hDiff = self.bounds.size.width - contentW;
    
    hDiff = hDiff > 0 ? hDiff : 0;
    
    CGFloat contentH = self.contentSize.height;
    
    CGFloat vDiff = self.bounds.size.height - contentH;
    
    vDiff = vDiff > 0 ? vDiff : 0;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.imageView.center = CGPointMake((contentW + hDiff) * 0.5, (contentH + vDiff) * 0.5);
    }];
    
}

- (void)_setMaximumZoomScale
{
    CGSize imageSize = self.imageView.image.size;
    
    CGFloat selfWidth = CGRectGetWidth(self.bounds);
    
    CGFloat selfHeight = CGRectGetHeight(self.bounds);
    
    if (imageSize.width <= selfWidth && imageSize.height <= selfHeight)
    {
        self.maximumZoomScale = 1.5f;
    }
    else
    {
        CGFloat max = MAX(MIN(imageSize.width / selfWidth, imageSize.height / selfHeight), 3.0f);
        
        self.maximumZoomScale = max;
    }
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
    [self _removeObserver];
}

#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{    
    return self.imageView;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self _recenterImage];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale // scale between minimum and maximum. called after any 'bounce' animations
{
    [self _recenterImage];
}

@end
