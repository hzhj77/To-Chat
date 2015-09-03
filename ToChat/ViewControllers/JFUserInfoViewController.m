//
//  JFUserInfoViewController.m
//  ToChat
//
//  Created by jft0m on 15/9/3.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFUserInfoViewController.h"

@interface JFUserInfoViewController ()

@property (nonatomic ,assign) BOOL isMe;
@property (nonatomic ,strong) JFUser *user;

@end

@implementation JFUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
