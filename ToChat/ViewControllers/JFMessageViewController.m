//
//  JFMessageViewController.m
//  ChatUITest
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 jft0m. All rights reserved.
//

#import "JFMessageViewController.h"

///初始化页面需要加载的聊天数据的数量
static NSInteger kPageSize = 15;

@interface JFMessageViewController ()

@end

@implementation JFMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JSQMessages";
    
    /**
     *  You MUST set your senderId and display name
     */
    self.senderId = self.demoData.senderId;
    self.senderDisplayName = self.demoData.senderDisplayName;
    
    self.inputToolbar.contentView.textView.pasteDelegate = self;
   
    
    /**
     *  显示更多的标题头
     */
     self.showLoadEarlierMessagesHeader = YES;
    
    /**
     *  OPT-IN: allow cells to be deleted
     */
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];
    self.collectionView.collectionViewLayout.messageBubbleFont = [UIFont systemFontOfSize:15];
    
    
    
}
#pragma mark - JSQMessagesViewController method overrides

/// 发送按钮点击回调
- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<JSQMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId
                                             senderDisplayName:senderDisplayName
                                                          date:date
                                                          text:text];
    //视觉上的发送
    [self.demoData.messages addObject:message];
    //真实的发送
    [self didSendText:text];
    
    [self finishSendingMessageAnimated:YES];
}
/// 输入框左侧的按钮
- (void)didPressAccessoryButton:(UIButton *)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Media messages"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Send photo", @"Send location", @"Send video", nil];
    
    [sheet showFromToolbar:self.inputToolbar];
}
/// 输入框左侧的按钮弹出的 ActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    switch (buttonIndex) {
        case 0:
            //[self.demoData addPhotoMediaMessage];
            break;
            
        case 1:
        {
//            __weak UICollectionView *weakView = self.collectionView;
//            
//            [self.demoData addLocationMediaMessageCompletion:^{
//                [weakView reloadData];
//            }];
        }
            break;
            
        case 2:
//            [self.demoData addVideoMediaMessage];
            break;
    }
    
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    [self finishSendingMessageAnimated:YES];
}



#pragma mark - JSQMessages CollectionView DataSource

/// 设定消息
- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.demoData.messages objectAtIndex:indexPath.item];
}

/// 删除消息
- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    [self.demoData.messages removeObjectAtIndex:indexPath.item];
}


/// 气泡消息
- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  You may return nil here if you do not want bubbles.
     *  In this case, you should set the background color of your collection view cell's textView.
     *
     *  Otherwise, return your previously created bubble image data objects.
     */
    
    JSQMessage *message = [self.demoData.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.demoData.outgoingBubbleImageData;
    }
    
    return self.demoData.incomingBubbleImageData;
}

/// 用户头像
- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.demoData.messages objectAtIndex:indexPath.item];
    
    return [self.demoData.avatars objectForKey:message.senderId];
}
/// 时间戳
- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.demoData.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}
/// 气泡上方的文字
- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.demoData.messages objectAtIndex:indexPath.item];
    
    /**
     *  iOS7-style sender name labels
     */
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.demoData.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

/// 气泡下方的文字
- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.demoData.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Override point for customizing cells
     */
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    JSQMessage *msg = [self.demoData.messages objectAtIndex:indexPath.item];
    
    if (!msg.isMediaMessage) {
        
        if ([msg.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor blackColor];
        }
        else {
            cell.textView.textColor = [UIColor whiteColor];
        }
        
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
    return cell;
}
#pragma mark - UICollectionView Delegate

#pragma mark - Custom menu items

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return [super collectionView:collectionView canPerformAction:action forItemAtIndexPath:indexPath withSender:sender];
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    [super collectionView:collectionView performAction:action forItemAtIndexPath:indexPath withSender:sender];
}
#pragma mark - JSQMessages collection view flow layout delegate

#pragma mark - Adjusting cell label heights

/// 时间戳的高度
- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
//    if (indexPath.item % 3 == 0) {
//        return kJSQMessagesCollectionViewCellLabelHeightDefault;
//    }
//    
//    return 0.0f;
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

/// 气泡上方的文字的高度
- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  iOS7-style sender name labels
     */
    JSQMessage *currentMessage = [self.demoData.messages objectAtIndex:indexPath.item];
    if ([[currentMessage senderId] isEqualToString:self.senderId]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.demoData.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]]) {
            return 0.0f;
        }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}
/// 气泡下方的文字的高度
- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

#pragma mark - Responding to collection view tap events

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped avatar!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped message bubble!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    NSLog(@"Tapped cell at %@!", NSStringFromCGPoint(touchLocation));
}

#pragma mark - JSQMessagesComposerTextViewPasteDelegate methods


- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender
{
    if ([UIPasteboard generalPasteboard].image) {
        // If there's an image in the pasteboard, construct a media item with that image and `send` it.
        JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIPasteboard generalPasteboard].image];
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:[NSDate date]
                                                             media:item];
        [self.demoData.messages addObject:message];
        [self finishSendingMessage];
        return NO;
    }
    return YES;
}

#pragma mark - proprety

- (JFUser *)outgoingUser{
    return [[JFUserManager manager] getCurrentUser];
}
- (void)setIncomingUser:(JFUser *)incomingUser{
    NSAssert(incomingUser != nil,@"incomingUser 不能为 nil ");
    _incomingUser = incomingUser;
    self.demoData.senderId = incomingUser.userId;
    self.demoData.senderDisplayName = incomingUser.username;
    [self.demoData.users addObject:incomingUser];
    [[CDChatManager manager] fetchConvWithOtherId:incomingUser.userId callback: ^(AVIMConversation *conversation, NSError *error) {
        if (error) {
            NSLog(@"查找会话实例失败 %@",error);
        }else{
            self.conv = conversation;
            NSLog(@"查找会话实例成功");
            //查询成功后加载会话
            [self loadMessagesWhenInit];
        }
    
    }];
}

- (JFDemoModelData *)demoData{
    if (!_demoData) {
        _demoData = [[JFDemoModelData alloc] init];
    }
    return _demoData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didSendText:(NSString *)text {
    AVIMTextMessage *msg = [AVIMTextMessage messageWithText:[CDEmotionUtils plainStringFromEmojiString:text] attributes:nil];
    [msg.attributes setValue:self.senderDisplayName forKey:@"username"];
    
    [self sendMsg:msg originFilePath:nil];

}
- (void)sendMsg:(AVIMTypedMessage *)msg originFilePath:(NSString *)path {
    [[CDChatManager manager] sendMessage:msg conversation:self.conv callback:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"发送消息失败%@",error);
        } else {
            NSLog(@"发送消息成功");
            if (path) {
                if (msg.mediaType == kAVIMMessageMediaTypeAudio) {
                    // 移动文件，好根据 messageId 找到本地文件缓存
                    NSString *newPath = [[CDChatManager manager] getPathByObjectId:msg.messageId];
                    NSError *error1;
                    [[NSFileManager defaultManager] moveItemAtPath:path toPath:newPath error:&error1];
                    DLog(@"%@", newPath);
                }
            }
        }
    }];
}
#pragma mark - message
// 过滤消息，避免非法的消息导致 Crash
- (NSMutableArray *)filterMessages:(NSArray *)messages {
    NSMutableArray *typedMessages = [NSMutableArray array];
    for (AVIMTypedMessage *message in messages) {
        if ([message isKindOfClass:[AVIMTypedMessage class]]) {
            [typedMessages addObject:message];
        }
    }
    return typedMessages;
}

- (void)loadMessagesWhenInit {
    WEAKSELF
    [self.conv queryMessagesWithLimit:kPageSize callback:^(NSArray *objects, NSError *error) {
        if(error){
           NSLog(@"查询会话失败：%@",error);
        }else{
            NSLog(@"查询会话成功： objects :%@",objects);
            for (AVIMTypedMessage *message in objects) {
                [weakSelf.demoData.messages addObject:[message toJSQMessagesWithSenderId:message.clientId andDisplayName:[message.attributes valueForKey:@"username"] andDate:[NSDate dateWithTimeIntervalSince1970:message.sendTimestamp]]];
                [weakSelf finishSendingMessageAnimated:YES];
            }
            
        }
    }];
}

#pragma mark - AVIMClientDelegate

// 接收消息时触发的代理
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    // 判断收到消息的对话是否为当前对话
    if ([conversation.conversationId isEqualToString:self.conv.conversationId]) {
        // 把收到的消息添加到消息记录列表中
//        [self addMessage:message];
#warning 这个地方是模拟用的
        [self.demoData.messages addObject:[[JSQMessage alloc] initWithSenderId:self.incomingUser.userId
                           senderDisplayName:self.incomingUser.username
                                        date:[NSDate date]
                                        text:@"Now with media messages!"]];
    }
}

@end
