//
//  JFCreateTodoViewController.m
//  Demo
//
//  Created by syfll on 15/8/17.
//  Copyright (c) 2015年 Phil. All rights reserved.
//

#import "JFCreateTodoViewController.h"
#import "ActionSheetDatePicker.h"
#import "JFTodoCreateSelectionCell.h"


@interface JFCreateTodoViewController ()
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSDate *date;
@end

@implementation JFCreateTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        NSDate * curDate ;
        if (!_date) {
            curDate = [[NSDate alloc]initWithTimeIntervalSinceNow:0];
        }else{
            curDate = _date;
        }
        ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
            _date = selectedDate;
            [self.tableView reloadData];
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            if (picker.cancelButtonClicked) {
                _date = nil;
                [self.tableView reloadData];
            }
        } origin:self.view];

        
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"移除" style:UIBarButtonItemStylePlain target:nil action:nil];
        [barButton setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
                                            NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
        [datePicker setCancelButton:barButton];
        [datePicker showActionSheetPicker];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JFTodoCreateContentCell" forIndexPath:indexPath];
        return cell;
    }
    JFTodoCreateSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:JFTodoCreateSelectionCellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            [cell ConfigeCell:[UIImage imageNamed:@"found_dynamic"] leftText:@"所属类别" rightText:nil];
            break;
        case 1:
            [cell ConfigeCell:[UIImage imageNamed:@"found_dynamic"] leftText:@"执行时间" rightText:[_date stringWithFormat:@"yyyy-MM-dd"]];
            break;
        case 2:
            [cell ConfigeCell:[UIImage imageNamed:@"found_dynamic"] leftText:@"邀请参与" rightText:nil];
            break;
        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
        
    }else{
        return 44;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
