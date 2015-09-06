//
//  JFDemoModelData.h
//  ChatUITest
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 jft0m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSQMessages.h"
#import "JFUserManager.h"

@interface JFDemoModelData : NSObject

@property (strong, nonatomic) JFUserManager *manager;

@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) NSMutableDictionary *avatars;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;

@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) NSMutableArray *users;

@property (copy, nonatomic) NSString *senderId;
@property (copy, nonatomic) NSString *senderDisplayName;

@end
