//
//  JFViewController.h
//  ToChat
//
//  Created by syfll on 15/8/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFViewController : UIViewController
- (void)showNetworkIndicator;

- (void)hideNetworkIndicator;

- (void)showProgress;

- (void)hideProgress;

- (void)alert:(NSString *)msg;

- (BOOL)alertError:(NSError *)error;

- (BOOL)filterError:(NSError *)error;

- (void)runInMainQueue:(void (^)())queue;

- (void)runInGlobalQueue:(void (^)())queue;

- (void)runAfterSecs:(float)secs block:(void (^)())block;

- (void)showHUDText:(NSString *)text;

- (void)toast:(NSString *)text;

- (void)toast:(NSString *)text duration:(NSTimeInterval)duration;
@end
