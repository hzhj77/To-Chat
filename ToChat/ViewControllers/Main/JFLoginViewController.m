//
//  JFLoginViewController.m
//  ToChat
//
//  Created by syfll on 15/8/27.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "JFLoginViewController.h"
#import "AVOSCloud/AVUser.h"

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
            //[self performSegueWithIdentifier:@"goRootView" sender:self];
            [self presentViewController:[[UIStoryboard storyboardWithName:@"ToChatMain" bundle:nil]instantiateInitialViewController] animated:NO completion:nil];
            //[[UIApplication sharedApplication].delegate.window setRootViewController:[[UIStoryboard storyboardWithName:@"ToChatMain" bundle:nil]instantiateInitialViewController]];
        } else {
            NSLog(@"登陆失败");
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (IBAction)dismissClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end