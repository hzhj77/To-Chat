//
//  JFUserEntity.m
//  ToChat
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFUserEntity.h"

@implementation JFUserEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    self = super.init;
    if (self) {
        self.username = dictionary[@"username"];
        self.avatar = dictionary[@"avatar"];
        self.signature = dictionary[@"signature"];
    }
    return self;
}

@end
