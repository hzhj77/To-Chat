//
//  JFDemoModelData.m
//  ChatUITest
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 jft0m. All rights reserved.
//

#import "JFDemoModelData.h"

@implementation JFDemoModelData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
        self.messages = [[NSMutableArray alloc]initWithCapacity:15];
        self.users = [[NSMutableArray alloc]initWithCapacity:2];
        self.manager = [JFUserManager manager];
        self.avatars = [[NSMutableDictionary alloc]initWithCapacity:2];
    }
    
    return self;
}


- (NSString *)senderId{
    return [self.manager getCurrentUser].objectId;
}

- (NSString *)senderDisplayName{
    return [self.manager getCurrentUser].username;
}

@end
