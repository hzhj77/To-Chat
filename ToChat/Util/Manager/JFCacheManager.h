//
//  JFCacheManager.h
//  ToChat
//
//  Created by jft0m on 15/9/6.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFUserManager.h"
#import "LeanChatLib.h"
#import "AVOSCloudIM.h"

@interface JFCacheManager : NSObject
+ (instancetype)manager;

- (void)cacheUsersWithIds:(NSSet *)userIds callback:(AVBooleanResultBlock)callback;
- (JFUser *)lookupUser:(NSString *)userId;
@end
