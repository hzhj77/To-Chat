//
//  JFFolloweeViewController.h
//  ToChat
//
//  Created by jft0m on 15/9/5.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFUserManager.h"

@interface JFFolloweesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) JFUser *user;

@end
