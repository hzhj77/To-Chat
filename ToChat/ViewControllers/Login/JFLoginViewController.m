//
//  JFLoginViewController.m
//  ToChat
//
//  Created by syfll on 15/8/27.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "JFLoginViewController.h"

@interface JFLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation JFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)loginButtonClicked:(id)sender {
    NSString *my_user_name = self.userName.text;
    NSString *my_password = self.password.text;
    [AVUser logInWithUsernameInBackground:my_user_name password:my_password block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [self performSegueWithIdentifier:@"goRootView" sender:self];
        } else {
            NSLog(@"登陆失败");
        }
    }];
}



@end
