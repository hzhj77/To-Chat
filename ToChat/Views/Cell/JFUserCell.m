//
//  JFUserCell.m
//  ToChat
//
//  Created by jft0m on 15/9/3.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFUserCell.h"


@interface JFUserCell()
@property (weak, nonatomic) IBOutlet JFRoundImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *signature;

@end

@implementation JFUserCell

- (void)awakeFromNib {
}

- (void)config:(JFUserEntity *)eneity{
    if (eneity.avatar) {
        self.avatar.image = eneity.avatar;
    }else{
        self.avatar.image = [UIImage imageNamed:@"ToChat"];
    }
    
    self.username.text = eneity.username;
    
    if (eneity.signature) {
        self.signature.text = eneity.signature;
    }else{
        self.signature.text = @"还没有在数据表中添加个性签名，所以用这个暂时代替";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
