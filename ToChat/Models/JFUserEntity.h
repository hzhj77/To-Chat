//
//  JFUserEntity.h
//  ToChat
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFUserEntity : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (strong ,nonatomic) UIImage  *avatar;
@property (strong ,nonatomic) NSString *username;
@property (strong ,nonatomic) NSString *signature;

@end
