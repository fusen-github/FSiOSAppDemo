//
//  FSDetailController01.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/16.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSDetailController01.h"
#import "FSRoundedCornerCell.h"
#import "FSDetailController02.h"


@interface FSDetailController01 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSDetailController01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    tableView.frame = self.view.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    tableView.tableHeaderView = [UIView new];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellId = @"masterControllerCellId";
    
    FSRoundedCornerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[FSRoundedCornerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld组 - %ld行",(indexPath.section + 1),(indexPath.row + 1)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cornerValue = 6;
    
    CGSize cornerSize = CGSizeMake(cornerValue, cornerValue);
    
    NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
    
    NSInteger lastIndex = rowCount - 1;
    
    UIBezierPath *path = nil;
    
    /// 既是组内第一行、又是组内最后一行（该分组只有一行）
    if (rowCount == 1)
    {
        UIRectCorner rectCorner = UIRectCornerAllCorners;
        
        path = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:rectCorner cornerRadii:cornerSize];
    }
    else if (indexPath.row == 0)
    {
        UIRectCorner rectCorner = UIRectCornerTopLeft | UIRectCornerTopRight;
        
        path = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:rectCorner cornerRadii:cornerSize];
    }
    else if (indexPath.row == lastIndex)
    {
        UIRectCorner rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        
        path = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:rectCorner cornerRadii:cornerSize];
    }
    
    if (path)
    {
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        layer.frame = cell.bounds;
        
        layer.path = path.CGPath;
        
        cell.layer.mask = layer;
    }
    else
    {
        cell.layer.mask = nil;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
