//
//  DiscoverTodoViewController.m
//  ToChat
//
//  Created by syfll on 15/8/19.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "LKAlarmEvent.h"
#import "DiscoverTodoCell.h"
#import "DiscoverTodoViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"


@interface DiscoverTodoViewController ()
@property (nonatomic, strong) NSMutableArray *enents;
@end

@implementation DiscoverTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.fd_debugLogEnabled = YES;
    [self.tableView registerClass:[DiscoverTodoCell self] forCellReuseIdentifier:JF_Discover_Todo_Cell];
    self.enents = @[].mutableCopy;
    for (int i = 0 ; i <99	; i++) {
        [self.enents addObject:[[LKAlarmEvent alloc]init]];
    }

    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.enents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverTodoCell *cell = [tableView dequeueReusableCellWithIdentifier:JF_Discover_Todo_Cell forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(DiscoverTodoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.fd_enforceFrameLayout = NO; 
    cell.entity = self.enents[indexPath.row];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return [tableView fd_heightForCellWithIdentifier:JF_Discover_Todo_Cell cacheByIndexPath:indexPath configuration:^(DiscoverTodoCell *cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
}

@end
