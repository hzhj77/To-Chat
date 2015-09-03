//
//  JFUserInfoViewController.m
//  ToChat
//
//  Created by jft0m on 15/9/3.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFUserInfoViewController.h"
#import "EaseUserHeaderView.h"
#import "ODRefreshControl.h"
#import "UserInfoIconCell.h"
#import "MJPhotoBrowser.h"
#import "JFUserHeaderView.h"
#import "JFEaseUserHeaderView.h"

@interface JFUserInfoViewController ()

//@property (strong, nonatomic) EaseUserHeaderView *headerView;
@property (strong, nonatomic) JFEaseUserHeaderView *headerView;
@property (strong, nonatomic) ODRefreshControl *myRefreshControl;
@property (nonatomic ,assign) BOOL isMe;
@property (nonatomic ,strong) JFUser *user;
@end

@implementation JFUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _headerView = [EaseUserHeaderView userHeaderViewWithUser:[[User alloc]init] image:[UIImage imageNamed:@"add_user_icon"]];
    _headerView = [[JFEaseUserHeaderView alloc] init];
    _headerView.userInteractionEnabled = YES;
    _headerView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView configViw];
    
    [self.tableView addParallaxWithView:_headerView andHeight:CGRectGetHeight(_headerView.frame)];
    _myRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [_myRefreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];

}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return tableView.sectionHeaderHeight;
}
- (void)refresh{
    [_myRefreshControl endRefreshing];
    [self.tableView reloadData];
}

-(BOOL)isMe{
    NSAssert(_user, @"请先设置user");
    
    JFUser *user = [[JFUserManager manager]getCurrentUser];
    if (_user.userID == user.userID ) {
        return YES;
    }else{
        return NO;
    }
}

-(void)configUserInfo:(JFUser *)user{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
