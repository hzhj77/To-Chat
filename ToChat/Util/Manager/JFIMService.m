//
//  JFIMService.m
//  ToChat
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFIMService.h"

@implementation JFIMService

+ (instancetype)service {
    static JFIMService *imService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imService = [[JFIMService alloc] init];
    });
    return imService;
}

- (void)goWithUserId:(NSString *)userId fromVC:(JFViewController *)vc {
    [[CDChatManager manager] fetchConvWithOtherId:userId callback: ^(AVIMConversation *conversation, NSError *error) {
        if ([vc filterError:error]) {
            //[self goWithConv:conversation fromNav:vc.navigationController];
        }
    }];
}

@end
