//
//  JFUserManager.h
//  ToChat
//
//  Created by syfll on 15/8/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

typedef void (^JFArrayResultBlock)(NSArray *followType, NSArray *objects, NSError *error);
@interface JFUserManager : NSObject

+ (instancetype)manager;
/// 获取用户头像
- (UIImage*)getAvatarImageOfUser:(AVUser *)user;
/// 通过用户名搜索用户
- (void)findUsersByPartname:(NSString *)partName withBlock:(JFArrayResultBlock)block;
/// 关注
- (void)followUser:(AVUser *)user callback:(AVBooleanResultBlock)callback;
/// 取消关注
- (void)unfollowFriend:(AVUser *)user callback:(AVBooleanResultBlock)callback;


@end
