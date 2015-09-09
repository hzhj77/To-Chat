//
//  JFLiteUserCell.h
//  ToChat
//
//  Created by syfll on 15/8/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#define JF_Lite_User_Cell @"LiteUserCell"

#import <UIKit/UIKit.h>
#import "JFRoundImageView.h"
#import "JFRoundUIButton.h"
typedef NS_ENUM(NSInteger, LiteUserStyle) {
    LiteUserStyleNoStyle        = -2,//Hiden follow button
    LiteUserStyleNotFollow      = -1,
    LiteUserStyleHaveFollow     = 0,
    LiteUserStyleBothFollow     = 1
};

@interface JFLiteUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet JFRoundImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet JFRoundUIButton *FollowButton;

-(void)ConfigCell:(NSString *)userName avator:(UIImage *)avator followType:(LiteUserStyle)followType;
@end
