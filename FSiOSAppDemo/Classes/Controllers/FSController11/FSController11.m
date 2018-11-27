//
//  FSController11.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController11.h"
#import "FS11PersonController.h"


@interface FSController11 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *datas;

@end

@implementation FSController11

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas = @[@"person_table",@"company_table"];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    tableView.frame = self.view.bounds;
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"11_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    
    NSString *text = [self.datas objectAtIndex:indexPath.row];
    
    cell.textLabel.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        FS11PersonController *controller = [[FS11PersonController alloc] init];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}


@end
