//
//  JFHeaderViewEntity.h
//  ToChat
//
//  Created by jft0m on 15/9/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFUserManager.h"

@interface JFHeaderViewEntity : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (assign ,nonatomic) NSNumber *fansCount;
@property (assign ,nonatomic) NSNumber *followsCount;
@property (assign ,nonatomic) NSNumber *isMe;
@property (assign ,nonatomic) NSNumber *isMan;
@property (assign ,nonatomic) NSNumber *follow;
@property (assign ,nonatomic) NSNumber *followed;
@property (assign ,nonatomic) NSNumber *userIconViewWith;
@property (copy   ,nonatomic) NSString *username;
/// 头像的url
@property (strong ,nonatomic) NSURL *avatar;
@property (strong ,nonatomic) UIImage *bgImage ;
/// 用户头像小图
@property (strong ,nonatomic) UIImage *IconImage ;



@end
