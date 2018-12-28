//
//  FSSimpleRefreshExample.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSSimpleRefreshExample.h"
#import "FSRefreshHeader.h"


@interface FSSimpleRefreshExample ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSSimpleRefreshExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    FSRefreshHeader *header = [FSRefreshHeader new];
    
    [header addTarget:self action:@selector(beginRefreshAction:) forControlEvents:UIControlEventValueChanged];
    
    tableView.fs_refreshHeader = header;
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableView = tableView;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
//    [self demo01];
    
    [self demo02];
    
    [self.view addSubview:tableView];
    
    [header beginRefreshing];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
}

- (void)demo01
{
    self.tableView.frame = self.view.bounds;
}

- (void)demo02
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
}

- (void)beginRefreshAction:(FSRefreshHeader *)header
{
    NSLog(@"正在进行头部刷新......");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
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
    
//    self.tableView.frame = self.view.bounds;
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
    NSString *kCellId = NSStringFromClass([self class]);
    
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
