//
//  JFLiteUserCell.m
//  ToChat
//
//  Created by syfll on 15/8/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFLiteUserCell.h"

@implementation JFLiteUserCell

//- (void)awakeFromNib {
//    
//}

-(void)ConfigCell:(NSString *)userName avator:(UIImage *)avator followType:(LiteUserStyle)followType{
    
    assert(userName);
    self.userName.text = userName;
    //assert(avator);
    if (avator) {
        self.avatar.image = avator;
    }else{
        self.avatar.image = [UIImage imageNamed:@"ToChat"];
    }
    NSLog(@"%@",self.userName);
    NSLog(@"%@",self.avatar);
    switch (followType) {
        case LiteUserStyleNoStyle:
            self.FollowButton.hidden = YES;
            break;
        case LiteUserStyleNotFollow:
            [self.FollowButton setTitle:@"关注" forState:UIControlStateNormal];
            self.FollowButton.backgroundColor = [UIColor colorWithHexString:@"0x33CC00"];
            break;
        case LiteUserStyleBothFollow:
            [self.FollowButton setTitle:@"取消关注" forState:UIControlStateNormal];
            self.FollowButton.backgroundColor = [UIColor colorWithHexString:@"0xFF3333"];
            break;
        case LiteUserStyleHaveFollow:
            [self.FollowButton setTitle:@"互相关注" forState:UIControlStateNormal];
            self.FollowButton.backgroundColor = [UIColor colorWithHexString:@"0x3399FF"];
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)FollowButtonClicked:(id)sender {
    NSLog(@"点击了关注");
}
@end
