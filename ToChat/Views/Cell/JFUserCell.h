//
//  JFUserCell.h
//  ToChat
//
//  Created by jft0m on 15/9/3.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#define JF_USER_CELL @"JFUserCell"

#import <UIKit/UIKit.h>
#import "JFRoundImageView.h"
#import "JFUserEntity.h"

@interface JFUserCell : UITableViewCell

- (void)config:(JFUserEntity *)eneity;

@end
