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
#import <Photos/Photos.h>
#import "UIImageView+WebCache.h"


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
            imageName = [imageName stringByAppendingString:@"@2x.png"];
            
            path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
            
            image = [UIImage imageWithContentsOfFile:path];
        }
        
        if (image)
        {
            CGFloat min = MIN(image.size.width, image.size.height);
            
            CGFloat base = 100 * image.scale;
            
            base = 100;
            
            CGFloat scale = base / min;
            
            image = [self scaleImage:image forScale:scale];
            
            if (image.size.height > 300)
            {
                CGFloat needWH = image.size.width * image.scale;
                
                CGRect needRect = CGRectMake(0, 0, needWH, needWH);
                
                CGImageRef cgImageRef = CGImageCreateWithImageInRect(image.CGImage,needRect);
                
                image = [UIImage imageWithCGImage:cgImageRef];
                
                CGImageRelease(cgImageRef);
            }
            
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
        
        unsigned long long max = 2 * 1024 * 1024;
        
        if (size > max)
        {
            CGFloat ratio = (max * 1.0) / (size * 1.0);
            
            NSData *data = UIImageJPEGRepresentation(image, ratio);
            
            NSLog(@"ratio = %lf, len = %tu",ratio, data.length);
            
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

//- (void)viewController:(FSPageViewController *)controller presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler
//{
//    [imageView sd_setImageWithURL:nil
//                 placeholderImage:nil
//                          options:0
//                         progress:^(NSInteger received, NSInteger expected, NSURL *targetURL) {
//                             
//                             
//                             
//                         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL * imageURL) {
//                             
//                             
//                         }];
//}


#pragma mark <FSPageViewControllerDelegate>
- (void)viewController:(FSPageViewController *)controller singleTapAtIndex:(NSUInteger)index presentedImage:(UIImage *)image
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(FSPageViewController *)controller longPressAtIndex:(NSUInteger)index presentedImage:(UIImage *)image
{
    NSString *title = @"Title";
    
    NSString *message = @"Message";
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self saveImageToSystemPhotoApp:image];
    }];
    
    [sheet addAction:save];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
        NSLog(@"cancel");
    }];
    
    [sheet addAction:cancel];
    
    [controller presentViewController:sheet animated:YES completion:nil];
}

- (void)saveImageToSystemPhotoApp:(UIImage *)image
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusAuthorized)
    {
        [self authorizedOperatePhotoApp];
    }
    else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted)
    {
        [self deniedOperatePhototApp];
    }
    else if (status == PHAuthorizationStatusNotDetermined)
    {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
               
                if (status == PHAuthorizationStatusAuthorized)
                {
                    [self authorizedOperatePhotoApp];
                }
                else if (status == PHAuthorizationStatusDenied)
                {
                    [self deniedOperatePhototApp];
                }
            });
        }];
    }
}

- (void)authorizedOperatePhotoApp
{
    PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
    
    
}

- (void)deniedOperatePhototApp
{
    NSLog(@"%s",__func__);
}

@end


