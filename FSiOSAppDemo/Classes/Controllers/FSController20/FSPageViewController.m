//
//  FSPageController.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSPageViewController.h"
#import "FSImageContainer.h"

@interface FSImageContainer (Private)

- (void)setIndex:(NSUInteger)index;

- (NSUInteger)index;

- (void)setupLoadImageHandle:(void (^)(UIImageView *imageView, void (^progressBlock)(NSInteger receivedSize, NSInteger expectedSize) ))handle;

@end

@interface FSPageViewController (Extention)

- (void)_addGestureRecognizer;

@end

@interface FSPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, assign) UIPageViewControllerNavigationOrientation navigationOrientation;

@property (nonatomic, assign) NSUInteger numberOfPages;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, weak) UIView *pageIndicator;

@property (nonatomic, weak) FSImageContainer *currentContainer;

@property (nonatomic, assign) CGRect toFrame;

@property (nonatomic, weak) UIPageViewController *pageViewController;

@end

@implementation FSPageViewController

- (instancetype)initWithNavigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation
                                   startIndex:(NSUInteger)index
{
    if (self = [super init])
    {
        self.navigationOrientation = navigationOrientation;
        
        self.currentIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.numberOfPages = [self _getNumberOfPages];
    
    if (self.currentIndex >= self.numberOfPages)
    {
        [NSException raise:@"start index 超过了总页数" format:@""];
    }
    
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    [options setObject:@(20) forKey:UIPageViewControllerOptionInterPageSpacingKey];
    
    UIPageViewController *pageController =
    [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:self.navigationOrientation options:options];
    
    self.pageViewController = pageController;
    
    pageController.dataSource = self;
    
    pageController.delegate = self;
    
    [self addChildViewController:pageController];
    
    pageController.view.frame = self.view.bounds;
    
    [self.view addSubview:pageController.view];
    
    FSImageContainer *initContainer = [self imageContainerWithIndex:self.currentIndex];
    
    [pageController setViewControllers:@[initContainer]
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO completion:nil];
    
    [self _setupPageIndicator];
    
    [self _addGestureRecognizer];
}

- (FSImageContainer *)currentContainer
{
    return self.pageViewController.viewControllers.firstObject;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self updatePageIndicator];
}

- (void)_setupPageIndicator
{
    if (self.numberOfPages <= 1)
    {
        return;
    }
    
    if (self.numberOfPages <= 9)
    {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        
        pageControl.numberOfPages = self.numberOfPages;
        
        pageControl.currentPage = self.currentIndex;
        
        pageControl.pageIndicatorTintColor = [UIColor blueColor];
        
        self.pageIndicator = pageControl;
    }
    else
    {
        UILabel *indicatorLabel = [UILabel new];
        
        indicatorLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        
        indicatorLabel.textAlignment = NSTextAlignmentCenter;
        
        indicatorLabel.textColor = [UIColor whiteColor];
        
        self.pageIndicator = indicatorLabel;
    }
    
    self.pageIndicator.layer.zPosition = 1024;
    
//    self.pageIndicator.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.pageIndicator];
}

- (void)updatePageIndicator
{
    if ([self.pageIndicator isKindOfClass:[UIPageControl class]])
    {
        UIPageControl *pageControl = (id)self.pageIndicator;
        
        pageControl.numberOfPages = self.numberOfPages;
        
        pageControl.currentPage = self.currentIndex;
    }
    else if ([self.pageIndicator isKindOfClass:[UILabel class]])
    {
        UILabel *indicatorLabel = (UILabel *)self.pageIndicator;
        
        NSString *title = [NSString stringWithFormat:@"%tu/%tu",self.currentIndex + 1, self.numberOfPages];
        
        indicatorLabel.text = title;
    }
    
    [self.pageIndicator sizeToFit];
    
    self.pageIndicator.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height - self.pageIndicator.bounds.size.height);
}

/**
 获取一共有多少页
 */
- (NSInteger)_getNumberOfPages
{
    return [self.dataSource numberOfPagesInViewController:self];
}

#pragma mark UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    @autoreleasepool {
        
        NSUInteger index = NSNotFound;
        
        if ([viewController isKindOfClass:[FSImageContainer class]])
        {
            index = [(FSImageContainer *)viewController index];
        }
        
        FSImageContainer *newContainer = [self imageContainerWithIndex:index - 1];
        
        return newContainer;
    }
}


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    @autoreleasepool {
        
        NSUInteger index = NSNotFound;
        
        if ([viewController isKindOfClass:[FSImageContainer class]])
        {
            index = [(FSImageContainer *)viewController index];
        }
        
        FSImageContainer *newContainer = [self imageContainerWithIndex:index + 1];
        
        return newContainer;
    }
}


- (FSImageContainer *)imageContainerWithIndex:(NSInteger)index
{
    if (index < 0 || index >= self.numberOfPages)
    {
        return nil;
    }
    
    if (!self.dataSource)
    {
        [NSException raise:@"Must implement `FSPageViewControllerDataSource` protocol." format:@""];
    }
    
    FSImageContainer *container = nil;
    
    if ([self.dataSource respondsToSelector:@selector(viewController:imageForPageAtIndex:)])
    {
        UIImage *image = [self.dataSource viewController:self imageForPageAtIndex:index];

        container = [[FSImageContainer alloc] initWithHDImage:image];
    }
    else if ([self.dataSource respondsToSelector:@selector(viewController:presentImageView:forPageAtIndex:progressHandler:)])
    {
        container = [[FSImageContainer alloc] initWithHDImage:nil];
        
        __weak typeof(self) weak_self = self;
        
        [container setupLoadImageHandle:^(UIImageView *imageView, void (^progressBlock)(NSInteger receivedSize, NSInteger expectedSize)) {
           
            __strong typeof(weak_self) strong_self = weak_self;
            
            [strong_self.dataSource viewController:strong_self presentImageView:imageView forPageAtIndex:index progressHandler:progressBlock];
        }];
    }

    [container setIndex:index];
    
    return container;
}

#pragma mark <UIPageViewControllerDelegate>
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *topViewController = pageViewController.viewControllers.lastObject;
    
    if ([topViewController isKindOfClass:[FSImageContainer class]])
    {
        self.currentIndex = [(FSImageContainer *)topViewController index];
        
        [self updatePageIndicator];
    }
}


#pragma mark 懒加载
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end

@implementation FSPageViewController (GestureRecognized)

- (void)_addGestureRecognizer
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    
    doubleTap.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:doubleTap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handelLongPress:)];
    
    [self.view addGestureRecognizer:longPress];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:longPress];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(viewController:singleTapAtIndex:presentedImage:)])
    {
        UIImage *image = self.currentContainer.scrollView.imageView.image;
        
        [self.delegate viewController:self singleTapAtIndex:self.currentIndex presentedImage:image];
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tapGesture
{
    
}

- (void)handelLongPress:(UILongPressGestureRecognizer *)longPresss
{
    if ([self.delegate respondsToSelector:@selector(viewController:longPressAtIndex:presentedImage:)])
    {
        UIImage *image = self.currentContainer.scrollView.imageView.image;
        
        [self.delegate viewController:self longPressAtIndex:self.currentIndex presentedImage:image];
    }
}

@end

@implementation FSPageViewController (Private)

- (void)p_willPresentFromView:(UIView *)fromView toView:(UIView *)toView
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    FSImageContainer *currentContain = self.currentContainer;

    UIView *thumbView = [self currentThumbView];
    
    CGRect convertRect = [thumbView.superview convertRect:thumbView.frame toView:self.view];
    
    UIImageView *scrollImageView = currentContain.scrollView.imageView;
    
    self.toFrame = scrollImageView.frame;
    
    scrollImageView.frame = convertRect;
    
    scrollImageView.clipsToBounds = thumbView.contentMode;
    
    scrollImageView.contentMode = thumbView.contentMode;
}

- (void)p_isPresentingFromView:(UIView *)fromView toView:(UIView *)toView
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    
    FSImageContainer *currentContain = self.currentContainer;

    UIImageView *scrollImageView = currentContain.scrollView.imageView;

    scrollImageView.frame = self.toFrame;
}

- (void)p_didPresentFromView:(UIView *)fromView toView:(UIView *)toView
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
}


- (void)p_willDismissFromView:(UIView *)fromView toView:(UIView *)toView
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    
    UIImageView *scrollImageView = self.currentContainer.scrollView.imageView;
    
    /// 停止动画
    NSArray *array = scrollImageView.image.images;
    
    UIImage *first = scrollImageView.image;
    
    if (array.count > 1)
    {
        first = array.firstObject;
    }
    
    UIView *thumbView = [self currentThumbView];

    scrollImageView.image = first;

    [self.currentContainer.scrollView setZoomScale:1 animated:NO];
    
    scrollImageView.contentMode = UIViewContentModeScaleToFill;

    scrollImageView.clipsToBounds = thumbView.clipsToBounds;
    
    CGRect toFrame = [thumbView.superview convertRect:thumbView.frame toView:self.view];

    self.toFrame = toFrame;
}

- (void)p_isDismissingFromView:(UIView *)fromView toView:(UIView *)toView
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

    UIImageView *imageView = self.currentContainer.scrollView.imageView;

    imageView.frame = self.toFrame;
}

- (void)p_didDismissFromView:(UIView *)fromView toView:(UIView *)toView
{
    [self currentThumbView].hidden = NO;
}

- (UIView *)currentThumbView
{
    if (!self.dataSource) {
        return nil;
    }
    
    if ([self.dataSource respondsToSelector:@selector(thumbViewForPageAtIndex:)])
    {
        return [self.dataSource thumbViewForPageAtIndex:self.currentIndex];
    }
    
    return nil;
}

@end
