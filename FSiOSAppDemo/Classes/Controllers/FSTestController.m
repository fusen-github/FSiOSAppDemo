//
//  FSTestController.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSTestController.h"

@interface FSTestController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation FSTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    scrollView.alwaysBounceHorizontal = NO;
    
    self.scrollView = scrollView;
    
    scrollView.backgroundColor = [UIColor redColor];
    
    scrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    scrollView.delegate = self;
    
    scrollView.minimumZoomScale = 1;
    
    scrollView.maximumZoomScale = 6;
    
    [self.view addSubview:scrollView];
    
    UIImage *image = [UIImage imageNamed:@"005.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    self.imageView = imageView;
    
    imageView.backgroundColor = [UIColor greenColor];
    
    imageView.image = image;
    
    imageView.frame = [self imageViewFrameWithImage:image scrollView:scrollView];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [scrollView addSubview:imageView];
    
    scrollView.contentSize = imageView.bounds.size;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"");
}

- (void)doRightAction
{
    [self.scrollView setZoomScale:1 animated:NO];
}

- (CGRect)imageViewFrameWithImage:(UIImage *)image scrollView:(UIScrollView *)scrollView
{
    CGFloat zoomScale = scrollView.zoomScale;
    
    CGFloat scrollW = scrollView.frame.size.width * zoomScale;

    CGSize imageViewSize = CGSizeZero;

    if (scrollW < image.size.width)
    {
        CGFloat ratio = scrollW / image.size.width;

        CGFloat imagViewH = ratio * image.size.height;

        imageViewSize = CGSizeMake(scrollW, imagViewH);
    }
    else
    {
        imageViewSize = image.size;
    }

    CGFloat x = (scrollW - imageViewSize.width) * 0.5;

    CGFloat y = 0;

    if (scrollView.bounds.size.height > imageViewSize.height)
    {
        y = (scrollView.bounds.size.height - imageViewSize.height) * 0.5;
    }

    CGRect frame = CGRectMake(x, y, imageViewSize.width, imageViewSize.height);
    
    return frame;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    CGRect rect = [self resizeImageViewWithScrollView:scrollView];
    
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
    CGFloat horizontalDiff = CGRectGetWidth(self.scrollView.bounds) - contentWidth;
    CGFloat horizontalAddition = horizontalDiff > 0.f ? horizontalDiff : 0.f;
    
    
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat verticalDiff = CGRectGetHeight(self.scrollView.bounds) - contentHeight;
    CGFloat verticalAdditon = verticalDiff > 0 ? verticalDiff : 0.f;
    
    self.imageView.center = CGPointMake((contentWidth + horizontalAddition) / 2.0f, (contentHeight + verticalAdditon) / 2.0f);
}

- (CGRect)resizeImageViewWithScrollView:(UIScrollView *)scrollView
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
