//
//  FSController26.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController26.h"
#import "FSQQRefreshHeader.h"
#import "UIScrollView+Extention.h"


@interface FSController26 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) FSQQRefreshHeader *header;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSController26

/*
 A Boolean value that indicates whether the view controller should automatically adjust its scroll view insets.
 The default value of this property is YES, which lets container view controllers know that they should adjust the scroll view insets of this view controller’s view to account for screen areas consumed by a status bar, search bar, navigation bar, toolbar, or tab bar. Set this property to NO if your view controller implementation manages its own scroll view inset adjustments.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    FSQQRefreshHeader *header = [FSQQRefreshHeader new];

    [header addTarget:self action:@selector(beginRefreshAction:) forControlEvents:UIControlEventValueChanged];
    
    tableView.fs_refreshHeader = header;
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableView = tableView;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
//    tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
    
    [self.view addSubview:tableView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
}

- (void)beginRefreshAction:(FSQQRefreshHeader *)header
{
    NSLog(@"正在进行刷新......");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [header endRefreshing];
    });
}

- (void)doRightAction
{
    self.tableView.frame = CGRectMake(30, 100, self.view.width - 60, self.view.height - 100);
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
//    _tableView.contentOffset = CGPointMake(0, -100);
    
//    _tableView.contentInset = UIEdgeInsetsMake(54, 0, 0, 0);


    
//    self.tableView.center = self.view.center;
//    self.tableView.bounds = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *kCellId = NSStringFromClass([FSController26 class]);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"fs-%ld", (indexPath.row + 1)];
    
    return cell;
}


@end
