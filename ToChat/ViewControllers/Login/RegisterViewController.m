//
//  RegisterViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "RegisterViewController.h"
#import "TTTAttributedLabel.h"

@interface RegisterViewController ()<UITableViewDataSource, UITableViewDelegate, TTTAttributedLabelDelegate>


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController.childViewControllers.count <= 1) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithBtnTitle:@"取消" target:self action:@selector(dismissSelf)];
    }
    [self demoUsernameRegister];
    
}


-(void)demoUsernameRegister{
    AVUser *user= [AVUser user];
    user.username=@"JFT0M";
    user.password=@"1";
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if ([self filterError:error]) {
            [self log:@"用户注册成功 %@",user];
            [self log:@"当前用户 %@",user.username];
        }
    }];
}
-(BOOL)filterError:(NSError *)error{
    if (error) {
        [self log:[NSString stringWithFormat:@"%@", error]];
        return NO;
    } else {
        return YES;
    }
}

- (void)log:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2){
    va_list ap;
    va_start(ap, format);
    [self logMessage:[[NSString alloc] initWithFormat:format arguments:ap]];
    va_end(ap);
}

-(void)logMessage:(NSString*)msg{
    NSLog(@"%@",msg);
}


- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
