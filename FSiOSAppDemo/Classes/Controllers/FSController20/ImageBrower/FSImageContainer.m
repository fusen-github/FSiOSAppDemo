//
//  FSImageContainer.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSImageContainer.h"
#import "FSImageScrollView.h"

typedef void(^ProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

@interface FSImageContainer ()<UIScrollViewDelegate>
{
    NSInteger _index;
}

/**
 占位图片
 */
@property (nonatomic, strong) UIImage *phImage;

@property (nonatomic, weak) FSImageScrollView *scrollView;

@property (nonatomic, copy) void(^progressBlock)(UIImageView *imageView, ProgressBlock progress);

@end

@implementation FSImageContainer

- (instancetype)initWithPlaceholdImage:(UIImage *)phImage
{
    if (self = [super init])
    {
        self.phImage = phImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FSImageScrollView *scrollView = [[FSImageScrollView alloc] init];
    
    self.scrollView = scrollView;
    
    scrollView.frame = self.view.bounds;
    
    [self.view addSubview:scrollView];
    
    self.scrollView.imageView.image = self.phImage;
    
    if (self.progressBlock)
    {
        UIImageView *imageView = self.scrollView.imageView;
        
        self.progressBlock(imageView, ^(NSInteger receivedSize, NSInteger expectedSize) {
            
            CGFloat value = (receivedSize * 1.0) / (expectedSize * 1.0);
            
            NSLog(@"progress = %.2f", value);
            
        });
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
}

- (void)setupLoadImageHandle:(void (^)(UIImageView *imageView, void (^progressBlock)(NSInteger receivedSize, NSInteger expectedSize) ))handle
{
    self.progressBlock = handle;
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
