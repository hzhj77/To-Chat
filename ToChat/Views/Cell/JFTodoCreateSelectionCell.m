//
//  JFTodoCreateSelectionCell.m
//  ToChat
//
//  Created by syfll on 15/8/17.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "JFTodoCreateSelectionCell.h"

@interface JFTodoCreateSelectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation JFTodoCreateSelectionCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)ConfigeCell:(UIImage *)image leftText:(NSString *)leftText rightText:(NSString *)rightText{
    self.leftImageView.image = image;
    self.leftLabel.text = leftText;
    if (rightText) {
        self.rightLabel.text = rightText;
    }else{
        self.rightLabel.text = @"未设置";
    }
    
}

@end
