//
//  JFMessageViewController.h
//  ChatUITest
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 jft0m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessages.h"
#import "JFDemoModelData.h"
#import "JFUserManager.h"
#import "AVOSCloudIM.h"
#import "LeanChatLib.h"

#import "AVIMTypedMessage+Common.h"
//@class ViewController;
//
//@protocol JFDemoViewControllerDelegate <NSObject>
//
//- (void)didDismissJFDemoViewController:(ViewController *)vc;
//
//@end


@interface JFMessageViewController : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate,AVIMClientDelegate>

//@property (weak, nonatomic) id<JFDemoViewControllerDelegate> delegateModal;
/// 发送方
@property (strong, nonatomic) JFUser *outgoingUser;
/// 接收方
@property (strong, nonatomic) JFUser *incomingUser;
@property (strong, nonatomic) JFDemoModelData *demoData;
@property (strong, nonatomic) AVIMConversation *conv;

- (void)closePressed:(UIBarButtonItem *)sender;

@end

