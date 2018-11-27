//
//  FSImageContainer.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSImageContainer.h"
#import "FSImageScrollView.h"

@interface FSImageScrollView (Private)

- (void)setupScrollImage:(UIImage *)image;

@end

@interface FSImageContainer ()<UIScrollViewDelegate>
{
    NSInteger _index;
}

@property (nonatomic, strong) UIImage *hdImage;

@property (nonatomic, weak) FSImageScrollView *scrollView;

@end

@implementation FSImageContainer

- (instancetype)initWithHDImage:(UIImage *)hdImage
{
    if (self = [super init])
    {
        self.hdImage = hdImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FSImageScrollView *scrollView = [[FSImageScrollView alloc] init];
    
    self.scrollView = scrollView;
    
    scrollView.frame = self.view.bounds;
    
    [self.view addSubview:scrollView];
    
    self.scrollView.imageView.image = self.hdImage;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end

@implementation FSImageContainer (Private)

- (void)setIndex:(NSUInteger)index
{
    _index = index;
}

- (NSUInteger)index
{
    return _index;
}

@end
