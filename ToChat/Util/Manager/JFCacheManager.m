//
//  JFCacheManager.m
//  ToChat
//
//  Created by jft0m on 15/9/6.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFCacheManager.h"
static JFCacheManager *cacheManager;
@interface JFCacheManager ()<NSCacheDelegate>

@property (nonatomic, strong) NSCache *userCache;
@property (nonatomic, strong) NSString *currentConversationId;

@end

@implementation JFCacheManager

+ (instancetype)manager {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        cacheManager = [[JFCacheManager alloc] init];
    });
    return cacheManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userCache = [[NSCache alloc] init];
        _userCache.delegate = self;
        _userCache.evictsObjectsWithDiscardedContent = NO;
    }
    return self;
}

#pragma mark - cache delegate
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    DLog(@"will evict object");
}

#pragma mark - user cache

- (void)registerUsers:(NSArray *)users {
    for (JFUser *user in users) {
        [self.userCache setObject:user forKey:user.objectId];
    }
}

- (JFUser *)lookupUser:(NSString *)userId {
    return [self.userCache objectForKey:userId];
}

- (void)cacheUsersWithIds:(NSSet *)userIds callback:(AVBooleanResultBlock)callback {
    NSMutableSet *uncachedUserIds = [[NSMutableSet alloc] init];
    for (NSString *userId in userIds) {
        if ([[JFCacheManager manager] lookupUser:userId] == nil) {
            [uncachedUserIds addObject:userId];
        }
    }
    if ([uncachedUserIds count] > 0) {
        [[JFUserManager manager] findUsersByIds:[[NSMutableArray alloc] initWithArray:[uncachedUserIds allObjects]] callback: ^(NSArray *objects, NSError *error) {
            if (objects) {
                [[JFCacheManager manager] registerUsers:objects];
            }
            callback(YES, error);
        }];
    }
    else {
        callback(YES, nil);
    }
}

#pragma mark - current conversation

- (void)setCurConv:(AVIMConversation *)conv {
    self.currentConversationId = conv.conversationId;
}

- (AVIMConversation *)getCurConv {
    return [[CDChatManager manager] lookupConvById:self.currentConversationId];
}

- (void)refreshCurConv:(AVBooleanResultBlock)callback {
    if ([self getCurConv] != nil) {
        [[CDChatManager manager] fecthConvWithConvid:[self getCurConv].conversationId callback: ^(AVIMConversation *conversation, NSError *error) {
            if (error) {
                callback(NO, error);
            }
            else {
                [[NSNotificationCenter defaultCenter] postNotificationName:kCDNotificationConversationUpdated object:nil];
                callback(YES, nil);
            }
        }];
    }
    else {
        callback(NO, [NSError errorWithDomain:nil code:0 userInfo:@{ NSLocalizedDescriptionKey:@"current conv is nil" }]);
    }
}


@end
