//
//  JFRoundUIButton.m
//  ToChat
//
//  Created by syfll on 15/8/27.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "JFRoundUIButton.h"

@implementation JFRoundUIButton

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0?true:false;
}

@end
