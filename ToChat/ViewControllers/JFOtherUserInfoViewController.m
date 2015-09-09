//
//  JFOtherUserInfoViewController.m
//  ToChat
//
//  Created by jft0m on 15/9/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFOtherUserInfoViewController.h"
#import "ODRefreshControl.h"
#import "MJPhotoBrowser.h"
#import "JFOtherUserHeaderView.h"
#import "JFHeaderViewEntity.h"
#import "JFUserManager.h"
#import "JFMessageViewController.h"


@interface JFOtherUserInfoViewController ()

@property (strong ,nonatomic) JFOtherUserHeaderView *headerView;
@property (strong ,nonatomic) JFHeaderViewEntity *entity;
@property (strong ,nonatomic) JFUser *user;

@property (strong ,nonatomic) NSArray *followee;
@property (strong ,nonatomic) NSArray *follower;

@end

@implementation JFOtherUserInfoViewController

- (void)config:(JFUser *)user{
    self.user = user;
    //[self configEntity:user];
}

#pragma mark - property
- (JFHeaderViewEntity *)entity{
    if (!_entity) {
        _entity = [self noEntity];
    }
    return _entity;
}

/**
 *  设置当前页面的用户，同时更新 self.entity
 *  设置完需要调用 [self updateJFHeaderView];
 *  以更新 HeaderView
 */
- (void)setUser:(JFUser *)user{
    
    _user = user;
    JFUserManager *manager = [JFUserManager manager];
    
    self.entity.username = _user.username;
    
    if (self.user.avatar) {
        self.entity.avatar = _user.avatar;
    }else{
        self.entity.avatar = [NSURL URLWithString:@"http://img1.touxiang.cn/uploads/20131114/14-065806_503.jpg"];
    }
    
    if (self.user.bgImage) {
        self.entity.bgImage = _user.bgImage;
    }else{
        self.entity.bgImage = [UIImage imageNamed:@"ToChat"];
    }
    
    if ([manager getAvatarImageOfUser:_user]) {
        self.entity.IconImage = [manager getAvatarImageOfUser:_user];
    }else{
        self.entity.IconImage = [UIImage imageNamed:@"ToChat"];
    }
    
    self.entity.isMe = [NSNumber numberWithBool:[manager isMe:_user]];
    self.entity.isMan = _user.isMan;
    
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
    [self updateJFHeaderView];
    
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerView = [[JFOtherUserHeaderView alloc] init];
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
    self.tableView.tableFooterView = [self footerV];
}

#pragma mark - table view 
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return tableView.sectionHeaderHeight;
}



#pragma mark Btn Clicked

- (void)fansCountBtnClicked{
    NSLog(@"fansCountBtnClicked\n");
}

- (void)followsCountBtnClicked{
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
    [[JFUserManager manager]followUser:self.user callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"关注成功");
        }else{
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark footerV
- (UIView *)footerV{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 72)];
    
    UIButton *footerBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"发消息" andFrame:CGRectMake(kPaddingLeftWidth, (CGRectGetHeight(footerV.frame)-44)/2 , kScreen_Width - 2*kPaddingLeftWidth, 44) target:self action:@selector(messageBtnClicked)];
    [footerV addSubview:footerBtn];
    return footerV;
}

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

- (void)messageBtnClicked{
    //NSLog(@"messageBtnClicked");
    [self performSegueWithIdentifier:@"goChatting" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    JFMessageViewController *chattingVC = [segue destinationViewController];
    chattingVC.incomingUser = self.user;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (JFHeaderViewEntity *)entity{
//    if (!_entity) {
//        _entity = [self noEntity];
//    }
//    return _entity;
//}

//- (JFHeaderViewEntity *)noEntity{
//
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:11];
//    [dic setValue:nil  forKey:@"fansCount"];
//    [dic setValue:nil forKey:@"followsCount"];
//    [dic setValue:[[NSNumber alloc] initWithBool:NO] forKey:@"isMe"];
//    [dic setValue:[[NSNumber alloc] initWithBool:NO]  forKey:@"follow"];
//    [dic setValue:[[NSNumber alloc] initWithBool:NO]  forKey:@"followed"];
//    [dic setValue:nil  forKey:@"userIconViewWith"];
//    [dic setValue:@"未设置"  forKey:@"name"];
//    [dic setValue:nil forKey:@"avatar"];
//    [dic setValue:[UIImage imageNamed:@"ToChat"] forKey:@"bgImage"];
//    [dic setValue:[UIImage imageNamed:@"ToChat"]  forKey:@"IconImage"];
//
//    JFHeaderViewEntity * entity = [[JFHeaderViewEntity alloc]initWithDictionary:dic];
//    return entity;
//}


//- (void)configEntity:(JFUser *)user{
//
//    JFUserManager *manager = [JFUserManager manager];
//
//    [manager getFollowee:user withBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            self.entity.fansCount = [NSNumber numberWithUnsignedLong:objects.count];
//            _followee = objects;
//            [self updateData];
//            NSLog(@"number of gollowee:%lu",(unsigned long)objects.count);
//        }else{
//            NSLog(@"%@",error);
//        }
//    }];
//
//    [manager getFollower:user withBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            self.entity.followsCount = [NSNumber numberWithUnsignedLong:objects.count];
//            _follower = objects;
//            [self updateData];
//            NSLog(@"number of gollowee:%lu",(unsigned long)objects.count);
//        }else{
//            NSLog(@"%@",error);
//        }
//    }];
//
//    NSNumber *fansCount = [NSNumber numberWithUnsignedLong:_followee.count];
//    NSNumber *followsCount = [NSNumber numberWithUnsignedLong:_follower.count];
//    NSNumber *isMe = [NSNumber numberWithBool:[manager isMe:user]];
////    NSNumber *follow = [NSNumber numberWithBool:[manager isFolloweeOfMine:user]];
////    NSNumber *followed = [NSNumber numberWithBool:[manager isFollowerOfMine:user]];
//
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:11];
//    [dic setValue:fansCount forKey:@"fansCount"];
//    [dic setValue:followsCount forKey:@"followsCount"];
////    [dic setValue:isMe forKey:@"isMe"];
////    [dic setValue:follow forKey:@"follow"];
////    [dic setValue:followed forKey:@"followed"];
//    [dic setValue:user.username  forKey:@"username"];
//    [dic setValue:user.avatar forKey:@"avatar"];
//    [dic setValue:user.bgImage forKey:@"bgImage"];
//    [dic setValue:user.IconImage  forKey:@"IconImage"];
//
//    self.entity = [[JFHeaderViewEntity alloc]initWithDictionary:dic];
//
//}

@end
