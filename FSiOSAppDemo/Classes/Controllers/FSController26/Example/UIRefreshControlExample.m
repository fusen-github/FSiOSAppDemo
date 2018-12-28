//
//  UIRefreshControlExample.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "UIRefreshControlExample.h"

@interface UIRefreshControlExample ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation UIRefreshControlExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.frame = self.view.bounds;
    
    self.tableView = tableView;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    //    tableView.contentInset = UIEdgeInsetsMake(54, 0, 0, 0);
    
    [self.view addSubview:tableView];
    
    NSLog(@"%@", tableView.refreshControl);
    
    UIRefreshControl *control = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    control.backgroundColor = [UIColor redColor];
    
    [control addTarget:self action:@selector(needToRefresh:) forControlEvents:UIControlEventValueChanged];
    
    tableView.refreshControl = control;
    
    //    tableView.contentOffset = CGPointMake(0, -300);
    
    //    [control beginRefreshing];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
}

- (void)doRightAction
{
    [self.tableView.refreshControl beginRefreshing];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //    self.tableView.refreshControl.frame = CGRectMake(0, 0, 200, 200);
}

- (void)needToRefresh:(UIRefreshControl *)control
{
    NSLog(@"%s", __func__);
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"fs-%tu", (indexPath.row + 1)];
    
    return cell;
}

@end
