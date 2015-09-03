//
//  JFEaseUserHeaderView.m
//  ToChat
//
//  Created by jft0m on 15/9/3.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFEaseUserHeaderView.h"

#define EaseUserHeaderView_Height_Me kScaleFrom_iPhone5_Desgin(190)
#define EaseUserHeaderView_Height_Other kScaleFrom_iPhone5_Desgin(250)

@interface JFEaseUserHeaderView ()

/// 用户头像
@property (strong, nonatomic) UITapImageView *userIconView;
/// 用户性别图像
@property (strong, nonatomic) UITapImageView *userSexIconView;
/// 用户名
@property (strong, nonatomic) UILabel *userLabel;
/// 粉丝数量按钮
@property (strong, nonatomic) UIButton *fansCountBtn;
/// 关注数量按钮
@property (strong, nonatomic) UIButton *followsCountBtn;
/// 关注按钮
@property (strong, nonatomic) UIButton *followBtn;
/// 粉丝数量按钮和关注数量按钮之间的分界线
@property (strong, nonatomic) UIView *splitLine;
/// 遮罩层
@property (strong, nonatomic) UIView *coverView;

@property (assign, nonatomic) CGFloat userIconViewWith;

@end

@implementation JFEaseUserHeaderView

-(void)configViw{
    
    BOOL isMe  = YES;
    BOOL isMan = YES;
    BOOL follow = YES;
    BOOL followed = YES;
    
    NSURL *avatar = [[NSURL alloc]initFileURLWithPath:@"http://img0.bdstatic.com/img/image/shouye/touxiang902.jpg"];
    
    int fans_count = 11;
    int follows_count = 11;
    
    [self initView:isMe];
    
    self.image = _bgImage;

    [_userIconView sd_setImageWithURL:avatar placeholderImage:kPlaceholderMonkeyRoundWidth(54.0)];
    //_userIconView.image = [UIImage imageNamed:@"icon_user_monkey"];
    if (isMan) {
        //男
        [_userSexIconView setImage:[UIImage imageNamed:@"n_sex_man_icon"]];
        _userSexIconView.hidden = NO;
    }else{
        //女
        [_userSexIconView setImage:[UIImage imageNamed:@"n_sex_woman_icon"]];
        _userSexIconView.hidden = NO;
    }
    _userLabel.text = _curUser.name;
    [_userLabel sizeToFit];
    
    [_fansCountBtn setAttributedTitle:[self getStringWithTitle:@"粉丝"
                                                      andValue:[NSString stringWithFormat:@"%d",fans_count]]
                             forState:UIControlStateNormal];
    [_followsCountBtn setAttributedTitle:[self getStringWithTitle:@"关注" andValue:[NSString stringWithFormat:@"%d",follows_count]] forState:UIControlStateNormal];
    
    NSString *imageName;
    if (followed) {
        if (follow) {
            imageName = @"n_btn_followed_both";
        }else{
            imageName = @"n_btn_followed_yes";
        }
    }else{
        imageName = @"n_btn_followed_not";
    }
    [_followBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

}

#pragma mark - init

-(void)initView:(BOOL)isMe{
    
    __weak typeof(self) weakSelf = self;
    
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [self addSubview:_coverView];
    }
    
    if (!_userIconView) {
        _userIconView = [[UITapImageView alloc] init];
        _userIconView.backgroundColor = kColorTableBG;
        [_userIconView setTapBlock:^(id obj) {
            if (weakSelf.userIconClicked) {
                weakSelf.userIconClicked();
            }
        }];
        [self addSubview:_userIconView];
    }
    
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
        _userLabel.font = [UIFont boldSystemFontOfSize:18];
        _userLabel.textColor = [UIColor whiteColor];
        _userLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_userLabel];
    }
    
    if (!_userSexIconView) {
        _userSexIconView = [[UITapImageView alloc] init];
        [_userIconView doBorderWidth:1.0 color:nil cornerRadius:_userIconViewWith/2];
        [self addSubview:_userSexIconView];
    }

    if (!_fansCountBtn) {
        _fansCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fansCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_fansCountBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.fansCountBtnClicked) {
                weakSelf.fansCountBtnClicked();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fansCountBtn];
    }
    
    if (!_followsCountBtn) {
        _followsCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _followsCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_followsCountBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.followsCountBtnClicked) {
                weakSelf.followsCountBtnClicked();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_followsCountBtn];
    }
    
    if (!_splitLine) {
        _splitLine = [[UIView alloc] init];
        _splitLine.backgroundColor = [UIColor colorWithHexString:@"0xcacaca"];
        [self addSubview:_splitLine];
    }
    
    if (!_followBtn) {
        _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.followBtnClicked) {
                weakSelf.followBtnClicked();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_followBtn];
    }
    CGFloat viewHeight = isMe? EaseUserHeaderView_Height_Me: EaseUserHeaderView_Height_Other;
    [self setFrame:CGRectMake(0, 0, kScreen_Width, viewHeight)];
    [self updateConstraints:isMe];

}
-(void)updateConstraints:(BOOL)isMe{
    
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_userIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_userIconViewWith, _userIconViewWith));
        make.bottom.equalTo(_userLabel.mas_top).offset(-15);
        make.centerX.equalTo(self);
    }];
    
    CGFloat userSexIconViewWidth = (14);
    [_userSexIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(userSexIconViewWidth, userSexIconViewWidth));
        make.left.equalTo(_userLabel.mas_right).offset(5);
        make.centerY.equalTo(_userLabel);
    }];
    
    [_fansCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(_splitLine.mas_left).offset(kScaleFrom_iPhone5_Desgin(-15));
        make.bottom.equalTo(self.mas_bottom).offset(kScaleFrom_iPhone5_Desgin(-15));
    }];
    
    [_followsCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(_splitLine.mas_right).offset(kScaleFrom_iPhone5_Desgin(15));
        make.height.equalTo(@[_fansCountBtn.mas_height, @kScaleFrom_iPhone5_Desgin(20)]);
    }];
    
    [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(@[_fansCountBtn, _followsCountBtn]);
        make.size.mas_equalTo(CGSizeMake(0.5, 15));
    }];
    
    if (!isMe) {
        [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_fansCountBtn.mas_top).offset(-20);
            make.size.mas_equalTo(CGSizeMake(128, 39));
            make.centerX.equalTo(self);
        }];
        
        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_followBtn.mas_top).offset(kScaleFrom_iPhone5_Desgin(-25));
            make.height.mas_equalTo(kScaleFrom_iPhone5_Desgin(20));
        }];
    }else{
        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_fansCountBtn.mas_top).offset(kScaleFrom_iPhone5_Desgin(-20));
            make.centerX.equalTo(self.mas_centerX).offset(-userSexIconViewWidth);
            make.height.mas_equalTo(kScaleFrom_iPhone5_Desgin(20));
        }];
    }


}

- (NSMutableAttributedString*)getStringWithTitle:(NSString *)title andValue:(NSString *)value{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", value, title]];
    [attrString addAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17],
                                NSForegroundColorAttributeName : [UIColor whiteColor]}
                        range:NSMakeRange(0, value.length)];
    
    [attrString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                NSForegroundColorAttributeName : [UIColor whiteColor]}
                        range:NSMakeRange(value.length+1, title.length)];
    return  attrString;
}

@end
