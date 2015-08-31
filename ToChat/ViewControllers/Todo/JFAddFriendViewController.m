//
//  JFAddFriendViewController.m
//  ToChat
//
//  Created by syfll on 15/8/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFAddFriendViewController.h"
#import "JFUserManager.h"
#import "JFLiteUserCell.h"

@interface JFAddFriendViewController ()<UISearchBarDelegate>
@property (weak,  nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *users;


@end

@implementation JFAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.users) {
        return self.users.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JFLiteUserCell *cell = [tableView dequeueReusableCellWithIdentifier:JF_Lite_User_Cell forIndexPath:indexPath];
    AVUser *user = self.users[indexPath.row];
    [self ConfigeCell:cell user:user type:LiteUserStyleNotFollow];
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
//    [[JFUserManager manager] findUsersByPartname:name withBlock: ^(NSArray *objects, NSError *error) {
//        if ([self filterError:error]) {
//            if (objects) {
//                self.users = objects;
//                [_tableView reloadData];
//            }
//        }
//    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self searchUser:searchText];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

@end
