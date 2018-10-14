//
//  FSController10.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController10.h"
#import <UserNotifications/UserNotifications.h>
#import "FS10CollectionViewCell.h"
#import "FS10ColletionItem.h"



static NSString * const kCellId = @"cellId";

@interface FSController10 ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableString *secondString;

@end

@implementation FSController10

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     copy属性和可变对象的测试
     1、可变对象执行copy，会产生新对象。
     2、修改数组中变量的指针指向，不会影响到数组中的对象
     */
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    NSString *first = @"first";
    
    FS10ColletionItem *item = [[FS10ColletionItem alloc] initWithTitle:first];
    
    [tmpArray addObject:item];
    
    NSMutableString *second = [@"second" mutableCopy];
    
    self.secondString = second;
    
    item = [[FS10ColletionItem alloc] initWithTitle:second];
    
    [tmpArray addObject:item];
    
    self.dataArray = tmpArray;
    
//    NSMutableString *last = nil;
//
//    if ([tmpArray.lastObject isKindOfClass:[NSMutableString class]])
//    {
//        last = tmpArray.lastObject;
//    }
//
//    [last appendString:@"sen"];
//
//    last = [NSMutableString stringWithFormat:@"123456"];
//
//    first = @"fistName";
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(self.view.bounds.size.width, 44);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    self.collectionView = collectionView;
    
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    collectionView.dataSource = self;
    
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[FS10CollectionViewCell class] forCellWithReuseIdentifier:kCellId];
    
    collectionView.alwaysBounceVertical = YES;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"11" style:UIBarButtonItemStylePlain target:self action:@selector(doAction11)];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"22" style:UIBarButtonItemStylePlain target:self action:@selector(doAction22)];
    
    self.navigationItem.rightBarButtonItems = @[item1, item2];
    
//    [tmpArray isEqualToArray:<#(nonnull NSArray *)#>]
    
    NSDictionary *dict = nil;
    
//    [dict isEqualToDictionary:<#(nonnull NSDictionary *)#>]
}

- (void)doAction11
{
    
}

- (void)doAction22
{
    [self.secondString appendString:@"。。。。。。"];
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FS10CollectionViewCell *cell = (id)[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    
    FS10ColletionItem *item = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.desc = item.title;
    
    return cell;
}


@end
