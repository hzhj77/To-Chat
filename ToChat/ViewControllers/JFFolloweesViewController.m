//
//  JFFolloweeViewController.m
//  ToChat
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFFolloweesViewController.h"
#import "ODRefreshControl.h"
#import "JFUserCell.h"
#import "JFOtherUserInfoViewController.h"


@interface JFFolloweesViewController ()

@property (strong ,nonatomic) NSArray *users;
@property (strong ,nonatomic) ODRefreshControl *myRefreshControl;
@property (weak   ,nonatomic) IBOutlet UITableView *tableView;
@property (strong ,nonatomic) JFUser *selectedUser;

@end

@implementation JFFolloweesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [_myRefreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [[JFUserManager manager]getFollowee:_user withBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"查询到的用户：%@",objects);
            _users = objects;
            [self.tableView reloadData];
        }else{
            NSLog(@"%@",error);
        }
        
    }];
    
    
}

- (void)refresh{
    [_myRefreshControl endRefreshing];
    [[JFUserManager manager]getFollowee:_user withBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"查询到的用户：%@",objects);
            _users = objects;
        }else{
            NSLog(@"%@",error);
        }
        
    }];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _users.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JFUserCell *cell = [tableView dequeueReusableCellWithIdentifier:JF_USER_CELL forIndexPath:indexPath];
    
    [cell config:[self getEntity:_users[indexPath.row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedUser = self.users[indexPath.row];
    [self performSegueWithIdentifier:@"showUserDetail" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

#pragma mark - show segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    JFOtherUserInfoViewController * otherVC = [segue destinationViewController];
    [otherVC config:self.selectedUser];
}

#pragma mark -
- (JFUserEntity *)getEntity:(JFUser *)user{
    JFUserManager *manager = [JFUserManager manager];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:4];
    [dic setValue :user.username forKey:@"username"];
    [dic setValue :[manager getAvatarImageOfUser:user] forKey:@"avatar"];
    [dic setValue :user.signature forKey:@"signature"];
    
    return [[JFUserEntity alloc]initWithDictionary:dic];
    
}


@end
