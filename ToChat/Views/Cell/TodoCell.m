//
//  TodoCell.m
//  ToChat
//
//  Created by syfll on 15/8/25.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "TodoCell.h"

@interface TodoCell(){
    UIImageView * userView ;
    UILabel *shortEventLabel;
    UILabel *eventTimeLabel;
    UILabel *userName;
    //包含了一张评论图片和评论数量的按钮（不能点击）
    UIButton *commentButton;
}
@end
@implementation TodoCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)commonInit{
    userView = [[UIImageView alloc]initWithFrame:CGRectZero];
    shortEventLabel  = [[UILabel alloc]initWithFrame:CGRectZero];
    eventTimeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    userName = [[UILabel alloc]initWithFrame:CGRectZero];
    commentButton = [[UIButton alloc]initWithFrame:CGRectZero];
    
    
    userView.backgroundColor = [UIColor clearColor];
    userView.contentMode = UIViewContentModeScaleAspectFit;
    [userView setTranslatesAutoresizingMaskIntoConstraints:false];
    
    shortEventLabel.textAlignment  = NSTextAlignmentLeft;
    shortEventLabel.font = [UIFont systemFontOfSize:12];
    shortEventLabel.textColor = [UIColor blackColor];
    [shortEventLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    
    eventTimeLabel.textAlignment  = NSTextAlignmentLeft;
    eventTimeLabel.font = [UIFont systemFontOfSize:8];
    eventTimeLabel.textColor = [UIColor groupTableViewBackgroundColor];
    [eventTimeLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    
    userName.textAlignment  = NSTextAlignmentLeft;
    userName.font = [UIFont systemFontOfSize:8];
    userName.textColor = [UIColor grayColor];
    [userName setTranslatesAutoresizingMaskIntoConstraints:false];
    
    
    commentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    commentButton.titleLabel.font = [UIFont systemFontOfSize:8];
    commentButton.backgroundColor = [UIColor clearColor];
    //commentButton.imageView?.image = UIImage(named: "time_clock_icon")
    
    [self.contentView addSubview:userView];
    [self.contentView addSubview:shortEventLabel];
    [self.contentView addSubview:eventTimeLabel];
    [self.contentView addSubview:userName];
    [self.contentView addSubview:commentButton];
}

@end
