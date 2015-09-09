//
//  JFOtherUserHeaderView.m
//  ToChat
//
//  Created by jft0m on 15/9/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFOtherUserHeaderView.h"

#define EaseUserHeaderView_Height kScaleFrom_iPhone5_Desgin(230)

@interface JFOtherUserHeaderView ()

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

@property (assign, nonatomic) BOOL isMe;

@end

@implementation JFOtherUserHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)config:(JFHeaderViewEntity *)entity{
    
    /**
     *  设置一部分局部数据
     */
    _isMe = entity.isMe.boolValue;
    
    self.entity = entity;
    int fansCount = entity.fansCount.intValue;
    int followsCount = entity.followsCount.intValue;
    
    
    BOOL isMan = entity.isMan.boolValue;
    BOOL follow = entity.follow.boolValue;
    BOOL followed = entity.followed.boolValue;
    
    if (entity.userIconViewWith != nil) {
        _userIconViewWith = entity.userIconViewWith.floatValue;
    }else{
        if (kDevice_Is_iPhone6Plus) {
            _userIconViewWith = 100;
        }else if (kDevice_Is_iPhone6){
            _userIconViewWith = 90;
        }else{
            _userIconViewWith = 75;
        }
    }
    
    NSString *username = entity.username;
    NSURL *avatar = entity.avatar;
    UIImage *bgImage = entity.bgImage;
    UIImage *IconImage = entity.IconImage;
    
    self.image = bgImage;
    
    /**
     *  修改界面属性
     */
    
    //用户头像
    [_userIconView sd_setImageWithURL:avatar placeholderImage:kPlaceholderMonkeyRoundWidth(54.0)];
    _userIconView.image = IconImage;
    
    //性别图标
    if (isMan) {
        //男
        [_userSexIconView setImage:[UIImage imageNamed:@"n_sex_man_icon"]];
        _userSexIconView.hidden = NO;
    }else{
        //女
        [_userSexIconView setImage:[UIImage imageNamed:@"n_sex_woman_icon"]];
        _userSexIconView.hidden = NO;
    }
    
    //用户名
    _userLabel.text = username;
    [_userLabel sizeToFit];
    
    //粉丝数量
    [_fansCountBtn setAttributedTitle:[self getStringWithTitle:@"粉丝"
                                                      andValue:[NSString stringWithFormat:@"%d",fansCount]]
                             forState:UIControlStateNormal];
    //关注数量
    [_followsCountBtn setAttributedTitle:[self getStringWithTitle:@"关注" andValue:[NSString stringWithFormat:@"%d",followsCount]] forState:UIControlStateNormal];
    
    
    //关注按钮
    _followBtn.hidden = NO;
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
    
    
    //更新界面限制
    [self setNeedsUpdateConstraints];
    
}

#pragma mark - initView

-(void)initView{
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat viewHeight = EaseUserHeaderView_Height;
    
    if (kDevice_Is_iPhone6Plus) {
        _userIconViewWith = 100;
    }else if (kDevice_Is_iPhone6){
        _userIconViewWith = 90;
    }else{
        _userIconViewWith = 75;
    }
    [self setFrame:CGRectMake(0, 0, kScreen_Width, viewHeight)];
    
    
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
    
    
}
-(void)updateConstraints{
    
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
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_fansCountBtn.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(128, 39));
        make.centerX.equalTo(self);
    }];
    
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_followBtn.mas_top).offset(kScaleFrom_iPhone5_Desgin(-10));
        make.centerX.equalTo(self.mas_centerX).offset(-userSexIconViewWidth);
        make.height.mas_equalTo(kScaleFrom_iPhone5_Desgin(20));
    }];
    
    [super updateConstraints];
    
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
