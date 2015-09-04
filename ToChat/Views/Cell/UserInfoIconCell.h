//
//  UserInfoIconCel.h
//  ToChat
//
//  Created by jft0m on 15/9/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#define kCellIdentifier_UserInfoIconCell @"UserInfoIconCell"

#import <UIKit/UIKit.h>

@interface UserInfoIconCell : UITableViewCell
- (void)setTitle:(NSString *)title icon:(NSString *)iconName;
+ (CGFloat)cellHeight;
@end
