//
//  JFUserInfoViewController.m
//  ToChat
//
//  Created by jft0m on 15/9/3.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFUserInfoViewController.h"
#import "ODRefreshControl.h"
#import "MJPhotoBrowser.h"
#import "JFEaseUserHeaderView.h"
#import "JFHeaderViewEntity.h"
#import "JFUserManager.h"

#import "JFFolloweesViewController.h"
#import "JFFollowersViewController.h"

@interface JFUserInfoViewController ()

@property (strong, nonatomic) JFEaseUserHeaderView *headerView;
@property (strong, nonatomic) ODRefreshControl *myRefreshControl;
@property (strong, nonatomic) JFHeaderViewEntity *entity;
@property (strong, nonatomic) JFUser *user;

@end

@implementation JFUserInfoViewController
- (void)viewDidAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerView = [[JFEaseUserHeaderView alloc] init];
    _headerView.userInteractionEnabled = YES;
    _headerView.contentMode = UIViewContentModeScaleAspectFill;

    
    __weak typeof(self) weakSelf = self;
    
    _headerView.userIconClicked = ^(){
        [weakSelf userIconClicked];
    };
    _headerView.fansCountBtnClicked = ^(){
        [weakSelf fansCountBtnClicked];
    };
    _headerView.followsCountBtnClicked = ^(){
        [weakSelf followsCountBtnClicked];
    };
    _headerView.followBtnClicked = ^(){
        [weakSelf followBtnClicked];
    };
    
    [self.tableView addParallaxWithView:_headerView andHeight:CGRectGetHeight(_headerView.frame)];
    _myRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [_myRefreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    self.user = [[JFUserManager manager]getCurrentUser];
    //[self updateJFHeaderView];
}

/**
 *  设置当前页面的用户，同时更新 self.entity
 *  设置完需要调用 [self updateJFHeaderView]; 
 *  以更新 HeaderView
 */
- (void)setUser:(JFUser *)user{
    
    _user = user;
    JFUserManager *manager = [JFUserManager manager];
    
    self.entity.username = self.user.username;
    
    if (self.user.avatar) {
        self.entity.avatar = self.user.avatar;
    }else{
        self.entity.avatar = [NSURL URLWithString:@"http://img1.touxiang.cn/uploads/20131114/14-065806_503.jpg"];
    }
    
    if (self.user.bgImage) {
        self.entity.bgImage = self.user.bgImage;
    }else{
        self.entity.bgImage = [UIImage imageNamed:@"ToChat"];
    }
    
    if ([manager getAvatarImageOfUser:self.user]) {
        self.entity.IconImage = [manager getAvatarImageOfUser:self.user];
    }else{
        self.entity.IconImage = [UIImage imageNamed:@"ToChat"];
    }
    
    self.entity.isMe = [NSNumber numberWithBool:[manager isMe:self.user]];
    self.entity.isMan = self.user.isMan;
    
    [manager getFollowee:user withBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.entity.fansCount = [NSNumber numberWithUnsignedLong:objects.count];
            NSLog(@"fansCount = %lu",(unsigned long)objects.count);
            [self updateJFHeaderView];
        }else{
            NSLog(@"%@",error);
        }
    }];
    [manager getFollower:user withBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.entity.followsCount = [NSNumber numberWithUnsignedLong:objects.count];
            NSLog(@"followsCount = %lu",(unsigned long)objects.count);
            [self updateJFHeaderView];
        }else{
            NSLog(@"%@",error);
        }
    }];
    
    [manager isFollow:self.user userB:[manager getCurrentUser] withBlock:^(BOOL succeeded, NSError *error) {
        self.entity.follow = [NSNumber numberWithBool:succeeded];
    }];
    
    [manager isFollow:[manager getCurrentUser] userB:self.user withBlock:^(BOOL succeeded, NSError *error) {
        self.entity.followed = [NSNumber numberWithBool:succeeded];
    }];
    
}
//- (JFHeaderViewEntity *)getHeaderEntity:(JFUser *)user{
//    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:11];
//    
//    JFUserManager *manager = [JFUserManager manager];
//    
//    
//    [dic setValue:nil  forKey:@"fansCount"];
//    [dic setValue:nil forKey:@"followsCount"];
//    [dic setValue:[[NSNumber alloc] initWithBool:YES] forKey:@"isMe"];
//    [dic setValue:[[NSNumber alloc] initWithBool:NO]  forKey:@"follow"];
//    [dic setValue:[[NSNumber alloc] initWithBool:NO]  forKey:@"followed"];
//    [dic setValue:nil  forKey:@"userIconViewWith"];
//    [dic setValue:@"未设置"  forKey:@"name"];
//    [dic setValue:nil forKey:@"avatar"];
//    [dic setValue:[UIImage imageNamed:@"ToChat"] forKey:@"bgImage"];
//    [dic setValue:[UIImage imageNamed:@"ToChat"]  forKey:@"IconImage"];
//    
//    JFHeaderViewEntity *entity = [[JFHeaderViewEntity alloc]initWithDictionary:dic];
//    return entity;
//}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return tableView.sectionHeaderHeight;
}
- (void)refresh{
    self.user = [[JFUserManager manager]getCurrentUser];
    [_myRefreshControl endRefreshing];
    [self.tableView reloadData];
}

- (JFHeaderViewEntity *)entity{
    if (!_entity) {
        _entity = [self noEntity];
    }
    return _entity;
}

#pragma mark Btn Clicked

- (void)fansCountBtnClicked{
    [self performSegueWithIdentifier:@"showFollowees" sender:self];
    NSLog(@"fansCountBtnClicked\n");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"showFollowees"]) {
        JFFolloweesViewController *followeesVC = [segue destinationViewController];
        followeesVC.user = _user;
    }else{
        JFFollowersViewController *followersVC = [segue destinationViewController];
        followersVC.user = _user;
    }
}

- (void)followsCountBtnClicked{
    [self performSegueWithIdentifier:@"showFollowers" sender:self];
    NSLog(@"followsCountBtnClicked\n");
}

- (void)userIconClicked{
    //显示大图
    MJPhoto *photo = [[MJPhoto alloc] init];
    if (self.entity.avatar) {
        photo.url = self.entity.avatar;
    }else{
        photo.url = [NSURL URLWithString:@"http://img1.touxiang.cn/uploads/20131114/14-065806_503.jpg"];
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;
    browser.photos = [NSArray arrayWithObject:photo];
    [browser show];
}

- (void)followBtnClicked{
    NSLog(@"followBtnClicked");
}

- (void)messageBtnClicked{
    NSLog(@"messageBtnClicked");
}

#pragma mark - JFHeaderView

#pragma mark 如果没有数据
- (JFHeaderViewEntity *)noEntity{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:11];
    [dic setValue:nil  forKey:@"fansCount"];
    [dic setValue:nil forKey:@"followsCount"];
    [dic setValue:[[NSNumber alloc] initWithBool:YES] forKey:@"isMe"];
    [dic setValue:[[NSNumber alloc] initWithBool:NO]  forKey:@"follow"];
    [dic setValue:[[NSNumber alloc] initWithBool:NO]  forKey:@"followed"];
    [dic setValue:nil  forKey:@"userIconViewWith"];
    [dic setValue:@"未设置"  forKey:@"name"];
    [dic setValue:nil forKey:@"avatar"];
    [dic setValue:[UIImage imageNamed:@"ToChat"] forKey:@"bgImage"];
    [dic setValue:[UIImage imageNamed:@"ToChat"]  forKey:@"IconImage"];
    
    JFHeaderViewEntity * entity = [[JFHeaderViewEntity alloc]initWithDictionary:dic];
    return entity;
}

#pragma mark 更新 JFHeaderView 数据
- (void)updateJFHeaderView{
    [_headerView config:self.entity];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
