//
//  FSController08.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/22.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController08.h"

@interface FSController08 ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSController08

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"move" style:UIBarButtonItemStylePlain target:self action:@selector(moveTableViewCell)];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    tableView.frame = self.view.bounds;
    
    tableView.rowHeight = 60;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}


- (void)moveTableViewCell
{
    self.tableView.editing = !self.tableView.editing;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellId = @"FSController08_tableView_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"fs---%ld",(indexPath.row + 1)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath = %ld, %s",indexPath.row, __func__);
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath = %ld, %s",indexPath.row, __func__);
    
    return 100;
}

/* for 编辑*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return YES;
    }
    
    return NO;
    
}

//
///* for 编辑*/
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"%ld",editingStyle);
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"fusen";
//}

// Use -tableView:trailingSwipeActionsConfigurationForRowAtIndexPath: instead of this method, which will be deprecated in a future release.
// This method supersedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil


//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"11" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//        NSLog(@"111111");
//
//    }];
//
//    action1.backgroundColor = [UIColor grayColor];
//
//    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"22" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//        NSLog(@"2222222");
//    }];
//
//    action2.backgroundColor = [UIColor greenColor];
//
//    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"33" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//        NSLog(@"3333333333");
//    }];
//
//    action3.backgroundColor = [UIColor blueColor];
//
//    NSLog(@"call............");
//
//    return @[action1, action2, action3];
//}

//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIContextualAction *action1 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"111" handler:^(UIContextualAction *action, UIView *sourceView, void (^completionHandler)(BOOL)) {
//
//        NSLog(@"%@",sourceView);
//    }];
//
//    UIContextualAction *action2 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"222" handler:^(UIContextualAction *action, UIView *sourceView, void (^completionHandler)(BOOL)) {
//
//        NSLog(@"%@",sourceView);
//    }];
//
//    NSArray *array = @[action1,action2];
//
//    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:array];
//
//    return configuration;
//}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 1)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"sourceIndexPath.row = %ld,   destinationIndexPath.row = %ld", sourceIndexPath.row,destinationIndexPath.row);
}

//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
//{
//    NSLog(@"xxxxxxxxxxx");
//
//    return [NSIndexPath indexPathForRow:0 inSection:0];
//}

//// return 'depth' of row for hierarchies
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger depth = indexPath.row % 10 * 2;
//    
//    return depth;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
}



@end
