//
//  LoginManager.m
//  ToChat
//
//  Created by syfll on 15/8/26.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#define JF_Login_Status @"LoginStatus"

#import "LoginManager.h"

@implementation LoginManager
@dynamic isLogin;
+ (LoginManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LoginManager *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (BOOL) isLogin{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:JF_Login_Status];
    if (_me!= nil && loginStatus.boolValue) {
        return YES;
    }
    return NO;
}

-(void) setIsLogin:(BOOL)isLogin{
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:JF_Login_Status];
}
@end
