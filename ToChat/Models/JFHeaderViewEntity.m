//
//  JFHeaderViewEntity.m
//  ToChat
//
//  Created by jft0m on 15/9/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFHeaderViewEntity.h"

@implementation JFHeaderViewEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    self = super.init;
    if (self) {
        self.fansCount = dictionary[@"fansCount"];
        self.followsCount = dictionary[@"followsCount"];
        self.isMe = dictionary[@"isMe"];
        self.isMan = dictionary[@"isMan"];
        self.follow = dictionary[@"follow"];
        self.followed = dictionary[@"followed"];
        self.userIconViewWith = dictionary[@"userIconViewWith"];
        self.username = dictionary[@"username"];
        self.avatar = dictionary[@"avatar"];
        self.bgImage = dictionary[@"bgImage"];
        self.IconImage = dictionary[@"IconImage"];
    }
    return self;
}

@end
