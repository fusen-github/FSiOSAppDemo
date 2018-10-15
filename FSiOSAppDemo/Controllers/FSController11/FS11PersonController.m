//
//  FS11PersonController.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FS11PersonController.h"
#import "FSRoleDBManager.h"


@interface FS11PersonController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FS11PersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareDatas];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"person";
    
    UIView *toolBar = [self setupToolBar];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.frame = CGRectMake(0, toolBar.maxY, self.view.width, self.view.height - toolBar.maxY);
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    self.tableView = tableView;
    
    [self.view addSubview:tableView];
}

- (UIView *)setupToolBar
{
    UIView *toolBar = [[UIView alloc] init];
    
    toolBar.backgroundColor = [UIColor cyanColor];
    
    toolBar.frame = CGRectMake(0, 64, self.view.width, 50);
    
    [self.view addSubview:toolBar];
    
    NSArray *array = @[@"insert", @"query all"];
    
    CGFloat btnX = 0;
    
    CGFloat btnY = 5;
    
    CGFloat btnW = 80;
    
    CGFloat btnH = 40;
    
    CGFloat margin = (toolBar.width - array.count * btnW) / (array.count + 1);
    
    for (int i = 0; i < array.count; i++)
    {
        NSString *title = [array objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = [UIColor redColor];
        
        [button setTitle:title forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        btnX = margin + (btnW + margin) * i;
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        [button addTarget:self action:@selector(operateButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [toolBar addSubview:button];
    }
    
    return toolBar;
}

- (void)operateButton:(UIButton *)button
{
    FSPerson *person = [[FSPerson alloc] init];
    
    NSString *baseId = @"41282619910526";
    
    long tmp = arc4random() % 9999;
    
    NSString *randomStr = [NSString stringWithFormat:@"%04ld",tmp];
    
    person.idNum = [baseId stringByAppendingString:randomStr];
    
    // 97 - 122  (3 - 10)
    
    int tmp1 = arc4random() % 8 + 3;
    
    NSMutableString *tmpName = [NSMutableString string];
    
    for (int i = 0; i < tmp1; i++)
    {
        int tmp2 = arc4random() % 26;
        
        char ch = 'a' + tmp2;
        
        char ch_arr[] = {ch,'\0'};

        NSString *chStr = [NSString stringWithUTF8String:ch_arr];
        
        [tmpName appendString:chStr];
    }
    
    person.name = [tmpName capitalizedString];
    
    person.age = 20;
    
    float baseHeight = 1.50;
    
    NSInteger dyH = arc4random() % 40 + 10;
    
    person.height = baseHeight + dyH * 0.01;
    
//    person.car = [[FSCar alloc] init];
    
    person.car = nil;
    
    FSDog *dog = [[FSDog alloc] init];
    
    person.dog = dog;
    
    person.books = nil;
    
    BOOL rst = [[FSRoleDBManager shareManager] insertPerson:person];
    
    if (rst)
    {
        NSLog(@"添加suc");
    }
    else
    {
        NSLog(@"添加fail");
    }
    
    NSString *sql = @"select * from person";
    
    self.dataArray = [[FSRoleDBManager shareManager] queryPersonBySql:sql];
    
    [self.tableView reloadData];
}

- (void)prepareDatas
{
    NSString *sql = @"select * from person";
    
    NSArray *array = [[FSRoleDBManager shareManager] queryPersonBySql:sql];
    
    self.dataArray = array;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"person_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
    }
    
    FSPerson *person = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = person.name;
    
    return cell;
}


@end
