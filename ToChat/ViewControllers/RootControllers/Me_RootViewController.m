//
//  Me_RootViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/30.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Me_RootViewController.h"

@interface Me_RootViewController ()


@end

@implementation Me_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)SettingClicked:(id)sender {
    UIViewController * settingVC = [[UIStoryboard storyboardWithName:@"Me" bundle:nil] instantiateViewControllerWithIdentifier:@"MeSettingViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
