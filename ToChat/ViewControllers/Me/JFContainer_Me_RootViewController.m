//
//  JFContainer_Me_RootViewController.m
//  ToChat
//
//  Created by syfll on 15/8/30.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFContainer_Me_RootViewController.h"

@interface JFContainer_Me_RootViewController ()

@end

@implementation JFContainer_Me_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)SettingClicked:(id)sender{
    UIViewController * settingVC = [[UIStoryboard storyboardWithName:@"Me" bundle:nil] instantiateViewControllerWithIdentifier:@"MeSettingViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}
@end
