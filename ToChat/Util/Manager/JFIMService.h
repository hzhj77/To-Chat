//
//  JFIMService.h
//  ToChat
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LeanChatLib/CDChatManager.h>
#import "JFViewController.h"

@interface JFIMService : NSObject<CDUserDelegate>

+ (instancetype)service;

@end
