//
//  FSController23.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/18.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController23.h"
#import "AFHTTPSessionManager.h"
#import "FSNewsItem.h"
#import "FSCell23.h"


@interface FSController23 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSController23

// https://api.myjson.com/bins/177pio

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    __weak typeof(self) weakSelf = self;
//
//    [[AFHTTPSessionManager manager] GET:@"https://api.myjson.com/bins/177pio" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        [weakSelf recivedNews:responseObject];
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//        NSLog(@"error");
//    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"json"];
    
    NSArray *jsonArray = [NSArray arrayWithContentsOfFile:path];
    
    [self recivedNews:jsonArray];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.frame = self.view.bounds;
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 50;
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:tableView];
}

- (void)recivedNews:(NSArray *)responseObject
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSDictionary *dict in responseObject)
    {
        FSNewsItem *item = [FSNewsItem itemWithJson:dict];
        
        [tmpArray addObject:item];
    }
    
    self.dataArray = tmpArray;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"test_cell_id";
    
    FSCell23 *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[FSCell23 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
    }
    
    cell.item = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}



@end
