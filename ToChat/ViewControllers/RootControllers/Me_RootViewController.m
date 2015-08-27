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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    UIBarButtonItem *setting = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(goSetting)];
    [self.navigationItem setRightBarButtonItem:setting];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

-(void)goSetting{
    UIViewController *settingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
