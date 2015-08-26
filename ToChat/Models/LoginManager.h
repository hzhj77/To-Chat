//
//  LoginManager.h
//  ToChat
//
//  Created by syfll on 15/8/26.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface LoginManager : NSObject
@property (strong, atomic) User *me;
@property (assign, atomic) BOOL isLogin;
+ (LoginManager *)sharedInstance;
@end
