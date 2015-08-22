//
//  TweetCell.m
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

@synthesize tweet = _tweet;

-(void)setTweet:(Tweet *)tweet{
    if (_tweet != tweet) {
        _tweet = tweet;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    //  初始化
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self InitViews];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_tweet) {
        return;
    }
    
    //  用户头像
    __weak __typeof(self)weakSelf = self;
    //  为头像设置将要显示的图片、缓存的图片、点击后的回调
    [self.ownerImgView setImageWithUrl:[_tweet.user.avatar urlImageWithCodePathResizeToView:_ownerImgView] placeholderImage:[UIImage imageNamed:@"jft0m"] tapBlock:^(id obj) {
        [weakSelf userBtnClicked];
    }];
    
    /** 
    *    用户名
    */
    //  设置用户，同时设置按钮的大小
    [self.ownerNameBtn setUserTitle:_tweet.user.name font:[UIFont systemFontOfSize:17] maxWidth:(kTweetCell_ContentWidth)];
    
    /**
     *    文字内容
     */
    //  设置文字内容，同时设置label大小
    [self.contentLabel setLongString:_tweet.content withFitWidth:kTweetCell_ContentWidth maxHeight:kTweet_ContentMaxHeight];
    //  为文字内容添加link元素&Emoji内容
    for (HtmlMediaItem *item in _tweet.htmlMedia.mediaItems) {
        if (item.displayStr.length > 0 && !(item.type == HtmlMediaItemType_Code ||item.type == HtmlMediaItemType_EmotionEmoji)) {
            [self.contentLabel addLinkToTransitInformation:[NSDictionary dictionaryWithObject:item forKey:@"value"] withRange:item.range];
        }
    }
    //  更新最下方的坐标
    CGFloat curBottomY = kTweetCell_PadingTop +[_tweet contentLabelHeight] +10;
    
    
    /**
        图片缩略图展示
     
        如果imageItems数量为0则隐藏mediaView
     
        如果存在：
        先根据imageItems的数量获取mediaHeight，然后设置mediaView的frame
     */
    if (_tweet.htmlMedia.imageItems.count > 0) {
        
        CGFloat mediaHeight = [_tweet contentMediaHeight];
        [self.mediaView setFrame:CGRectMake(kTweetCell_PadingLeft, curBottomY, kTweetCell_ContentWidth, mediaHeight)];
        [self.mediaView reloadData];
        self.mediaView.hidden = NO;
        
        //  修改curBottomY
        curBottomY += mediaHeight;
    }else{
        if (self.mediaView) {
            self.mediaView.hidden = YES;
        }
    }
    
    /**
        位置信息
     
        如果location长度为0则不显示地理信息
     
        如果location.length > 0：
        设置locaitonBtn的内容、frame
     */
    
    if (_tweet.location.length > 0) {
        [self.locaitonBtn setTitle:_tweet.location forState:UIControlStateNormal];
        self.locaitonBtn.frame = CGRectMake(kTweetCell_PadingLeft, curBottomY +5,
                                            (kScreen_Width - kTweetCell_PadingLeft- kPaddingLeftWidth- 20), 15);
        self.locaitonBtn.hidden = NO;
        
        //  修改curBottomY
        curBottomY += CGRectGetHeight(self.locaitonBtn.bounds) + kTweetCell_LocationCCell_Pading;
    }else {
        self.locaitonBtn.hidden = YES;
    }
    
    /**
        这条动态（tweet）发表的时间
        设置timeLabel的内容、位置
        设置timeLabel内容在左侧
     */
    
    [self.timeLabel setLongString:[_tweet.time stringTimesAgo] withVariableWidth:kScreen_Width/2];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.frame = CGRectMake(kTweetCell_PadingLeft, curBottomY +5,
                                                                                (kScreen_Width - kTweetCell_PadingLeft- kPaddingLeftWidth- 2*kTweetCell_LikeComment_Width- 10), 15);
    
    //修改curBottomY
    curBottomY += 10;

    //喜欢&评论 按钮
    [self.likeBtn setImage:[UIImage imageNamed:(_tweet.isLiked? @"tweet_liked_btn":@"tweet_like_btn")] forState:UIControlStateNormal];
    
    //设置喜欢&评论 按钮的Y坐标
    [self.likeBtn setY:curBottomY];
    [self.commentBtn setY:curBottomY];
    
    //判断是否是我发表的
    BOOL isMineTweet = [_tweet.user.global_key isEqualToString:[Login curLoginUser].global_key];
    
    //如果是我发表的，需要显示删除按钮
    if (isMineTweet) {
        [self.deleteBtn setY:curBottomY];
        self.deleteBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
    }
    
    //修改curBottomY
    
    curBottomY += kTweetCell_LikeComment_Height;
    curBottomY += [TweetCell likeCommentBtn_BottomPadingWithTweet:_tweet];
    
    //点赞的人列表
    if (_tweet.numOfLikers > 0) {
        
        CGFloat likeUsersHeight = [_tweet likeUsersHeightWithTweet];
        [self.likeUsersView setFrame:CGRectMake(kTweetCell_PadingLeft, curBottomY, kTweetCell_ContentWidth, likeUsersHeight)];
        [self.likeUsersView reloadData];
        self.likeUsersView.hidden = NO;
        curBottomY += likeUsersHeight;
    }else{
        if (self.likeUsersView) {
            self.likeUsersView.hidden = YES;
        }
    }
    
    //评论的人列表
    if (_tweet.numOfComments > 0) {
        CGFloat commentListViewHeight = [_tweet commentListViewHeight];
        [self.commentListView setFrame:CGRectMake(kTweetCell_PadingLeft, curBottomY, kTweetCell_ContentWidth, commentListViewHeight)];
        [self.commentListView reloadData];
        self.commentListView.hidden = NO;
    }else{
        if (self.commentListView) {
            self.commentListView.hidden = YES;
        }
    }
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


//  页面里面的两个collectionView（用来显示图片和显示点赞的用户的头像）都用到这个函数所以需要判断
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView == _mediaView) {
        //  图片内容处理
        HtmlMediaItem *curMediaItem = [_tweet.htmlMedia.imageItems objectAtIndex:indexPath.row];
        if (_tweet.htmlMedia.imageItems.count == 1) {
            //  如果只有一张图片
            TweetMediaItemSingleCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItemSingle forIndexPath:indexPath];
            ccell.curMediaItem = curMediaItem;
            ccell.refreshSingleCCellBlock = ^(){
                if (_refreshSingleCCellBlock) {
                    _refreshSingleCCellBlock();
                }
            };
            [_imageViewsDict setObject:ccell.imgView forKey:indexPath];
            return ccell;
        }else{
            // 多张图片
            TweetMediaItemCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItem forIndexPath:indexPath];
            ccell.curMediaItem = curMediaItem;
            [_imageViewsDict setObject:ccell.imgView forKey:indexPath];
            return ccell;
        }
    }else{
        //  点赞的人
        TweetLikeUserCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_TweetLikeUser forIndexPath:indexPath];
        if (indexPath.row >= _tweet.numOfLikers-1 && _tweet.hasMoreLikers) {
            //点赞人数显示不下
            [ccell configWithUser:nil likesNum:[[NSNumber alloc]initWithInteger: _tweet.numOfLikers]];
        }else{
            //点赞人数能显示下
            User *curUser = [_tweet.like_users objectAtIndex:indexPath.row];
            [ccell configWithUser:curUser likesNum:nil];
        }
        return ccell;
    }
}

/**
    CollectionViewCell的大小
 */

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize;
    if (collectionView == _mediaView) {
        //图片列表
        if (_tweet.htmlMedia.imageItems.count == 1) {
            //一张图片的情况
            itemSize = [TweetMediaItemSingleCCell ccellSizeWithObj:_tweet.htmlMedia.imageItems.firstObject];
        }else{
            //多张图片的情况
            itemSize = [TweetMediaItemCCell ccellSizeWithObj:_tweet.htmlMedia.imageItems.firstObject];
        }
    }else{
        //点赞列表
        itemSize = CGSizeMake(kTweetCell_LikeUserCCell_Height, kTweetCell_LikeUserCCell_Height);
    }
    return itemSize;
}

/**
    UICollectionView inset for section at index
 */

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insetForSection;
    if (collectionView == _mediaView) {
        //图片内容
        if (_tweet.htmlMedia.imageItems.count == 1) {
            //一张图片
            CGSize itemSize = [TweetMediaItemSingleCCell ccellSizeWithObj:_tweet.htmlMedia.imageItems.firstObject];
            insetForSection = UIEdgeInsetsMake(0, 0, 0, kTweetCell_ContentWidth - itemSize.width);
        }else{
            //多张图片
            insetForSection = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }else{
        //点赞列表
        insetForSection = UIEdgeInsetsMake(kTweetCell_LikeUserCCell_Pading, 5, kTweetCell_LikeUserCCell_Pading, 5);
    }
    return insetForSection;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kTweetCell_LikeUserCCell_Pading;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kTweetCell_LikeUserCCell_Pading/2;
}
#pragma mark 图片、点赞列表被点击

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _mediaView) {
        // 图片
        int count = (int)_tweet.htmlMedia.imageItems.count;//图片数量
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];//保存图片
        for (int i = 0; i<count; i++) {
            HtmlMediaItem *imageItem = [_tweet.htmlMedia.imageItems objectAtIndex:i];//获取图片
            MJPhoto *photo = [[MJPhoto alloc] init];//用来展示图片使用的数据源
            photo.url = [NSURL URLWithString:imageItem.src]; // 图片路径
            photo.srcImageView = [_imageViewsDict objectForKey:[NSIndexPath indexPathForItem:i inSection:0]]; // 来源于哪个UIImageView
            [photos addObject:photo];
        }
        
        // 2.显示相册
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = indexPath.row; // 弹出相册时显示的第一张图片是？
        browser.photos = photos; // 设置所有的图片
        [browser show];
    }else{
        // 点赞列表
        if (indexPath.row >= _tweet.numOfLikers-1 && _tweet.hasMoreLikers) {
            // 如果显示不下
            if (_moreLikersBtnClickedBlock) {
                _moreLikersBtnClickedBlock(_tweet);
            }
        }else{
            // 如果可以显示下
            User *curUser = [_tweet.like_users objectAtIndex:indexPath.row];
            if (_userBtnClickedBlock) {
                _userBtnClickedBlock(curUser);
            }
        }
    }
}
#pragma mark Table M comments
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tweet.numOfComments;
}
#pragma mark 评论列表
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= _tweet.numOfComments-1 && _tweet.hasMoreComments) {
        // 显示不下评论则需要显示TweetCommentMoreCell
        TweetCommentMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TweetCommentMore forIndexPath:indexPath];
        cell.commentNum = [[NSNumber alloc]initWithInteger:_tweet.numOfComments];
        return cell;
    }else{
        // TweetCommentCell
        TweetCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TweetComment forIndexPath:indexPath];
        Comment *curComment = [_tweet.comment_list objectAtIndex:indexPath.row];
        [cell configWithComment:curComment topLine:(indexPath.row != 0)];
        cell.commentLabel.delegate = self;
        return cell;
    }
}
#pragma mark cell高度
/**
    因为没有自动布局，所以cell高度需要自己手动计算
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0;
    if (indexPath.row >= _tweet.numOfComments-1 && _tweet.hasMoreComments) {
        // TweetCommentMoreCell 的高度
        cellHeight = [TweetCommentMoreCell cellHeight];
    }else{
        // TweetCommentCell 的高度
        Comment *curComment = [_tweet.comment_list objectAtIndex:indexPath.row];
        cellHeight = [TweetCommentCell cellHeightWithObj:curComment];
    }
    return cellHeight;
}
#pragma mark 评论点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= _tweet.numOfComments-1 && _tweet.hasMoreComments) {
        // TweetCommentMoreCell 点击回调
        DebugLog(@"More Comment");
        if (_goToDetailTweetBlock) {
            _goToDetailTweetBlock(_tweet);
        }
    }else{
        // TweetCommentCell 点击回调
        if (_commentClickedBlock) {
            _commentClickedBlock(_tweet, indexPath.row, [tableView cellForRowAtIndexPath:indexPath]);
        }
    }
}
#pragma mark Table Copy

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 如果点击的是TweetCommentMoreCell则不显示“Copy Menu”
    if (indexPath.row >= _tweet.numOfComments-1 && _tweet.hasMoreComments) {
        return NO;
    }
    // 如果点击的是TweetCommentCell则允许显示“Copy Menu”
    return YES;
}
// 如果copy操作则允许显示
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
}
// 执行copy操作
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        // 1、获取评论内容
        Comment *curComment = [_tweet.comment_list objectAtIndex:indexPath.row];
        // 2、把内容添加到粘贴板
        [UIPasteboard generalPasteboard].string = curComment.content? curComment.content: @"";
    }
}


#pragma mark 按钮回调
- (void)likeBtnClicked:(id)sender{
    _tweet.isLiked = !_tweet.isLiked;
    NSLog(@"点赞\n");
    [self.likeBtn setImage:[UIImage imageNamed:(_tweet.isLiked? @"tweet_liked_btn":@"tweet_like_btn")] forState:UIControlStateNormal];
    if (_likeBtnClickedBlock) {
     _likeBtnClickedBlock(_tweet);
    }
}
/// 注意：commentBtnClicked 会调用commentClickedBlock
- (void)commentBtnClicked:(id)sender{
    if (_commentClickedBlock) {
        NSLog(@"commentBtnClicked");
        _commentClickedBlock(_tweet, -1, sender);
    }
}
- (void)deleteBtnClicked:(UIButton *)sender{
    if (_deleteClickedBlock) {
        _deleteClickedBlock(_tweet, _outTweetsIndex);
    }
}

- (void)userBtnClicked{
    if (_userBtnClickedBlock) {
        _userBtnClickedBlock(_tweet.user);
    }
}
- (void)locationBtnClicked:(id)sender{
    if (_locationClickedBlock) {
        _locationClickedBlock(_tweet);
    }
}
#pragma mark TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components{
    if (_mediaItemClickedBlock) {
        _mediaItemClickedBlock([components objectForKey:@"value"]);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat)cellHeightWithObj:(id)obj{
    Tweet *tweet = (Tweet *)obj;
    CGFloat cellHeight = 0;
    if (tweet.numOfComments > 0 || tweet.numOfLikers > 0) {
        cellHeight = 6;
    }else{
        cellHeight = 3;
    }
    cellHeight += 20;
    cellHeight += kTweetCell_PadingTop;
    cellHeight += [TweetCell contentLabelHeightWithTweet:tweet];
    cellHeight += [TweetCell contentMediaHeightWithTweet:tweet];
    cellHeight += kTweetCell_LikeComment_Height;
    cellHeight += [[self class] locationHeightWithTweet:tweet];
    cellHeight += [TweetCell likeCommentBtn_BottomPadingWithTweet:tweet];
    cellHeight += [TweetCell likeUsersHeightWithTweet:tweet];
    cellHeight += [TweetCell commentListViewHeightWithTweet:tweet];
    cellHeight += kTweetCell_PadingBottom;
    return cellHeight;
}
/// 计算文字内容的高度
+ (CGFloat)contentLabelHeightWithTweet:(Tweet *)tweet{
    return MIN(kTweet_ContentMaxHeight, [tweet.content getHeightWithFont:kTweet_ContentFont constrainedToSize:CGSizeMake(kTweetCell_ContentWidth, CGFLOAT_MAX)]);
}

/// 计算图片内容的高度
+ (CGFloat)contentMediaHeightWithTweet:(Tweet *)tweet{
    CGFloat contentMediaHeight = 0;
    NSInteger mediaCount = tweet.htmlMedia.imageItems.count;
    if (mediaCount > 0) {
        HtmlMediaItem *curMediaItem = tweet.htmlMedia.imageItems.firstObject;
        contentMediaHeight = (mediaCount == 1)?
        [TweetMediaItemSingleCCell ccellSizeWithObj:curMediaItem].height:
        ceilf((float)mediaCount/3)*([TweetMediaItemCCell ccellSizeWithObj:curMediaItem].height+kTweetCell_LikeUserCCell_Pading) - kTweetCell_LikeUserCCell_Pading;
    }
    return contentMediaHeight;
}

/// 计算点赞按钮和内容底部的距离
+ (CGFloat)likeCommentBtn_BottomPadingWithTweet:(Tweet *)tweet{
    if (tweet &&
        (tweet.numOfLikers > 0)){
        return 5.0;
    }else{
        return 0;
    }
}

/// 计算地理信息的高度
+ (CGFloat)locationHeightWithTweet:(Tweet *)tweet{
    CGFloat ocationHeight = 0;
    if ( tweet.location.length > 0) {
        ocationHeight = 15 + kTweetCell_LocationCCell_Pading;
    }else{
        ocationHeight = 0;
    }
    return ocationHeight;
}

/// 计算点赞列表的高度
+ (CGFloat)likeUsersHeightWithTweet:(Tweet *)tweet{
    CGFloat likeUsersHeight = 0;
    if (tweet.numOfLikers> 0) {
        likeUsersHeight = 45;
    }
    return likeUsersHeight;
}

/// 计算评论列表的高度
+ (CGFloat)commentListViewHeightWithTweet:(Tweet *)tweet{
    if (!tweet) {
        return 0;
    }
    CGFloat commentListViewHeight = 0;
    
    NSInteger numOfComments = tweet.numOfComments;
    BOOL hasMoreComments = tweet.hasMoreComments;
    
    for (int i = 0; i < numOfComments; i++) {
        if (i == numOfComments-1 && hasMoreComments) {
            commentListViewHeight += [TweetCommentMoreCell cellHeight];
        }else{
            Comment *curComment = [tweet.comment_list objectAtIndex:i];
            commentListViewHeight += [TweetCommentCell cellHeightWithObj:curComment];
        }
    }
    return commentListViewHeight;
}

/// 初始化控件
-(void)InitViews{
    // 用户头像
    if (!self.ownerImgView) {
        self.ownerImgView = [[UITapImageView alloc] initWithFrame:CGRectMake(10, 10, 33, 33)];
        [self.ownerImgView doCircleFrame];
        [self.contentView addSubview:self.ownerImgView];
    }
    // 用户昵称
    if (!self.ownerNameBtn) {
        self.ownerNameBtn = [UIButton initUserButton];
        self.ownerNameBtn.frame = CGRectMake(kTweetCell_PadingLeft, 18, 50, 20);
        [self.ownerNameBtn addTarget:self action:@selector(userBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.ownerNameBtn];
    }
    // 动态（tweet）的内容
    if (!self.contentLabel) {
        self.contentLabel = [[UITTTAttributedLabel alloc] initWithFrame:CGRectMake(kTweetCell_PadingLeft, kTweetCell_PadingTop, kTweetCell_ContentWidth, 20)];
        self.contentLabel.font = kTweet_ContentFont;
        self.contentLabel.textColor = [UIColor colorWithHexString:@"0x222222"];
        self.contentLabel.numberOfLines = 0;
        
        self.contentLabel.linkAttributes = kLinkAttributes;
        self.contentLabel.activeLinkAttributes = kLinkAttributesActive;
        self.contentLabel.delegate = self;
        [self.contentLabel addLongPressForCopy];
        [self.contentView addSubview:self.contentLabel];
    }
    // 评论按钮
    if (!self.commentBtn) {
        self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentBtn.frame = CGRectMake(kScreen_Width - kPaddingLeftWidth- kTweetCell_LikeComment_Width, 0, kTweetCell_LikeComment_Width, kTweetCell_LikeComment_Height);
        [self.commentBtn setImage:[UIImage imageNamed:@"tweet_comment_btn"] forState:UIControlStateNormal];
        [self.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.commentBtn];
    }
    // 点赞按钮
    if (!self.likeBtn) {
        self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.likeBtn.frame = CGRectMake(kScreen_Width - kPaddingLeftWidth- 2*kTweetCell_LikeComment_Width -5, 0, kTweetCell_LikeComment_Width, kTweetCell_LikeComment_Height);
        [self.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.likeBtn];
    }
    // 删除按钮(先初始化了，哪怕后面不用)
    if (!self.deleteBtn) {
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = CGRectMake(kScreen_Width - kPaddingLeftWidth- 3*kTweetCell_LikeComment_Width -5, 0, kTweetCell_LikeComment_Width, kTweetCell_LikeComment_Height);
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor colorWithHexString:@"0x3bbd79"] forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        self.deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.deleteBtn];
    }
    // 动态（tweet）发表的地点(先初始化了，哪怕后面不用)
    if (!self.locaitonBtn) {
        self.locaitonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.locaitonBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.locaitonBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.locaitonBtn.frame = CGRectMake(kTweetCell_PadingLeft, 0, 100, 15);
        //            self.locaitonBtn.titleLabel.minimumScaleFactor = 0.80;
        self.locaitonBtn.titleLabel.adjustsFontSizeToFitWidth = NO;
        self.locaitonBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.locaitonBtn setTitleColor:[UIColor colorWithHexString:@"0x3bbd79"] forState:UIControlStateNormal];
        [self.locaitonBtn addTarget:self action:@selector(locationBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.locaitonBtn];
    }
    // 发表的时间
    if (!self.timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kTweetCell_PadingLeft, 0, 100, 15)];
        self.timeLabel.font = kTweet_TimtFont;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
        [self.contentView addSubview:self.timeLabel];
    }
    // 点赞用户列表
    if (!self.likeUsersView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.likeUsersView = [[UICollectionView alloc] initWithFrame:CGRectMake(kTweetCell_PadingLeft, 0, kTweetCell_ContentWidth, 35) collectionViewLayout:layout];
        self.likeUsersView.scrollEnabled = NO;
        [self.likeUsersView setBackgroundView:nil];
        [self.likeUsersView setBackgroundColor:[UIColor clearColor]];
        [self.likeUsersView registerClass:[TweetLikeUserCCell class] forCellWithReuseIdentifier:kCCellIdentifier_TweetLikeUser];
        self.likeUsersView.dataSource = self;
        self.likeUsersView.delegate = self;
        [self.contentView addSubview:self.likeUsersView];
    }
    // 初始化图片容器
    if (!self.mediaView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.mediaView = [[UICustomCollectionView alloc] initWithFrame:CGRectMake(kTweetCell_PadingLeft, 0, kTweetCell_ContentWidth, 80) collectionViewLayout:layout];
        self.mediaView.scrollEnabled = NO;
        [self.mediaView setBackgroundView:nil];
        [self.mediaView setBackgroundColor:[UIColor clearColor]];
        [self.mediaView registerClass:[TweetMediaItemCCell class] forCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItem];
        [self.mediaView registerClass:[TweetMediaItemSingleCCell class] forCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItemSingle];
        self.mediaView.dataSource = self;
        self.mediaView.delegate = self;
        [self.contentView addSubview:self.mediaView];
    }
    // 初始化评论列表
    if (!self.commentListView) {
        self.commentListView = [[UITableView alloc] initWithFrame:CGRectMake(kTweetCell_PadingLeft, 0, kTweetCell_ContentWidth, 20) style:UITableViewStylePlain];
        self.commentListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.commentListView.scrollEnabled = NO;
        [self.commentListView setBackgroundView:nil];
        [self.commentListView setBackgroundColor:[UIColor clearColor]];
        [self.commentListView registerClass:[TweetCommentCell class] forCellReuseIdentifier:kCellIdentifier_TweetComment];
        [self.commentListView registerClass:[TweetCommentMoreCell class] forCellReuseIdentifier:kCellIdentifier_TweetCommentMore];
        self.commentListView.dataSource = self;
        self.commentListView.delegate = self;
        [self.contentView addSubview:self.commentListView];
    }

}
@end
