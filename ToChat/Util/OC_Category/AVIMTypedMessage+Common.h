//
//  AVIMTypedMessage+AVIMTypedMessage_Common.h
//  ToChat
//
//  Created by jft0m on 15/9/7.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "AVIMTypedMessage.h"
#import "JSQMessages.h"
@interface AVIMTypedMessage (Common)

- (JSQMessage *)toJSQMessagesWithSenderId:(NSString *)SenderId andDisplayName:(NSString *)displayName andDate:(NSDate *)date;

@end
