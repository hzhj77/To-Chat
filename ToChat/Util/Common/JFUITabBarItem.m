//
//  JFUITabBarItem.m
//  oikjtihj
//
//  Created by syfll on 15/8/28.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFUITabBarItem.h"

@implementation JFUITabBarItem

-(void)setNomalImage:(UIImage *)nomalImage{

    _nomalImage = nomalImage;
    self.image = [[_nomalImage scaledToSize:CGSizeMake(40, 40)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)setSelectImage:(UIImage *)selectImage{
    _selectImage = selectImage;
    self.selectedImage = [[_selectImage scaledToSize:CGSizeMake(40, 40)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
