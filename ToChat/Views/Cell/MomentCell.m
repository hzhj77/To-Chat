//
//  MomentCell.m
//  ToChat
//
//  Created by syfll on 15/8/12.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "MomentCell.h"
#import "UITTTAttributedLabel.h"
#import "UICustomCollectionView.h"
#import "TweetMediaItemCCell.h"
#import "TweetMediaItemSingleCCell.h"
#import "TweetLikeUserCCell.h"
#import "TweetCommentCell.h"
#import "TweetCommentMoreCell.h"

#import "Tweet.h"

@interface MomentCell()<UICollectionViewDelegate,UICollectionViewDataSource>
/// 标记是否已经设置了限制
@property (nonatomic, assign) BOOL didSetupConstraints;

///底部白色的背景图片
@property (strong, nonatomic) UIView *whiteBackView;
///用来显示用户头像
@property (strong, nonatomic) UITapImageView *ownerImgView;
///用来显示用户昵称
@property (strong, nonatomic) UIButton *ownerNameBtn;
///用来显示这条动态（tweet）的文字内容
@property (strong, nonatomic) UILabel *contentLabel;
///用来显示这条动态（tweet）发表的时间
@property (strong, nonatomic) UILabel *timeLabel;
///这条动态（tweet）发表的时间前面的闹钟图案
@property (strong, nonatomic) UIImageView *timeClockIconView;
///用来显示这条动态（tweet）发表的设备
@property (strong, nonatomic) UILabel *deviceLabel;
///用来显示这条动态（tweet）发表的地点
@property (strong, nonatomic) UIButton *locaitonBtn;
///点击显示更多的contentLabel内容
@property (strong, nonatomic) UIButton *showMoreBtn;
///点赞按钮
@property (strong, nonatomic) UIButton *likeBtn;
///评论按钮
@property (strong, nonatomic) UIButton *commentBtn;
///删除按钮（只有自己发表的）
@property (strong, nonatomic) UIButton *deleteBtn;
///用来显示点赞的人
@property (strong, nonatomic) UICollectionView *likeUsersView;
///用来显示用户评论
@property (strong, nonatomic) UITableView *commentListView;
///用来显示这条动态（tweet）的图片内容
@property (strong, nonatomic) UICustomCollectionView *mediaView;

@end
@implementation MomentCell
@synthesize tweet = _tweet;


#pragma mark - property
-(void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    //owner头像
    __weak __typeof(self)weakSelf = self;
    [self.ownerImgView setImageWithUrl:[tweet.user.avatar urlImageWithCodePathResizeToView:_ownerImgView] placeholderImage:kPlaceholderMonkeyRoundView(_ownerImgView) tapBlock:^(id obj) {
        [weakSelf userBtnClicked];
    }];
    [self.ownerImgView doCircleFrame];
    
    //owner姓名
    [self.ownerNameBtn setTitle:tweet.user.name forState:UIControlStateNormal];
    //moment的文字内容
    self.contentLabel.text = tweet.content;
    //时间
    self.timeLabel.text =  [tweet.time stringTimesAgo];
    //设备名
    self.deviceLabel.text = tweet.device;
    //地理信息
    [self.locaitonBtn setTitle:tweet.location forState:UIControlStateNormal];
    //点赞人数
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)tweet.numOfLikers] forState:UIControlStateNormal];
    //评论人数
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",(long)tweet.numOfComments] forState:UIControlStateNormal];
    
}

#pragma mark - init self
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadViews];
    }
    return self;
}
#pragma mark - View
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);
    self.timeLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.timeLabel.frame);
    
}
-(void)loadViews{
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
    if (!self.whiteBackView) {
        self.whiteBackView = [[UIView alloc]initWithFrame:CGRectZero];
        self.whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.whiteBackView];
    }
    //用户头像
    if (!self.ownerImgView) {
        self.ownerImgView = [[UITapImageView alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:self.ownerImgView];
    }
    //用户昵称
    if (!self.ownerNameBtn) {
        self.ownerNameBtn = [UIButton initUserButton];
        self.ownerNameBtn.frame = CGRectZero;
        [self.ownerNameBtn addTarget:self action:@selector(userBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.ownerNameBtn];
    }
    //发表的时间
    if (!self.timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel.font = kTweet_TimtFont;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
        [self.contentView addSubview:self.timeLabel];
    }
    //发表的时间前面的闹钟图案
    if (!self.timeClockIconView) {
        self.timeClockIconView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.timeClockIconView.image = [UIImage imageNamed:@"time_clock_icon"];
        [self.contentView addSubview:self.timeClockIconView];
    }
    //动态（tweet）的内容
    if (!self.contentLabel) {
        self.contentLabel = [[UITTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.contentLabel.font = kTweet_ContentFont;
        self.contentLabel.textColor = [UIColor colorWithHexString:@"0x222222"];
        self.contentLabel.numberOfLines = 6;
        
        [self.contentView addSubview:self.contentLabel];
    }
    //评论按钮
    if (!self.commentBtn) {
        self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentBtn.frame = CGRectZero;
        [self.commentBtn setImage:[UIImage imageNamed:@"tweet_comment_btn"] forState:UIControlStateNormal];
        [self.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.commentBtn];
    }
    //点赞按钮
    if (!self.likeBtn) {
        self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.likeBtn.frame = CGRectZero;
        [self.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.likeBtn];
    }
    //删除按钮(先初始化了，哪怕后面不用)
    if (!self.deleteBtn) {
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = CGRectZero;
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor colorWithHexString:@"0x3bbd79"] forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        self.deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.deleteBtn];
    }
    //动态（tweet）发表的地点(先初始化了，哪怕后面不用)
    if (!self.locaitonBtn) {
        self.locaitonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.locaitonBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.locaitonBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.locaitonBtn.frame = CGRectZero;
        self.locaitonBtn.titleLabel.adjustsFontSizeToFitWidth = NO;
        self.locaitonBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.locaitonBtn setTitleColor:[UIColor colorWithHexString:@"0x3bbd79"] forState:UIControlStateNormal];
        [self.locaitonBtn addTarget:self action:@selector(locationBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.locaitonBtn];
    }
    //动态（tweet）发表的设备(先初始化了，哪怕后面不用)
    if (!self.deviceLabel) {
        self.deviceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.deviceLabel.font = kTweet_TimtFont;
        self.deviceLabel.minimumScaleFactor = 0.50;
        self.deviceLabel.adjustsFontSizeToFitWidth = YES;
        self.deviceLabel.textAlignment = NSTextAlignmentLeft;
        self.deviceLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
        [self.contentView addSubview:self.deviceLabel];
    }
    
    if (!self.likeUsersView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.likeUsersView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.likeUsersView.scrollEnabled = NO;
        [self.likeUsersView setBackgroundView:nil];
        [self.likeUsersView setBackgroundColor:kColorTableSectionBg];
        [self.likeUsersView registerClass:[TweetLikeUserCCell class] forCellWithReuseIdentifier:kCCellIdentifier_TweetLikeUser];
        self.likeUsersView.dataSource = self;
        self.likeUsersView.delegate = self;
        [self.contentView addSubview:self.likeUsersView];
    }
    
    if (!self.mediaView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.mediaView = [[UICustomCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.mediaView.scrollEnabled = NO;
        [self.mediaView setBackgroundView:nil];
        [self.mediaView setBackgroundColor:[UIColor clearColor]];
        [self.mediaView registerClass:[TweetMediaItemCCell class] forCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItem];
        [self.mediaView registerClass:[TweetMediaItemSingleCCell class] forCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItemSingle];
        self.mediaView.dataSource = self;
        self.mediaView.delegate = self;
        [self.contentView addSubview:self.mediaView];
    }
    
    
    if (!self.commentListView) {
        self.commentListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.commentListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.commentListView.scrollEnabled = NO;
        [self.commentListView setBackgroundView:nil];
        [self.commentListView setBackgroundColor:kColorTableSectionBg];
        [self.commentListView registerClass:[TweetCommentCell class] forCellReuseIdentifier:kCellIdentifier_TweetComment];
        [self.commentListView registerClass:[TweetCommentMoreCell class] forCellReuseIdentifier:kCellIdentifier_TweetCommentMore];
        //self.commentListView.dataSource = self;
        //self.commentListView.delegate = self;
        [self.contentView addSubview:self.commentListView];
    }
    self.showMoreBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    //[self.contentView addSubview:self.showMoreBtn];
    self.showMoreBtn.backgroundColor = [UIColor redColor];

    
}

#pragma mark - Constraints

-(void)updateConstraints{
    if(!self.didSetupConstraints){
        [self.whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-5);
            make.top.and.bottom.equalTo(self.contentView);
        }];
        [self.ownerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self.whiteBackView).offset(5);
            make.height.and.width.equalTo(@50);
        }];
        [self.ownerNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.ownerImgView);
            make.left.equalTo(self.ownerImgView.mas_right).offset(3);
            
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ownerImgView.mas_right).offset(2);
            make.top.equalTo(self.ownerImgView.mas_bottom).offset(2);
            make.right.equalTo(self.whiteBackView).offset(10);
        }];
//        [self.showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentLabel.mas_left);
//            make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
//        }];
        [self.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel.mas_left);
            make.top.equalTo(self.contentLabel.mas_bottom);
            make.right.equalTo(self.whiteBackView.mas_right);
            //debug
            //self.mediaView.backgroundColor = [UIColor redColor];
            make.height.equalTo(@100);
        }];
        [self.locaitonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel);
            make.top.equalTo(self.mediaView.mas_bottom);
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel);
            make.top.equalTo(self.locaitonBtn.mas_bottom);
        }];
        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.commentBtn.mas_left);
            make.bottom.equalTo(self.timeLabel);
        }];
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteBackView);
            make.bottom.equalTo(self.timeLabel);
        }];
        [self.likeUsersView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ownerImgView.mas_right);
            make.top.equalTo(self.timeLabel.mas_bottom);
            make.right.equalTo(self.whiteBackView);
            //debug
            self.likeUsersView.backgroundColor = [UIColor blueColor];
            make.height.equalTo(@20);
            
        }];
        [self.commentListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ownerImgView.mas_right);
            make.top.equalTo(self.likeUsersView.mas_bottom);
            make.right.equalTo(self.whiteBackView.mas_right);
            make.bottom.equalTo(self.whiteBackView);
            //debug
            self.commentListView.backgroundColor = [UIColor greenColor];
            make.height.equalTo(@40);
        }];
        
    }
    
    
    self.didSetupConstraints = true;
    
    [super updateConstraints];
}

- (void)updateFonts{
    
}

#pragma mark Collection M
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger row = 0;
    if (collectionView == _mediaView) {
        row = _tweet.htmlMedia.imageItems.count;
    }else{
        row = _tweet.numOfLikers;
    }
    return row;
}
//页面里面的两个collectionView（用来显示图片和显示点赞的用户的头像）都用到这个函数所以需要判断
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //两个collectionView都用到这个函数
    if (collectionView == _mediaView) {
        HtmlMediaItem *curMediaItem = [_tweet.htmlMedia.imageItems objectAtIndex:indexPath.row];
        if (_tweet.htmlMedia.imageItems.count == 1) {
            TweetMediaItemSingleCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItemSingle forIndexPath:indexPath];
            ccell.curMediaItem = curMediaItem;
            [_imageViewsDict setObject:ccell.imgView forKey:indexPath];
            return ccell;
        }else{
            TweetMediaItemCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItem forIndexPath:indexPath];
            ccell.curMediaItem = curMediaItem;
            [_imageViewsDict setObject:ccell.imgView forKey:indexPath];
            return ccell;
        }
    }else{
        TweetLikeUserCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_TweetLikeUser forIndexPath:indexPath];
        if (indexPath.row >= _tweet.numOfLikers-1 && _tweet.hasMoreLikers) {
            [ccell configWithUser:nil likesNum:[[NSNumber alloc]initWithInteger: _tweet.numOfLikers]];
        }else{
            User *curUser = [_tweet.like_users objectAtIndex:indexPath.row];
            [ccell configWithUser:curUser likesNum:nil];
        }
        return ccell;
    }
}

#pragma mark - Block
- (void)userBtnClicked{
    if (_userBtnClickedBlock) {
        _userBtnClickedBlock(_tweet.user);
    }
}

@end
