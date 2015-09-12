//
//  GroupMessageViewController.m
//  ToChat
//
//  Created by chenlong on 15/9/12.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "GroupMessageViewController.h"
#import "Header.h"
#import "GroupMessageCell.h"

@interface GroupMessageViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation GroupMessageViewController{
    UITableView* msgTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"群聊消息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    msgTableView = [[UITableView alloc] initWithFrame:kScreen_Frame style:UITableViewStylePlain];
    msgTableView.dataSource = self;
    msgTableView.delegate = self;
    [self.view addSubview:msgTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"msgCell";
    GroupMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"GroupMessageCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupMessageCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.msgNumLabel.backgroundColor = [UIColor redColor];
}

@end
