//
//  TweetViewController.m
//  Step-it-up
//
//  Created by syfll on 15/8/2.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "TweetViewController.h"


@interface TweetViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIMessageInputViewDelegate>
/// 想要评论的 Tweet
@property (nonatomic, strong) Tweet *commentTweet;
/// 标记了想要评论的 Tweet 中的第几条评论
@property (nonatomic, assign) NSInteger commentIndex;
/// ???
@property (nonatomic, strong) UIView *commentSender;
/// commentIndex对应的用户
@property (nonatomic, strong) User *commentToUser;

@end

@implementation TweetViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _myTweets = [[Tweets alloc]init];
        _myTweets.tweets = [self fakeTweets];
    }
    return self;
}


#pragma mark lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTweets = [[Tweets alloc]init];
    _myTweets.tweets = [self fakeTweets];
    
    //    添加myTableView
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        Class tweetCellClass = [TweetCell class];
        [tableView registerClass:tweetCellClass forCellReuseIdentifier:kCellIdentifier_Tweet];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        {
            __weak typeof(self) weakSelf = self;
            [tableView addInfiniteScrollingWithActionHandler:^{
                [weakSelf refreshMore];
            }];
        }
        {
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.rdv_tabBarController.tabBar.frame), 0);
            tableView.contentInset = insets;
        }
        tableView;
    });
    // 刷新头
    _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.myTableView];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    // 输入框
    _myMsgInputView = [UIMessageInputView messageInputViewWithType:UIMessageInputViewContentTypeTweet];
    _myMsgInputView.delegate = self;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 键盘
    if (_myMsgInputView) {
        [_myMsgInputView prepareToShow];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (_myMsgInputView) {
        [_myMsgInputView prepareToDismiss];
    }
}


#pragma mark - TabBar
- (void)tabBarItemClicked{
    //[super tabBarItemClicked];
    if (_myTableView.contentOffset.y > 0) {
        [_myTableView setContentOffset:CGPointZero animated:YES];
    }else if (!self.refreshControl.refreshing){
        [self.refreshControl beginRefreshing];
        [self.myTableView setContentOffset:CGPointMake(0, -44)];
        [self refresh];
    }
}
#pragma mark - refresh
- (void)refresh{
    [_myTweets updateTweets];
    [_myTableView reloadData];
    [self.refreshControl endRefreshing];
}
- (void)refreshMore{
    [_myTweets updateMoreTweets];
    [_myTableView reloadData];
    [self.myTableView.infiniteScrollingView stopAnimating];
    self.myTableView.showsInfiniteScrolling = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark TableM
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_myTweets.tweets) {
        return _myTweets.tweets.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Tweet forIndexPath:indexPath];

    cell.tweet = [_myTweets.tweets objectAtIndex:indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.commentClickedBlock = ^(Tweet *tweet, NSInteger index, id sender){
        if ([self.myMsgInputView isAndResignFirstResponder]) {
            return ;
        }
        weakSelf.commentTweet = tweet;
        weakSelf.commentIndex = index;
        weakSelf.commentSender = sender;
        
        weakSelf.myMsgInputView.commentOfId = tweet.userID;
        
        if (weakSelf.commentIndex >= 0) {
            weakSelf.commentToUser = ((Comment*)[weakSelf.commentTweet.comment_list objectAtIndex:weakSelf.commentIndex]).owner;
            weakSelf.myMsgInputView.toUser = ((Comment*)[weakSelf.commentTweet.comment_list objectAtIndex:weakSelf.commentIndex]).owner;
            
            if ([Login isLoginUserGlobalKey:weakSelf.commentToUser.global_key]) {
                ESWeakSelf
                UIActionSheet *actionSheet = [UIActionSheet bk_actionSheetCustomWithTitle:@"删除此评论" buttonTitles:nil destructiveTitle:@"确认删除" cancelTitle:@"取消" andDidDismissBlock:^(UIActionSheet *sheet, NSInteger index) {
                    ESStrongSelf
                    if (index == 0 && _self.commentIndex >= 0) {
                        Comment *comment  = [_self.commentTweet.comment_list objectAtIndex:_self.commentIndex];
                        [_self deleteComment:comment ofTweet:_self.commentTweet];
                    }
                }];
                [actionSheet showInView:self.view];
                return;
            }
        }else{
            weakSelf.myMsgInputView.toUser = nil;
        }
        [_myMsgInputView notAndBecomeFirstResponder];
    };
    
    
    cell.likeBtnClickedBlock = ^(Tweet *tweet){
        [weakSelf.myTableView reloadData];
    };
    cell.userBtnClickedBlock = ^(User *curUser){
        UserInfoViewController *vc = [[UserInfoViewController alloc] init];
        vc.curUser = curUser;
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.moreLikersBtnClickedBlock = ^(Tweet *curTweet){
        LikersViewController *vc = [[LikersViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.goToDetailTweetBlock = ^(Tweet *curTweet){
        [self goToDetailWithTweet:curTweet];
    };
    cell.refreshSingleCCellBlock = ^(){
        [weakSelf.myTableView reloadData];
    };
//    cell.mediaItemClickedBlock = ^(HtmlMediaItem *curItem){
//        [weakSelf analyseLinkStr:curItem.href];
//    };
//    cell.locationClickedBlock = ^(Tweet *curTweet){
//        TweetSendLocationDetailViewController *vc = [[TweetSendLocationDetailViewController alloc]init];
//        vc.tweet = curTweet;
//        
//        if (vc.tweet.coord.length > 0) {
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }
//    };
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Tweet *tweet = [_myTweets.tweets objectAtIndex:indexPath.row];
    //CGFloat height = tweet ;
    
    return [TweetCell cellHeightWithObj:tweet];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Tweets *curTweets = [self getCurTweets];
    Tweet *toTweet = [_myTweets.tweets objectAtIndex:indexPath.row];
    [self goToDetailWithTweet:toTweet];
}
- (void)goToDetailWithTweet:(Tweet *)tweet{
    TweetDetailViewController *vc = [[TweetDetailViewController alloc] init];
    vc.tweet = tweet;
//    __weak typeof(self) weakSelf = self;
//    vc.deleteTweetBlock = ^(Tweet *toDeleteTweet){
//        Tweets *curTweets = [weakSelf.myTweets objectForKey:[NSNumber numberWithInteger:weakSelf.curIndex]];
//        [curTweets.list removeObject:toDeleteTweet];
//        [weakSelf.myTableView reloadData];
//        [weakSelf.view configBlankPage:EaseBlankPageTypeTweet hasData:(curTweets.list.count > 0) hasError:NO reloadButtonBlock:^(id sender) {
//            [weakSelf sendRequest];
//        }];
//    };
    [self.navigationController pushViewController:vc animated:YES];
}



#warning fake initTweet

-(NSMutableArray *)fakeTweets{
    
    Tweet * tweet = [Tweet fakeInit];
    NSMutableArray * tweets = [[NSMutableArray alloc]initWithArray:@[tweet]];
    return tweets;
}


- (void)test:(UIButton *)sender {
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
    switch (sender.tag) {
        case 0:
            NSLog(@"0\n");
            break;
        case 1:
            NSLog(@"1\n");
            break;
        case 2:
            NSLog(@"2\n");
            break;
        default:
            break;
    }
}

- (void)deleteComment:(Comment *)comment ofTweet:(Tweet *)tweet{
//    __weak typeof(self) weakSelf = self;
//    [[Coding_NetAPIManager sharedManager] request_TweetComment_Delete_WithTweet:tweet andComment:comment andBlock:^(id data, NSError *error) {
//        if (data) {
//            [tweet deleteComment:comment];
//            [weakSelf.myTableView reloadData];
//        }
//    }];
    NSLog(@"删除评论");
}

#pragma mark Comment To Tweet
- (void)sendCommentMessage:(id)obj{
    NSLog(@"- (void)sendCommentMessage:(id)obj");
//    if (_commentIndex >= 0) {
//        _commentTweet.nextCommentStr = [NSString stringWithFormat:@"@%@ %@", _commentToUser.name, obj];
//    }else{
//        _commentTweet.nextCommentStr = obj;
//    }
//    [self sendCurComment:_commentTweet];
//    {
//        _commentTweet = nil;
//        _commentIndex = kCommentIndexNotFound;
//        _commentSender = nil;
//        _commentToUser = nil;
//    }
    self.myMsgInputView.toUser = nil;
    [self.myMsgInputView isAndResignFirstResponder];
}

- (void)sendCurComment:(Tweet *)commentObj{
    NSLog(@"- (void)sendCurComment:(Tweet *)commentObj");
//    __weak typeof(self) weakSelf = self;
//    [[Coding_NetAPIManager sharedManager] request_Tweet_DoComment_WithObj:commentObj andBlock:^(id data, NSError *error) {
//        if (data) {
//            Comment *resultCommnet = (Comment *)data;
//            resultCommnet.owner = [Login curLoginUser];
//            [commentObj addNewComment:resultCommnet];
//            [weakSelf.myTableView reloadData];
//        }
//    }];
}

#pragma mark UIMessageInputViewDelegate
- (void)messageInputView:(UIMessageInputView *)inputView sendText:(NSString *)text{
    [self sendCommentMessage:text];
}

- (void)messageInputView:(UIMessageInputView *)inputView heightToBottomChenged:(CGFloat)heightToBottom{
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        UIEdgeInsets contentInsets= UIEdgeInsetsMake(0.0, 0.0, heightToBottom, 0.0);;
        CGFloat msgInputY = kScreen_Height - heightToBottom - 64;
        
        self.myTableView.contentInset = contentInsets;
        
        if ([_commentSender isKindOfClass:[UIView class]] && !self.myTableView.isDragging && heightToBottom > 60) {
            UIView *senderView = _commentSender;
            CGFloat senderViewBottom = [_myTableView convertPoint:CGPointZero fromView:senderView].y+ CGRectGetMaxY(senderView.bounds);
            CGFloat contentOffsetY = MAX(0, senderViewBottom- msgInputY);
            [self hideToolBar:YES];
            [self.myTableView setContentOffset:CGPointMake(0, contentOffsetY) animated:YES];
        }
    } completion:nil];
}

- (void)hideToolBar:(BOOL)hide{
    if (hide != self.rdv_tabBarController.tabBarHidden) {
//        Tweets *curTweets = [self getCurTweets];
//        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, (hide? (curTweets.canLoadMore? 60.0: 0.0):CGRectGetHeight(self.rdv_tabBarController.tabBar.frame)), 0.0);
//        self.myTableView.contentInset = contentInsets;
        [self.rdv_tabBarController setTabBarHidden:hide animated:YES];
    }
}
- (void)sendTweet{
    NSLog(@"- (void)sendTweet");
//    __weak typeof(self) weakSelf = self;
//    TweetSendViewController *vc = [[TweetSendViewController alloc] init];
//    vc.sendNextTweet = ^(Tweet *nextTweet){
//        [nextTweet saveSendData];//发送前保存草稿
//        [[Coding_NetAPIManager sharedManager] request_Tweet_DoTweet_WithObj:nextTweet andBlock:^(id data, NSError *error) {
//            if (data) {
//                [Tweet deleteSendData];//发送成功后删除草稿
//                Tweets *curTweets = [weakSelf getCurTweets];
//                if (curTweets.tweetType != TweetTypePublicHot) {
//                    Tweet *resultTweet = (Tweet *)data;
//                    resultTweet.owner = [Login curLoginUser];
//                    if (curTweets.list && [curTweets.list count] > 0) {
//                        [curTweets.list insertObject:data atIndex:0];
//                    }else{
//                        curTweets.list = [NSMutableArray arrayWithObject:resultTweet];
//                    }
//                    [self.myTableView reloadData];
//                }
//                [weakSelf.view configBlankPage:EaseBlankPageTypeTweet hasData:(curTweets.list.count > 0) hasError:(error != nil) reloadButtonBlock:^(id sender) {
//                    [weakSelf sendRequest];
//                }];
//            }
//            
//        }];
//        
//    };
//    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}


@end
