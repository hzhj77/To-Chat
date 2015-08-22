//
//  JFTodoTypeTableView.h
//  ToChat
//
//  Created by syfll on 15/8/18.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

@interface JFTodoTypeTableView : UITableViewController<XLPagerTabStripChildItem>
@property (nonatomic, strong) NSString *titleName;
+(instancetype)initWithTitle:(NSString *)title;
@end
