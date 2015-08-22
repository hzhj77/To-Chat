//
//  UITapImageView.h
//  Step-it-up
//
//  Created by syfll on 15/7/30.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapImageView : UIImageView

/** 设定图片点击后的回调block
 @param tapAction 回调block
 */
- (void)setTapBlock:(void(^)(id obj))tapAction;

/** 设定图片内容
 @param imgUrl 图片的地址
 @param placeholderImage 旧的图片（没有缓存时用的图片）
 @param tapAction 点击图片后回调的block
 */
-(void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage tapBlock:(void(^)(id obj))tapAction;
@end
