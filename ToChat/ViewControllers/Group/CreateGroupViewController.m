//
//  CreateGroupViewController.m
//  ToChat
//
//  Created by chenlong on 15/9/14.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "CreateGroupViewController.h"
#import "Header.h"
#import "SKTagView.h"
#import "HexColors.h"
#import "TagsTableCell.h"

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
//Cell
static NSString *const kTagsTableCellReuseIdentifier = @"TagsTableCell";

@interface CreateGroupViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *colorPool;
@end

@implementation CreateGroupViewController{
    UITableView* mainTableView;
    UILabel* groupNameLabll;
    UILabel* groupStyleLabel;
    UILabel* groupAddressLabel;
    UILabel* groupIntroduction;
    UIImageView* groupImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"创建群组";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(next)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    mainTableView = [[UITableView alloc]initWithFrame:kScreen_Frame style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    
    [self.view addSubview:mainTableView];
    
    self.colorPool = @[@"#7ecef4", @"#84ccc9", @"#88abda",@"#7dc1dd",@"#b6b8de"];
    //    self.tableView.backgroundColor = [UIColor redColor];
    [mainTableView registerNib:[UINib nibWithNibName:@"TagsTableCell" bundle:nil] forCellReuseIdentifier:kTagsTableCellReuseIdentifier];
}

-(void)next{

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString* cellIdentifier1 = @"cell1";
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                UILabel* l = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 30)];
                l.font = [UIFont systemFontOfSize:15];
                l.text = @"标题:";
                [cell.contentView addSubview:l];
                
                groupNameLabll = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - 220, 7, 200, 30)];
                groupNameLabll.font = [UIFont systemFontOfSize:14];
                groupNameLabll.textAlignment = UITextAlignmentRight;
                groupNameLabll.textColor = [UIColor lightGrayColor];
                groupNameLabll.text = @"输入群名";
                [cell.contentView addSubview:groupNameLabll];
            }
            return cell;
        }
        if (indexPath.row == 1) {
            NSString* cellIdentifier2 = @"cell2";
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
                UILabel* l = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 30)];
                l.font = [UIFont systemFontOfSize:15];
                l.text = @"群类型:";
                [cell.contentView addSubview:l];
                
                groupStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - 220, 7, 200, 30)];
                groupStyleLabel.font = [UIFont systemFontOfSize:14];
                groupStyleLabel.textAlignment = UITextAlignmentRight;
                groupStyleLabel.textColor = [UIColor lightGrayColor];
                groupStyleLabel.text = @"私密群";
                [cell.contentView addSubview:groupStyleLabel];
            }
            return cell;
        }
        if (indexPath.row == 2) {
            NSString* cellIdentifier3 = @"cell3";
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
                UILabel* l = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 30)];
                l.font = [UIFont systemFontOfSize:15];
                l.text = @"群地点:";
                [cell.contentView addSubview:l];
                
                groupAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - 220, 7, 200, 30)];
                groupAddressLabel.font = [UIFont systemFontOfSize:14];
                groupAddressLabel.textAlignment = UITextAlignmentRight;
                groupAddressLabel.textColor = [UIColor lightGrayColor];
                groupAddressLabel.text = @"武汉";
                [cell.contentView addSubview:groupAddressLabel];
            }
            return cell;
        }
    }
    
    if (indexPath.section == 1) {
        TagsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier forIndexPath:indexPath];
        [self configureCell:cell atIndexPath:indexPath];
        //    cell.backgroundColor = [UIColor greenColor];
        return cell;
    }
    
    if (indexPath.section == 2) {
        NSString* cellIdentifier5 = @"cell5";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier5];
            UILabel* l = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 30)];
            l.font = [UIFont systemFontOfSize:15];
            l.text = @"群介绍:";
            [cell.contentView addSubview:l];
            
            groupIntroduction = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, kScreen_Width - 80, 60)];
            groupIntroduction.textColor = [UIColor lightGrayColor];
            groupIntroduction.font = [UIFont systemFontOfSize:13];
            groupIntroduction.text = @"  输入群介绍...";
            groupIntroduction.numberOfLines = 0;
//            groupIntroduction.backgroundColor = [UIColor greenColor];
            [cell.contentView addSubview:groupIntroduction];
            cell.height = 90;
        }
        return cell;
    }
    
    if (indexPath.section == 3) {
        NSString* cellIdentifier6 = @"cell6";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier6];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier6];
            UILabel* l = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 30)];
            l.font = [UIFont systemFontOfSize:15];
            l.text = @"群图片:";
            [cell.contentView addSubview:l];
            
            groupImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 50, 10, 100, 80)];
            groupImageView.image = [UIImage imageNamed:@"AddGroupMemberBtnHL"];
            [cell.contentView addSubview:groupImageView];
            cell.height = 100;
        }
        return cell;
    }
    
    return  nil;
}

- (void)configureCell:(TagsTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    cell.tagView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
    cell.tagView.insets    = 15;
    cell.tagView.lineSpace = 10;
    
    [cell.tagView removeAllTags];
    
    //Add Tags
    [@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C",@"C", @"PHP"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SKTag *tag = [SKTag tagWithText:obj];
         tag.textColor = [UIColor whiteColor];
         tag.fontSize = 15;
         tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
         tag.bgColor = [UIColor colorWithHexString:self.colorPool[idx % self.colorPool.count] alpha:1];
         tag.cornerRadius = 5;
         tag.enable = NO;
         
         [cell.tagView addTag:tag];
     }];
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        TagsTableCell *cell = nil;
        if (!cell)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier];
        }
        
        [self configureCell:cell atIndexPath:indexPath];
        return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
