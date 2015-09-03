//
//  JFUser.m
//  ToChat
//
//  Created by syfll on 15/8/26.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "JFUser.h"

@implementation JFUser
@dynamic avatar, userID,name ,pinyinName ,age ,gender;

+ (NSString *)parseClassName {
    return @"_User";
}

-(void)setAvatar:(AVFile *)avatar{
    
}

@end
