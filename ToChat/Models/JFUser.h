//
//  JFUser.h
//  ToChat
//
//  Created by syfll on 15/8/26.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>

static NSString *const JFUserKeyAvatar = @"avatar";
static NSString *const JFUserKeyUserID = @"userID";
static NSString *const JFUserKeyName = @"name";
static NSString *const JFUserKeyPingyinName = @"pingyinName";
static NSString *const JFUserKeyAge = @"age";
static NSString *const JFUserKeyGender = @"gender";

typedef enum{
    GenderUnkonwn=0,
    GenderMale=1,
    GenderFamale
}GenderType;

@interface JFUser : AVObject<AVSubclassing>

@property (nonatomic, strong) AVFile *avatar;
@property (nonatomic, copy)   NSString *userID;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *pinyinName;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) GenderType gender;
@end
