//
//  FSController20.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController20.h"
#import "FSPageViewController.h"
#import "FSFSTransitionControler.h"
#import "FSImageCollectionViewCell.h"
#import "FSImageItem.h"


@interface FSController20 ()<FSPageViewControllerDataSource, FSPageViewControllerDelegate, UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) FSFSTransitionControler *transitionController;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataArray;

@end

static NSString * const kCellId = @"controller20_cell_id";

@implementation FSController20

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(100, 100);
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    self.collectionView = collectionView;
    
    collectionView.dataSource = self;
    
    collectionView.delegate = self;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.alwaysBounceVertical = YES;
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[FSImageCollectionViewCell class] forCellWithReuseIdentifier:kCellId];
    
    NSMutableArray *tmpDatas = [NSMutableArray array];
    
    for (int i = 0; i < 11; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"%03d", i + 1];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        if (image == nil)
        {
            path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            
            image = [UIImage imageWithContentsOfFile:path];
        }
        
        if (image)
        {
//            image = [image resizeImageWithSize:CGSizeMake(100, 100)];
            
//            NSData *data = UIImageJPEGRepresentation(image, 0.6);
//
//            image = [UIImage imageWithData:data];
            
            CGFloat min = MIN(image.size.width, image.size.height);
            
            CGFloat scale = 100 / min;
            
            image = [self scaleImage:image forScale:scale];
            
            FSImageItem *item = [[FSImageItem alloc] initWithThumb:image path:path];
            
            [tmpDatas addObject:item];
        }
    }
    
    self.dataArray = tmpDatas;
}

- (UIImage *)scaleImage:(UIImage *)image forScale:(CGFloat)scale
{
    if (image == nil) {
        return nil;
    }
    
    CGFloat newW = ceilf(image.size.width * scale);
    
    CGFloat newH = ceilf(image.size.height * scale);
    
    CGSize newSize = CGSizeMake(newW, newH);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FSImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    
    FSImageItem *item = [self.dataArray objectAtIndex:indexPath.item];
    
    cell.imageView.image = item.thumbImage;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showImageBrower:indexPath];
}

- (void)showImageBrower:(NSIndexPath *)indexPath
{
    FSPageViewController *controller = [[FSPageViewController alloc] initWithNavigationOrientation:UIPageViewControllerNavigationOrientationHorizontal startIndex:indexPath.item];
    
    controller.dataSource = self;
    
    controller.delegate = self;
    
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    FSFSTransitionControler *obj = [[FSFSTransitionControler alloc] initWithEmployer:controller];
    
    self.transitionController = obj;
    
    controller.transitioningDelegate = obj;
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark <FSPageViewControllerDataSource>

- (NSUInteger)numberOfPagesInViewController:(FSPageViewController *)controller
{
    return self.dataArray.count;
}

- (UIImage *)viewController:(FSPageViewController *)controller imageForPageAtIndex:(NSUInteger)index
{
    FSImageItem *item = [self.dataArray objectAtIndex:index];
    
    @autoreleasepool {
        
        UIImage *image = [UIImage imageWithContentsOfFile:item.imagePath];
        
        /// B
        unsigned long long size = image.size.width * image.size.height * 4;
        
        unsigned long long max = 5 * 1024 * 1024;
        
        if (size > max)
        {
            CGFloat ratio = (max * 1.0) / (size * 1.0);
            
            NSData *data = UIImageJPEGRepresentation(image, ratio);
            
            image = [UIImage imageWithData:data];
        }
        
        return image;
    }
}

- (UIView *)thumbViewForPageAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    FSImageCollectionViewCell *cell = (id)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    return cell.imageView;
}

#pragma mark <FSPageViewControllerDelegate>


@end


