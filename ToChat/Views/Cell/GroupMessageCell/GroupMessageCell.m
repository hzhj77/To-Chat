//
//  GroupMessageCell.m
//  ToChat
//
//  Created by chenlong on 15/9/12.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "GroupMessageCell.h"

@implementation GroupMessageCell

- (void)awakeFromNib {
    // Initialization code
    self.groupImgV.layer.masksToBounds = YES;
    self.groupImgV.layer.cornerRadius = 30;
    
    self.msgNumLabel.layer.masksToBounds = YES;
    self.msgNumLabel.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
