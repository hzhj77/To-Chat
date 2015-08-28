//
//  JFBackgroundImageTableView.m
//  ToChat
//
//  Created by syfll on 15/8/28.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFBackgroundImageTableView.h"

@implementation JFBackgroundImageTableView

-(void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    assert(backgroundImage);
    self.backgroundView = [[UIImageView alloc]initWithImage:backgroundImage];
}
//-(void)setBottomLeftButtonTitle:(NSString *)bottomLeftButtonTitle{
////    self.backgroundColor = [UIColor redColor];
//    self.forgetBtn = [[UIButton alloc]initWithFrame:CGRectZero];
//        [self addSubview:self.forgetBtn];
//        [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@20);
//            make.width.equalTo(@40);
//            make.left.equalTo(self.mas_right).offset(20);
//            make.bottom.equalTo(self.mas_bottom).offset(20);
//        }];
//        //self.forgetBtn.title = bottomLeftButtonTitle;
//        self.forgetBtn.backgroundColor = [UIColor redColor];
//
//}
//
//-(void)setBottomRightButtonTitle:(UIButton *)bottomRightButtonTitle{
//    
//}

@end
