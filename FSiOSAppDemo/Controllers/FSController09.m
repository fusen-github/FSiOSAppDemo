//
//  FSController09.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/23.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController09.h"

@interface FSController09 ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation FSController09

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.bounds;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
