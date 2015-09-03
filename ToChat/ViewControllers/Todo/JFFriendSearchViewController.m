//
//  JFFriendSearchViewController.m
//  ToChat
//
//  Created by jft0m on 15/9/3.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFUserManager.h"
#import "JFLiteUserCell.h"
#import "JFFriendSearchViewController.h"
#import "UserInfoViewController.h"

@interface JFFriendSearchViewController ()

@property (strong,nonatomic) NSArray *users;

@end

@implementation JFFriendSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.users) {
        return self.users.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JFLiteUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiteUserCell" forIndexPath:indexPath];
    AVUser *user = self.users[indexPath.row];
    [self ConfigeCell:cell user:user type:LiteUserStyleNoStyle];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}

-(void)ConfigeCell:(JFLiteUserCell *)cell user:(AVUser *)user type:(LiteUserStyle)type {
    UIImage *avator = [[JFUserManager manager]getAvatarImageOfUser:user];
    [cell ConfigCell:user.username avator:avator followType:type];
}
- (void)searchUser:(NSString *)name {
    [[JFUserManager manager] findUsersByPartname:name withBlock: ^(NSArray *objects, NSError *error) {
        if ([self filterError:error]) {
            if (objects) {
                self.users = objects;
                NSLog(@"searched %lu objects",(unsigned long)objects.count);
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UserInfoViewController *userInfo = [segue destinationViewController];
    userInfo.isRoot = false;
    //userInfo.curUser =
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self searchUser:searchText];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

@end
