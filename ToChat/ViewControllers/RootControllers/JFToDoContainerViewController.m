//
//  JFToDoContainerViewController.m
//  ToChat
//
//  Created by syfll on 15/8/28.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "JFToDoContainerViewController.h"
#import "XHPopMenu.h"

@interface JFToDoContainerViewController ()
@property (nonatomic, strong) XHPopMenu *popMenu;
@end

@implementation JFToDoContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark “添加按钮”回调

- (IBAction)showMenuOnView:(UIBarButtonItem *)buttonItem {
    [self.popMenu showMenuOnView:self.navigationController.view atPoint:CGPointZero];
}
#pragma mark config popMenu
- (XHPopMenu *)popMenu {
    if (!_popMenu) {
        NSMutableArray *popMenuItems = [[NSMutableArray alloc] initWithCapacity:3];
        for (int i = 0; i < 3; i ++) {
            NSString *imageName;
            NSString *title;
            switch (i) {
                case 0: {
                    imageName = @"contacts_add_newmessage";
                    title = @"添加日程";
                    break;
                }
                case 1: {
                    imageName = @"contacts_add_friend";
                    title = @"发表状态";
                    break;
                }
                case 2:{
                    imageName = @"contacts_add_friend";
                    title = @"添加好友";
                }
                default:
                    break;
            }
            XHPopMenuItem *popMenuItem = [[XHPopMenuItem alloc] initWithImage:[UIImage imageNamed:imageName] title:title];
            [popMenuItems addObject:popMenuItem];
        }
        
        WEAKSELF
        _popMenu = [[XHPopMenu alloc] initWithMenus:popMenuItems];
        _popMenu.popMenuDidSlectedCompled = ^(NSInteger index, XHPopMenuItem *popMenuItems) {
            if (index == 1) {
                printf("发表状态 index 1\n");
                //[weakSelf enterQRCodeController];
            }else if (index == 0 ) {
                printf("添加日程 index 0\n");
                [weakSelf enterCreateScheduleController];
            }else if (index == 2 ) {
                printf("添加好友 0\n");
                [weakSelf enterAddFriendController];
            }
            
        };
    }
    return _popMenu;
}
- (void)enterCreateScheduleController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ToDo" bundle:nil];
    UIViewController * view = [storyboard instantiateViewControllerWithIdentifier:@"CreateTodoViewController"];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)enterAddFriendController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ToDo" bundle:nil];
    UIViewController * view = [storyboard instantiateViewControllerWithIdentifier:@"JFAddFriendViewController"];
    [self.navigationController pushViewController:view animated:YES];
}

@end
