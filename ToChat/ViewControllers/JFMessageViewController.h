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
//@class ViewController;
//
//@protocol JFDemoViewControllerDelegate <NSObject>
//
//- (void)didDismissJFDemoViewController:(ViewController *)vc;
//
//@end


@interface JFMessageViewController : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate>

//@property (weak, nonatomic) id<JFDemoViewControllerDelegate> delegateModal;

//@property (strong, nonatomic) DemoModelData *demoData;
@property (strong, nonatomic) JFDemoModelData *demoData;
- (void)receiveMessagePressed:(UIBarButtonItem *)sender;

- (void)closePressed:(UIBarButtonItem *)sender;

@end

