//
//  FSController09.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/23.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController09.h"
#import "FSCollectionViewLayout.h"
#import "FSCollectionViewCell09.h"


@interface FSController09 ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation FSController09

static NSString * const kCellId = @"collection_cell_id";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect frame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    FSCollectionViewLayout *layout = [[FSCollectionViewLayout alloc] init];
    
    layout.itemSize = CGSizeMake(250, 250);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    self.collectionView = collectionView;
    
    collectionView.backgroundColor = [UIColor redColor];
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;
    
    [collectionView registerClass:[FSCollectionViewCell09 class] forCellWithReuseIdentifier:kCellId];
    
    [collectionView reloadData];
    
    [self.view addSubview:collectionView];
    
    NSLog(@"top = %f", collectionView.contentInset.top);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSLog(@"%f", self.collectionView.contentInset.top);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FSCollectionViewCell09 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    
    NSInteger index = indexPath.item % 3;
    
    NSString *imageName = [NSString stringWithFormat:@"09_%ld.jpg", index];
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    cell.image = image;
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"");
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"");
}

@end
