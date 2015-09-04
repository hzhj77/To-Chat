//
//  JFEaseUserHeaderView.h
//  ToChat
//
//  Created by jft0m on 15/9/3.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "UITapImageView.h"
#import "JFHeaderViewEntity.h"

@interface JFEaseUserHeaderView : UITapImageView

@property (strong, nonatomic) JFHeaderViewEntity *entity;
@property (strong, nonatomic) UIImage *bgImage;

@property (nonatomic, copy) void (^userIconClicked)();
@property (nonatomic, copy) void (^fansCountBtnClicked)();
@property (nonatomic, copy) void (^followsCountBtnClicked)();
@property (nonatomic, copy) void (^followBtnClicked)();

- (void)config:(JFHeaderViewEntity *)entity;

@end
