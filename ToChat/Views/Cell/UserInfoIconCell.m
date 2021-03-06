//
//  UserInfoIconCel.m
//  ToChat
//
//  Created by jft0m on 15/9/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "UserInfoIconCell.h"

@interface UserInfoIconCell ()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleL;
@end

@implementation UserInfoIconCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!_iconView) {
            _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(kPaddingLeftWidth, 10, 24, 24)];
            [self.contentView addSubview:_iconView];
        }
        if (!_titleL) {
            _titleL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame) + kPaddingLeftWidth, 12, kScreen_Width/2, 20)];
            _titleL.textAlignment = NSTextAlignmentLeft;
            _titleL.font = [UIFont systemFontOfSize:15];
            _titleL.textColor = [UIColor colorWithHexString:@"0x222222"];
            [self.contentView addSubview:_titleL];
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title icon:(NSString *)iconName{
    _titleL.text = title;
    _iconView.image = [UIImage imageNamed:iconName];
}

+ (CGFloat)cellHeight{
    return 44;
}

@end

