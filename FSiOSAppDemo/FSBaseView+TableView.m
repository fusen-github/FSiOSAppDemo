//
//  FSBaseView+TableView.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/8/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSBaseView+Sen.h"

////<UITableViewDataSource>

//@interface FSBaseView () <UITableViewDataSource>
//
//@end

@interface FSBaseView (TableView)<UITableViewDataSource>

@end

@implementation FSBaseView (TableView)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"fs--%ld",indexPath.row];
    
    return cell;
}

@end
