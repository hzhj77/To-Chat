//
//  JFLoginContainerViewController.m
//  ToChat
//
//  Created by syfll on 15/8/28.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFLoginContainerViewController.h"

@interface JFLoginContainerViewController ()

@end

@implementation JFLoginContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    //[[UIApplication sharedApplication]setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
- (IBAction)dismissButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
