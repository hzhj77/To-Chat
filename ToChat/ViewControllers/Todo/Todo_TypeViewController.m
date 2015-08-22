//
//  ToDo_TypeViewController.m
//  ToChat
//
//  Created by syfll on 15/8/18.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "Todo_TypeViewController.h"
#import "JFTodoTypeTableView.h"
@interface Todo_TypeViewController ()

@end

@implementation Todo_TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isProgressiveIndicator = YES;
    self.isElasticIndicatorLimit = YES;
    // Do any additional setup after loading the view.
    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    JFTodoTypeTableView * child_1 = [JFTodoTypeTableView initWithTitle:@"运动"];
    JFTodoTypeTableView * child_2 = [JFTodoTypeTableView initWithTitle:@"运动运动"];
    JFTodoTypeTableView * child_3 = [JFTodoTypeTableView initWithTitle:@"运动运动运动运动"];
    JFTodoTypeTableView * child_4 = [JFTodoTypeTableView initWithTitle:@"运动"];
    JFTodoTypeTableView * child_5 = [JFTodoTypeTableView initWithTitle:@"运动运动"];
    JFTodoTypeTableView * child_6 = [JFTodoTypeTableView initWithTitle:@"运动运动运动运动"];
    
    return @[child_1, child_2, child_3,child_4,child_5,child_6];
}

@end
