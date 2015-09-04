//
//  JFUserManager.m
//  ToChat
//
//  Created by syfll on 15/8/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFUserManager.h"
#import "LeanChatLib/UIImage+Icon.h"

static JFUserManager *userManager;

@implementation JFUserManager

+ (instancetype)manager {
    static dispatch_once_t token ;
    dispatch_once(&token, ^{
        userManager = [[JFUserManager alloc] init];
    });
    return userManager;
}

- (JFUser *)getCurrentUser{
    return [JFUser currentUser];
}

- (void)signUp:(JFUser *)user withBlock:(JFBoolResultBlock)block{
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if ([self filterError:error]) {
            [self log:@"用户注册成功 %@",user];
            [self log:@"当前用户 %@",user.username];
        }
    }];

}

- (void)signInWithUsernameInBackground:(NSString *)username
                           Andpassword:(NSString *)password
                             withBlock:(JFUserResultBlock)block{
    [JFUser logInWithUsernameInBackground:username password:password block:^(AVUser * user, NSError *error){
        block(user ,error);
    }];
}

- (UIImage *)defaultAvatarOfUser:(AVUser *)user {
    return [UIImage imageWithHashString:user.objectId displayString:[[user.username substringWithRange:NSMakeRange(0, 1)] capitalizedString]];
}

- (UIImage *)getAvatarImageOfUser:(AVUser *)user{
    __block UIImage *image ;
    AVFile *avatar = [user objectForKey:@"avatar"];
    if (avatar) {
        [avatar getDataInBackgroundWithBlock: ^(NSData *data, NSError *error) {
            if (error == nil) {
                image =  [UIImage imageWithData:data];
            }
            else {
                image = [self defaultAvatarOfUser:user];
            }
        }];

    }
    
    return image;
}

- (void)getAvatarImageOfUser:(AVUser *)user block:(void (^)(UIImage *image))block {
    AVFile *avatar = [user objectForKey:@"avatar"];
    if (avatar) {
        [avatar getDataInBackgroundWithBlock: ^(NSData *data, NSError *error) {
            if (error == nil) {
                block([UIImage imageWithData:data]);
            }
            else {
                block([self defaultAvatarOfUser:user]);
            }
        }];
    }
    else {
        block([self defaultAvatarOfUser:user]);
    }
}

#pragma mark -

- (void)findUsersByPartname:(NSString *)partName withBlock:(void (^)(NSArray *objects, NSError *error))block {
    AVQuery *q = [AVUser query];
    [q setCachePolicy:kAVCachePolicyNetworkElseCache];
    [q whereKey:@"username" containsString:partName];
    AVUser *curUser = [AVUser currentUser];
    [q whereKey:@"objectId" notEqualTo:curUser.objectId];
    [q orderByDescending:@"updatedAt"];
    [q findObjectsInBackgroundWithBlock:block];
}

- (void)followUser:(AVUser *)user callback:(AVBooleanResultBlock)callback {
    AVUser *curUser = [AVUser currentUser];
    [curUser follow:user.objectId andCallback:callback];
}

- (void)unfollowUser:(AVUser *)user callback:(AVBooleanResultBlock)callback {
    AVUser *curUser = [AVUser currentUser];
    [curUser unfollow:user.objectId andCallback:callback];
}

- (void)isFollow:(JFUser *)userA userB:(JFUser *)userB withBlock:(JFBoolResultBlock)block{
    AVQuery * query = [self getFolloweeUserQuery:userA];
    [query whereKey:@"objectId" notEqualTo:userB.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            block(YES,error);
        }else{
            block(NO,error);
        }
    }];
    
}

//- (BOOL)isFollowerOfMine:(AVUser *)user{
//    __block BOOL isFollower ;
//    AVQuery * query = [self getFollowrUserQuery:user];
//    [query whereKey:@"objectId" notEqualTo:user.objectId];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects ,NSError * error ){
//        if(objects){
//            isFollower =  YES;
//        }else{
//            isFollower =  NO;
//        }
//    }];
//    return isFollower;
//}
//
//- (BOOL)isFolloweeOfMine:(AVUser *)user{
//    __block BOOL isFollowee ;
//    AVQuery * query = [self getFolloweeUserQuery:user];
//    [query whereKey:@"objectId" notEqualTo:user.objectId];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects ,NSError * error ){
//        if(objects){
//            isFollowee =  YES;
//        }else{
//            isFollowee =  NO;
//        }
//    }];
//    return isFollowee;
//}



- (void)getFollowee:(JFUser *)user withBlock:(JFArrayResultBlock)block{
    AVQuery * query = [self getFollowrUserQuery:user];
    [query findObjectsInBackgroundWithBlock:block];
}
- (void)getFollower:(JFUser *)user withBlock:(JFArrayResultBlock)block{
    AVQuery *query = [self getFolloweeUserQuery:user];
    [query findObjectsInBackgroundWithBlock:block];
}

- (AVQuery *)getFollowrUserQuery:(AVUser *)user{
    return [user followerQuery];
}
- (AVQuery *)getFolloweeUserQuery:(AVUser *)user{
    return [user followeeQuery];
}

-(BOOL)filterError:(NSError *)error{
    if (error) {
        [self log:[NSString stringWithFormat:@"%@", error]];
        return NO;
    } else {
        return YES;
    }
}

- (void)log:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2){
    va_list ap;
    va_start(ap, format);
    [self logMessage:[[NSString alloc] initWithFormat:format arguments:ap]];
    va_end(ap);
}

-(void)logMessage:(NSString*)msg{
    NSLog(@"%@",msg);
}

- (BOOL)isMe:(JFUser *)user{
    if (user.objectId != [self getCurrentUser].objectId) {
        return NO;
    }else{
        return YES;
    }
}


@end
