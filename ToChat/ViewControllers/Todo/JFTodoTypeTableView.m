//
//  JFTodoTypeTableView.m
//  ToChat
//
//  Created by syfll on 15/8/18.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "JFTodoTypeTableView.h"

@interface JFTodoTypeTableView ()

@end

@implementation JFTodoTypeTableView

- (void)viewDidLoad {
    [super viewDidLoad];
}
+(instancetype)initWithTitle:(NSString *)title{
    JFTodoTypeTableView *view = [[JFTodoTypeTableView alloc]initWithStyle:UITableViewStylePlain];
    view.titleName = title;
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}
#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    if (_titleName) {
        return _titleName;
    }
    return @"未设置";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}

@end
