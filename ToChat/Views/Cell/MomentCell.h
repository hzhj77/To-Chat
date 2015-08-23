//
//  MomentCell.h
//  ToChat
//
//  Created by syfll on 15/8/12.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "BaseCell.h"
#import "Tweet.h"

#define JF_Moment_Cell @"MomentCell"
typedef void (^UserBtnClickedBlock) (User *curUser);

@interface MomentCell : BaseCell

///存储了这条动态（tweet）的内容
@property (strong,nonatomic)Tweet *tweet;

///用来存储这条动态（tweet）的图片内容
@property (strong, nonatomic) NSMutableDictionary *imageViewsDict;

-(void)updateFonts;

@property (nonatomic, copy) UserBtnClickedBlock userBtnClickedBlock;
@end
