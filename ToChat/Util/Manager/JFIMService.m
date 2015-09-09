//
//  JFIMService.m
//  ToChat
//
//  Created by jft0m on 15/9/6.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFIMService.h"

@implementation JFIMService

+ (instancetype)service {
    static JFIMService *imService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imService = [[JFIMService alloc] init];
    });
    return imService;
}

#pragma mark - user delegate

- (void)cacheUserByIds:(NSSet *)userIds block:(AVBooleanResultBlock)block {
    [[JFCacheManager manager] cacheUsersWithIds:userIds callback:block];
}

- (JFUser *)getUserById:(NSString *)userId {
    JFUser *user = [[JFUser alloc] init];
    JFUser *avUser = [[JFCacheManager manager] lookupUser:userId];
    if (avUser == nil) {
        DLog(@"avUser is nil!!!");
    }
    user.userId = userId;
    user.username = avUser.username;
    AVFile *avatarFile = [avUser objectForKey:@"avatar"];
    user.avatar = avatarFile.url;
    return user;
}

# pragma mark - emotion upload

+ (BOOL)saveEmotionFromResource:(NSString *)resource savedName:(NSString *)name error:(NSError *__autoreleasing *)error{
    __block BOOL result;
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"gif"];
    if (path == nil)  {
        *error = [NSError errorWithDomain:@"LeanChatLib" code:1 userInfo:@{NSLocalizedDescriptionKey:@"path is nil"}];
        return NO;
    }
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [CDEmotionUtils findEmotionWithName:name block:^(AVFile *file, NSError *_error) {
        if (error) {
            result = NO;
            *error = _error;
            dispatch_semaphore_signal(sema);
        } else {
            if (file == nil) {
                AVFile *file = [AVFile fileWithName:name contentsAtPath:path];
                AVObject *emoticon = [AVObject objectWithClassName:@"Emotion"];
                [emoticon setObject:name forKey:@"name"];
                [emoticon setObject:file forKey:@"file"];
                [emoticon saveInBackgroundWithBlock:^(BOOL succeeded, NSError *theError) {
                    if (theError) {
                        result = NO;
                        *error = theError;
                    } else {
                        result = YES;
                    }
                    dispatch_semaphore_signal(sema);
                }];
            } else {
                result = YES;
                dispatch_semaphore_signal(sema);
            }
        }
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    return result;
}

+ (NSString *)coverPathOfIndex:(NSInteger)index prefix:(NSString *)prefix {
    return [NSString stringWithFormat:@"%@_%ld",prefix, (long)index];
}

+ (void)saveEmotions {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //tusiji
        [self saveEmotionGroupWithPrefix:@"tusiji" maxIndex:15];
        //rabbit
        [self saveEmotionGroupWithPrefix:@"rabbit" maxIndex:22];
    });
}

+ (void)saveEmotionGroupWithPrefix:(NSString *)prefix maxIndex:(NSInteger)maxIndex {
    for (NSInteger i = 0; i <= maxIndex; i++) {
        NSString *name = [self coverPathOfIndex:i prefix:prefix];
        [self saveEmotionFromResource:name savedName:name error:nil];
    }
}




@end
