//
//  FSMasterController.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/16.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSMasterController.h"
#import "FSDetailController01.h"
#import "FSDetailController02.h"
#import "FSDetailController03.h"
#import "FSMasterSearchResultController.h"



@interface FSMasterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIView *rightLine;

@property (nonatomic, strong) NSDictionary *cellSelectedDict;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSMasterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Master";
    
    if (@available(iOS 11.0, *))
    {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        
        NSMutableDictionary *largeTitleTextAttributes = [NSMutableDictionary dictionary];
        
        [largeTitleTextAttributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        
        self.navigationController.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes;
        
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
        
        FSMasterSearchResultController *searchResultController = [[FSMasterSearchResultController alloc] init];
        
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultController];
        
        self.navigationItem.searchController = searchController;
        
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    }
    
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    tableView.frame = self.view.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:tableView];
    
    UIView *rightLine = [[UIView alloc] init];
    
    self.rightLine = rightLine;
    
    rightLine.backgroundColor = UIColorFromRGB(0x8E8E93);
    
    [self.navigationController.view addSubview:rightLine];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (id item in self.dataArray)
    {
        NSInteger index = [self.dataArray indexOfObject:item];
        
        [dict setObject:@(NO) forKey:@(index)];
    }
    
    self.cellSelectedDict = dict;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.hidesSearchBarWhenScrolling = YES;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat width = self.view.bounds.size.width;
    
    CGFloat height = self.view.bounds.size.height;
    
    CGFloat lineW = 0.5;
    
    self.tableView.frame = self.view.bounds;

    self.rightLine.frame = CGRectMake(width - lineW, 0, lineW, height);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellId = @"masterControllerCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BOOL selected = [[self.cellSelectedDict objectForKey:@(indexPath.row)] boolValue];
    
    if (!selected)
    {
        cell.textLabel.textColor = [UIColor darkTextColor];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.contentView.backgroundColor = UIColorFromRGB(0xD7D7D7);
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"fs - %ld",(indexPath.row + 1)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL state = [[self.cellSelectedDict objectForKey:@(indexPath.row)] boolValue];
    
    if (state)
    {
        return;
    }
    
    NSDictionary *dict = @{@(1):@"FSDetailController01",
                           @(2):@"FSDetailController02",
                           @(3):@"FSDetailController03",};
    
    NSString *className = [dict objectForKey:@(indexPath.row + 1)];
    
    if (![className isKindOfClass:[NSString class]])
    {
        return;
    }
    
    Class classObj = NSClassFromString(className);
    
    if (classObj == nil)
    {
        return;
    }
    
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.cellSelectedDict];
    
    for (id key in tmpDict.allKeys)
    {
        [tmpDict setObject:@(NO) forKey:key];
    }
    
    [tmpDict setObject:@(YES) forKey:@(indexPath.row)];
    
    self.cellSelectedDict = tmpDict;
    
    [self.tableView reloadData];
         
    id obj = [[classObj alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    
    if ([self.delegate respondsToSelector:@selector(master:wantToShowViewController:)])
    {
        [self.delegate master:self wantToShowViewController:nav];
    }
}

@end
