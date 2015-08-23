//
//  AppDelegate.h
//  ToChat
//
//  Created by syfll on 15/8/10.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

/**
 *  跳转到主界面
 */
- (void)setupTabViewController;

/**
 *  注册推送
 */
- (void)registerPush;
@end


