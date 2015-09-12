//
//  GroupNavigationController.m
//  ToChat
//
//  Created by chenlong on 15/9/12.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "GroupNavigationController.h"
#import "XHPopMenu.h"

@interface GroupNavigationController ()
@property (nonatomic, strong) XHPopMenu *popMenu;
@end

@implementation GroupNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView* toMsgButton = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    toMsgButton.image = [UIImage imageNamed:@"ToChat"];
    toMsgButton.userInteractionEnabled = YES;
    [toMsgButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toMsgCtl)]];
    UIBarButtonItem* toMsgItem = [[UIBarButtonItem alloc]initWithCustomView:toMsgButton];
    self.navigationItem.leftBarButtonItem = toMsgItem;
    
    UIImageView* moreButton = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    moreButton.image = [UIImage imageNamed:@"ToChat"];
    moreButton.userInteractionEnabled = YES;
    [moreButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMore)]];
    UIBarButtonItem* moreItem = [[UIBarButtonItem alloc]initWithCustomView:moreButton];
    self.navigationItem.rightBarButtonItem = moreItem;
}

-(void)toMsgCtl{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToGroupMsg" object:nil];
}

-(void)showMore{
    [self.popMenu showMenuOnView:self.navigationController.view atPoint:CGPointZero];
}
#pragma mark config popMenu
- (XHPopMenu *)popMenu {
    if (!_popMenu) {
        NSMutableArray *popMenuItems = [[NSMutableArray alloc] initWithCapacity:3];
        for (int i = 0; i < 2; i ++) {
            NSString *imageName;
            NSString *title;
            switch (i) {
                case 0: {
                    imageName = @"contacts_add_newmessage";
                    title = @"创建群组";
                    break;
                }
                case 1: {
                    imageName = @"contacts_add_friend";
                    title = @"搜索群组";
                    break;
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
            if (index == 0) {
                printf("创建群组\n");
                //[weakSelf enterQRCodeController];
            }else if (index == 1) {
                printf("搜索群组\n");
            }
        };
    }
    return _popMenu;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
