//
//  JFDemoModelData.h
//  ChatUITest
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 jft0m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSQMessages.h"

static NSString * const kJFDemoAvatarDisplayNameWoz = @"Steve Wozniak";
static NSString * const kJFDemoAvatarDisplayNameJon = @"Mike Jone";

static NSString * const kJFDemoAvatarIdWoz = @"654321";
static NSString * const kJFDemoAvatarIdJon = @"123456";

@interface JFDemoModelData : NSObject

@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) NSDictionary *avatars;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;

@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) NSDictionary *users;

- (void)addPhotoMediaMessage;

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion;

- (void)addVideoMediaMessage;

@end
