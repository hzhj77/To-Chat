//
//  GroupMemberCell.m
//  ToChat
//
//  Created by chenlong on 15/9/11.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "GroupMemberCell.h"
#import "Header.h"

@implementation GroupMemberCell{
    UIImageView* avatar;
    UILabel* name;
    UILabel* content;
    UIImageView* imgV;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){

        avatar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
        avatar.image = [UIImage imageNamed:@"ToChat"];
        avatar.layer.masksToBounds = YES;
        avatar.layer.cornerRadius = 25;
        [self.contentView addSubview:avatar];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, 150, 25)];
        name.text = @"hzhj";
        [self.contentView addSubview:name];
        
        imgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width - 70, 5, 60, 60)];
        imgV.image = [UIImage imageNamed:@"ToChat"];
        [self.contentView addSubview:imgV];
        
        content = [[UILabel alloc]initWithFrame:CGRectMake(75, 40, kScreen_Width - 90 - imgV.width, 20)];
        content.text = @"李舒是傻逼！李舒是傻逼！李舒是傻逼！李舒是傻逼！";
        content.font = [UIFont systemFontOfSize:14];
        content.textColor = [UIColor grayColor];
        [self.contentView addSubview:content];
        
        self.height = 70;
    }
    return self;
}

-(void)setCellWithData:(NSMutableArray *)data{
    
}

@end
