//
//  JFUser.h
//  ToChat
//
//  Created by syfll on 15/8/26.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVOSCloud/AVOSCloud.h>

@interface JFUser : AVUser<AVSubclassing>

@property (assign, nonatomic) NSNumber *isMan;

@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *username;
/// 头像的url
@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSString *signature;

@property (strong, nonatomic) UIImage *bgImage ;
/// 用户头像小图
@property (strong, nonatomic) UIImage *IconImage ;
/// 谁关注我
//@property (nonatomic, strong) AVRelation *followers;
/// 我关注谁
//@property (nonatomic, strong) AVRelation *followees;

@end
