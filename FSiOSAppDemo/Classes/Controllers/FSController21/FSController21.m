//
//  FSController21.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController21.h"

@interface FSController21 ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSController21

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    [self.view addSubview:tableView];
    
    self.dataArray =
  @[@{@"title":@"认识图层CALayer", @"className":@"FSCAController01"},
    @{@"title":@"图层几何学", @"className":@"FSCAController02"},
    @{@"title":@"视觉效果", @"className":@"FSCAController03"},
    @{@"title":@"变换", @"className":@"FSCAController04"},
    @{@"title":@"专用图层", @"className":@"FSCAController05"},
    @{@"title":@"隐式动画", @"className":@"FSCAController06"},
    @{@"title":@"显式动画", @"className":@"FSCAController07"},
    @{@"title":@"keyFrame动画", @"className":@"FSCAController08"},
    @{@"title":@"过渡动画-TabBar", @"className":@"FSCAController09"},
    @{@"title":@"过渡动画-NavBar", @"className":@"FSCAController10"},
    @{@"title":@"自定义动画", @"className":@"FSCAController11"},
    @{@"title":@"缓冲动画", @"className":@"FSCAController12"},];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"animation_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *title = [dict objectForKey:@"title"];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];

    NSString *className = [dict objectForKey:@"className"];
    
    NSString *title = [dict objectForKey:@"title"];
    
    Class classObj = NSClassFromString(className);
    
    id obj = [[classObj alloc] init];
    
    [self.navigationController pushViewController:obj animated:YES];
    
    [obj setTitle:title];
}


@end
