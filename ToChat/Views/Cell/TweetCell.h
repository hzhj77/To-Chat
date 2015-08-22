//
//  TweetCell.h
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tweet.h"
#import "Tweet+Size.h"
#import "UITTTAttributedLabel.h"
#import "UICustomCollectionView.h"
#import "TweetMediaItemCCell.h"
#import "TweetMediaItemSingleCCell.h"
#import "TweetLikeUserCCell.h"
#import "TweetCommentCell.h"
#import "TweetCommentMoreCell.h"

#import "Login.h"

#define kCellIdentifier_Tweet @"TweetCell"

typedef void (^CommentClickedBlock) (Tweet *curTweet, NSInteger index, id sender);
typedef void (^DeleteClickedBlock) (Tweet *curTweet, NSInteger outTweetsIndex);
typedef void (^LikeBtnClickedBlock) (Tweet *curTweet);
typedef void (^UserBtnClickedBlock) (User *curUser);
typedef void (^MoreLikersBtnClickedBlock) (Tweet *curTweet);
typedef void (^LocationClickedBlock) (Tweet *curTweet);

@interface TweetCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, TTTAttributedLabelDelegate>
///Model


/// 存储了这条动态（tweet）的内容
@property (strong,nonatomic)Tweet *tweet;
/// 用来显示用户头像
@property (strong, nonatomic) UITapImageView *ownerImgView;
/// 用来显示用户昵称
@property (strong, nonatomic) UIButton *ownerNameBtn;
/// 用来显示这条动态（tweet）的文字内容
@property (strong, nonatomic) UITTTAttributedLabel *contentLabel;
/// 用来显示这条动态（tweet）发表的时间
@property (strong, nonatomic) UILabel *timeLabel;
/// 用来显示这条动态（tweet）发表的地点
@property (strong, nonatomic) UIButton *locaitonBtn;
/// 点赞按钮
@property (strong, nonatomic) UIButton *likeBtn;
/// 评论按钮
@property (strong, nonatomic) UIButton *commentBtn;
/// 删除按钮（只有自己发表的）
@property (strong, nonatomic) UIButton *deleteBtn;
/// 用来显示点赞的人（只有一行）
@property (strong, nonatomic) UICollectionView *likeUsersView;
/// 用来显示用户评论
@property (strong, nonatomic) UITableView *commentListView;
/// 用来显示这条动态（tweet）的图片内容
@property (strong, nonatomic) UICustomCollectionView *mediaView;
/// 用来存储这条动态（tweet）的图片内容
@property (strong, nonatomic) NSMutableDictionary *imageViewsDict;

/// ???????
@property (nonatomic, assign) NSInteger outTweetsIndex;

/**
 *  点击回调
 */

/// 注意：commentClickedBlock 还会被commentBtnClicked调用
@property (nonatomic, copy) CommentClickedBlock commentClickedBlock;
@property (nonatomic, copy) LikeBtnClickedBlock likeBtnClickedBlock;
@property (nonatomic, copy) UserBtnClickedBlock userBtnClickedBlock;
@property (nonatomic, copy) MoreLikersBtnClickedBlock moreLikersBtnClickedBlock;
@property (nonatomic, copy) DeleteClickedBlock deleteClickedBlock;
@property (nonatomic, copy) LocationClickedBlock locationClickedBlock;
/// 跳转到
@property (nonatomic, copy) void(^goToDetailTweetBlock) (Tweet *curTweet);
/// 如果只有一张图片时需要调用的回调
@property (nonatomic, copy) void (^refreshSingleCCellBlock)();
@property (nonatomic, copy) void (^mediaItemClickedBlock)(HtmlMediaItem *curItem);

/// 计算整个TweetCell的高度
+(CGFloat)cellHeightWithObj:(id)obj;

@end
