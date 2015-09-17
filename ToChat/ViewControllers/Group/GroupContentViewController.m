//
//  GroupContentViewController.m
//  ToChat
//
//  Created by chenlong on 15/9/11.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "GroupContentViewController.h"
#import "DVSwitch.h"
#import "Header.h"
#import "GroupMemberCell.h"
#import "XHPopMenu.h"

@interface GroupContentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) XHPopMenu *popMenu;
@end

@implementation GroupContentViewController{
    UITableView* memberTableView;//群成员列表
    UITableView* scheduleTableView;//日程列表
    DVSwitch* dvSwitch;//滑动开关 用来选择展示列表
    NSInteger selectIndex;//存储dvSwitch选中的index
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //初始化
    selectIndex = 0;
    
    //选择开关
    dvSwitch = [DVSwitch switchWithStringsArray:@[@"成员", @"日程"]];
    dvSwitch.frame = CGRectMake(0, 64, kScreen_Width, 35);
    dvSwitch.cornerRadius = 0;
    dvSwitch.backgroundColor = [UIColor grayColor];
    dvSwitch.labelTextColorInsideSlider =  [UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1.0];
    [dvSwitch setPressedHandler:^(NSUInteger index) {
        if (index == 0) {
            [UIView animateWithDuration:0.2 animations:^{
                selectIndex = 0;
                memberTableView.right = kScreen_Width;
                scheduleTableView.left = kScreen_Width;
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                selectIndex = 1;
                memberTableView.right = 0;
                scheduleTableView.left = 0;
            }];
        }
    }];
    [self.view addSubview:dvSwitch];
    
    memberTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 99, kScreen_Width, kScreen_Height - 99) style:UITableViewStylePlain];
    memberTableView.dataSource = self;
    memberTableView.delegate = self;
//    memberTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:memberTableView];
    
    scheduleTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreen_Width, 99, kScreen_Width, kScreen_Height - 99) style:UITableViewStylePlain];
    scheduleTableView.dataSource = self;
    scheduleTableView.delegate = self;
//    scheduleTableView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scheduleTableView];
    
    
    UIImageView* moreButton = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    moreButton.image = [UIImage imageNamed:@"moreBtn_Nav"];
    moreButton.userInteractionEnabled = YES;
    [moreButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMore)]];
    UIBarButtonItem* moreItem = [[UIBarButtonItem alloc]initWithCustomView:moreButton];
    self.navigationItem.rightBarButtonItem = moreItem;
}

-(void)showMore{
    [self.popMenu showMenuOnView:self.navigationController.view atPoint:CGPointZero];
    self.popMenu.width += 150;
}
#pragma mark config popMenu
- (XHPopMenu *)popMenu {
    if (!_popMenu) {
        NSMutableArray *popMenuItems = [[NSMutableArray alloc] initWithCapacity:8];
        for (int i = 0; i < 8; i ++) {
            NSString *imageName;
            NSString *title;
            switch (i) {
                case 0: {
                    imageName = @"contacts_add_newmessage";
                    title = @"发表日程";
                    break;
                }
                case 1: {
                    imageName = @"contacts_add_friend";
                    title = @"修改群资料";
                    break;
                }
                case 2: {
                    imageName = @"contacts_add_newmessage";
                    title = @"管理成员";
                    break;
                }
                case 3: {
                    imageName = @"contacts_add_friend";
                    title = @"设为星标";
                    break;
                }
                case 4: {
                    imageName = @"contacts_add_newmessage";
                    title = @"通知设置";
                    break;
                }
                case 5: {
                    imageName = @"contacts_add_friend";
                    title = @"设置群隐私";
                    break;
                }
                case 6: {
                    imageName = @"contacts_add_newmessage";
                    title = @"分享改群";
                    break;
                }
                case 7: {
                    imageName = @"contacts_add_friend";
                    title = @"解散该群";
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


-(void)viewWillDisappear:(BOOL)animated{
    memberTableView.right = kScreen_Width;
    scheduleTableView.left = kScreen_Width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == memberTableView) {
        return 10;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"menCell";
    GroupMemberCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GroupMemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
