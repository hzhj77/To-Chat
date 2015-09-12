//
//  GroupContentViewController.m
//  ToChat
//
//  Created by chenlong on 15/9/11.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "GroupContentViewController.h"
#import "DVSwitch.h"
#import "Header.h"
#import "GroupMemberCell.h"

@interface GroupContentViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation GroupContentViewController{
    UITableView* memberTableView;//群成员列表
    UITableView* scheduleTableView;//日程列表
    DVSwitch* dvSwitch;//滑动开关 用来选择展示列表
    NSInteger selectIndex;//存储dvSwitch选中的index
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //初始化
    selectIndex = 0;
    
    //选择开关
    dvSwitch = [DVSwitch switchWithStringsArray:@[@"成员", @"日程"]];
    dvSwitch.frame = CGRectMake(0, 64, kScreen_Width, 35);
    dvSwitch.cornerRadius = 0;
    dvSwitch.backgroundColor = [UIColor grayColor];
    dvSwitch.labelTextColorInsideSlider =  [UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1.0];
    [dvSwitch setPressedHandler:^(NSUInteger index) {
        if (index == 0) {
            [UIView animateWithDuration:0.2 animations:^{
                selectIndex = 0;
                memberTableView.right = kScreen_Width;
                scheduleTableView.left = kScreen_Width;
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                selectIndex = 1;
                memberTableView.right = 0;
                scheduleTableView.left = 0;
            }];
        }
    }];
    [self.view addSubview:dvSwitch];
    
    memberTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 99, kScreen_Width, kScreen_Height - 99) style:UITableViewStylePlain];
    memberTableView.dataSource = self;
    memberTableView.delegate = self;
//    memberTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:memberTableView];
    
    scheduleTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreen_Width, 99, kScreen_Width, kScreen_Height - 99) style:UITableViewStylePlain];
    scheduleTableView.dataSource = self;
    scheduleTableView.delegate = self;
//    scheduleTableView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scheduleTableView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    memberTableView.right = kScreen_Width;
    scheduleTableView.left = kScreen_Width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == memberTableView) {
        return 10;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"menCell";
    GroupMemberCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GroupMemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
