//
//  AVIMTypedMessage+AVIMTypedMessage_Common.m
//  ToChat
//
//  Created by jft0m on 15/9/7.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "AVIMTypedMessage+Common.h"

@implementation AVIMTypedMessage (Common)

- (JSQMessage *)toJSQMessagesWithSenderId:(NSString *)SenderId andDisplayName:(NSString *)displayName andDate:(NSDate *)date{
    if(!displayName){
        displayName = @"用户名没有设置";
    }
    return [[JSQMessage alloc] initWithSenderId:SenderId
                       senderDisplayName:displayName
                                    date:date
                                    text:self.text];
}


@end
