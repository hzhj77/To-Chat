//
//  JFSettingTableViewController.m
//  ToChat
//
//  Created by syfll on 15/8/28.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFSettingTableViewController.h"
#import "AVOSCloud/AVUser.h"
@interface JFSettingTableViewController ()

@end

@implementation JFSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)logOutCliked:(id)sender {
    
    [AVUser logOut];
    NSLog(@"已经注销用户");
    
    UIViewController *logInVC= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"JFLoginViewController"];
    [[UIApplication sharedApplication].delegate.window setRootViewController:logInVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
