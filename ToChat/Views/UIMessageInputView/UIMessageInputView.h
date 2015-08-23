//
//  UIMessageInputView.h
//  ToChat
//
//  Created by syfll on 15/8/10.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//
//  UIMessageInputView 主体部分是一条窄窄的东西

#import <UIKit/UIKit.h>
#import "AGEmojiKeyBoardView.h"
//#import "Projects.h"


typedef NS_ENUM(NSInteger, UIMessageInputViewContentType) {
    UIMessageInputViewContentTypeTweet = 0,
    UIMessageInputViewContentTypePriMsg,
    UIMessageInputViewContentTypeTopic,
    UIMessageInputViewContentTypeTask
};

/// 标记键盘输入状态
typedef NS_ENUM(NSInteger, UIMessageInputViewState) {
    UIMessageInputViewStateSystem,  // addButton = 加号，emotionButton = emoji
    UIMessageInputViewStateEmotion, // addButton = 加号，emotionButton = 键盘
    UIMessageInputViewStateAdd      // addButton = 键盘，emotionButton = emoji
};
@protocol UIMessageInputViewDelegate;

@interface UIMessageInputView : UIView<UITextViewDelegate>
/// 没有输入内容时显示的文本内容
@property (strong, nonatomic) NSString *placeHolder;
/// 是否需要显示
@property (assign, nonatomic) BOOL isAlwaysShow;
/// 输入框将要发送的内容的类型(决定了UI的样式)
@property (assign, nonatomic, readonly) UIMessageInputViewContentType contentType;
/// 将要把发送给哪个用户
@property (strong, nonatomic) User *toUser;
///
@property (strong, nonatomic) NSNumber *commentOfId;
//@property (strong, nonatomic) Project *curProject;

@property (nonatomic, weak) id<UIMessageInputViewDelegate> delegate;
+ (instancetype)messageInputViewWithType:(UIMessageInputViewContentType)type;
+ (instancetype)messageInputViewWithType:(UIMessageInputViewContentType)type placeHolder:(NSString *)placeHolder;

/// 把 UIMessageInputView 加入(addSubview) [UIApplication sharedApplication].keyWindow 中
- (void)prepareToShow;

/// 把 UIMessageInputView 移除(removeFromSuperview) [UIApplication sharedApplication].keyWindow 中.
- (void)prepareToDismiss;

/**
 *  使 UIMessageInputView 成为 first responder
 *  @return NO 已经是 first responder,YES 成功使其成为 first responder.
 */
- (BOOL)notAndBecomeFirstResponder;

- (BOOL)isAndResignFirstResponder;
- (BOOL)isCustomFirstResponder;
@end

@protocol UIMessageInputViewDelegate <NSObject>
@optional
- (void)messageInputView:(UIMessageInputView *)inputView sendText:(NSString *)text;
- (void)messageInputView:(UIMessageInputView *)inputView sendBigEmotion:(NSString *)emotionName;
- (void)messageInputView:(UIMessageInputView *)inputView addIndexClicked:(NSInteger)index;
- (void)messageInputView:(UIMessageInputView *)inputView heightToBottomChenged:(CGFloat)heightToBottom;
@end
