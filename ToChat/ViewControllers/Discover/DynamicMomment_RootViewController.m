//
//  DynamicMomment_RootViewController.m
//  ToChat
//
//  Created by syfll on 15/8/12.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "DynamicMomment_RootViewController.h"
#import "MomentCell.h"
#import "Tweets.h"

@interface DynamicMomment_RootViewController ()<UITableViewDataSource,UITableViewDelegate>
/// 展示TweetTodo(日程动态)用的
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ODRefreshControl *refreshControl;

/// 用来计算高度的可重用的cell
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;

/// 管理Tweet（动态）用的
@property (nonatomic, strong) Tweets *myTweets;

@end

@implementation DynamicMomment_RootViewController
@synthesize myTweets = _myTweets;


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
#pragma mark - 

-(Tweets *)myTweets{
#warning 测试用的假数据
    if (!_myTweets) {
        _myTweets = [[Tweets alloc]init];
        _myTweets.tweets = [self fakeTweets];
    }
    return _myTweets;
}
#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTweets = [[Tweets alloc]init];
    _myTweets.tweets = [self fakeTweets];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.and.top.equalTo(self.view);
    }];
    
    
    
    self.offscreenCells = [NSMutableDictionary dictionary];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[MomentCell class] forCellReuseIdentifier:JF_Moment_Cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MomentCell * cell = [tableView dequeueReusableCellWithIdentifier:JF_Moment_Cell forIndexPath:indexPath];
    cell.tweet = [_myTweets.tweets objectAtIndex:indexPath.row];
    
    
    [cell updateFonts];
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = JF_Moment_Cell;
    
    MomentCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    if (!cell) {
        //cell = [[ScheduleCell alloc] init];
        cell = [[MomentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        [self.offscreenCells setObject:cell forKey:reuseIdentifier];
    }
    //设置cell内容
    [cell updateFonts];
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


#pragma mark - Debug
#warning fake initTweet

-(NSMutableArray *)fakeTweets{
    
    Tweet * tweet = [Tweet fakeInit];
    NSMutableArray * tweets = [[NSMutableArray alloc]initWithArray:@[tweet]];
    return tweets;
}

@end
