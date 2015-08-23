//
//  LoginViewController.h
//  Step-it-up
//
//  Created by syfll on 15/7/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//
//  因为这个页面可能是介绍页面跳转，这时候需要显示DismissButton
//  也可能是在登陆之后点击退出后跳转的，这时候不需要显示DismissButton

#import "BaseViewController.h"
#import "BaseNavigationController.h"


@interface LoginViewController : BaseViewController

/**
 是否在左上角显示“X”按钮
 */
@property (assign, nonatomic) BOOL showDismissButton;
@end
