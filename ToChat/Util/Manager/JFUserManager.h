//
//  JFUserManager.h
//  ToChat
//
//  Created by syfll on 15/8/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JFUser.h"

typedef void (^JFBoolResultBlock  ) (BOOL succeeded, NSError *error);
typedef void (^JFArrayResultBlock ) (NSArray *objects, NSError *error);
typedef void (^JFUserResultBlock  ) (JFUser *user, NSError *error);

@interface JFUserManager : NSObject

+ (instancetype)manager;

/// 获取当前用户
- (JFUser *)getCurrentUser;

/// 获取用户头像
- (UIImage *)getAvatarImageOfUser:(JFUser *)user;

/// 登陆
- (void)signInWithUsernameInBackground:(NSString *)username
                              Andpassword:(NSString *)password
                             withBlock:(JFUserResultBlock)block;

/// 注册
- (void)signUp:(JFUser *)user withBlock:(JFBoolResultBlock)block;

/// 通过用户名搜索用户
- (void)findUsersByPartname:(NSString *)partName withBlock:(JFArrayResultBlock)block;

/// 获取粉丝的用户
- (void)getFollower:(JFUser *)user withBlock:(JFArrayResultBlock)block;

/// 获取关注的用户
- (void)getFollowee:(JFUser *)user withBlock:(JFArrayResultBlock)block;

/// 判断 userA 是否关注了 userB
- (void)isFollow:(JFUser *)userA userB:(JFUser *)userB withBlock:(JFBoolResultBlock)block;

/// 关注
- (void)followUser:(JFUser *)user callback:(AVBooleanResultBlock)callback;

/// 取消关注
- (void)unfollowFriend:(JFUser *)user callback:(AVBooleanResultBlock)callback;

/// 判断是否是当前登录用户
- (BOOL)isMe:(JFUser *)user;

@end
