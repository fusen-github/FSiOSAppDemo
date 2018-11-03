//
//  FSController17.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController17.h"



@interface FSController17 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSController17

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.frame = self.view.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    [self.view addSubview:tableView];
    
    self.dataArray = @[@{@"title":@"Socket体验1",@"className":@"FSSocket1"},
                       @{@"title":@"Socket体验2",@"className":@"FSSocket2"},];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socket_cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socket_cell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];

    NSString *className = [dict objectForKey:@"className"];
    
    Class ClassObj = NSClassFromString(className);
    
    if (ClassObj == nil)
    {
        return;
    }
    
    id obj = [[ClassObj alloc] init];
    
    [self.navigationController pushViewController:obj animated:YES];
}


@end
