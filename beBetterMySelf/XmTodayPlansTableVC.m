//
//  XmTodayPlansTableVC.m
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/28.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmTodayPlansTableVC.h"
#import "XmDataBaseInit.h"
#import "XmSqlite3Dao.h"
#import "XmTodayPlansService.h"
#import "XmUpdatePlansViewController.h"
#import "XmAddPlansViewController.h"
#import "XmDateAndCalendar.h"

@implementation XmTodayPlansTableVC

-(void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.editing = YES;
    [XmDataBaseInit initDatabase]; //可放在appdelegate中初始化。
    
    //当cell们不够满屏幕时，不显示空白cell
    UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = footView;
    
    //使用modalViewController返回并没有触发viewWillAppear. 但又找不到更直接的方法，网上找了使用通知中心来让让前VC知道并执行方法。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCellToTable) name:@"dismissFromAddPlansVC" object:nil];
}

//动态添加一条cell在最上边
- (void) insertCellToTable {
    _tableData = [NSMutableArray arrayWithArray:[XmTodayPlansService queryLastAllPlans:100]];
    [self.tableView beginUpdates];
    //cell和section索引都是从0开始
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
}

- (IBAction)presentToAddTodayVC:(id)sender {
    XmAddPlansViewController *addPlansVC = [[XmAddPlansViewController alloc] init];
    [self presentViewController:addPlansVC animated:YES completion:nil];
}


#pragma mark - 初次，及从presentedVC返回时刷新. 不包括从modalVC返回
-(void)viewWillAppear:(BOOL)animated {
    _tableData = [NSMutableArray arrayWithArray:[XmTodayPlansService queryLastAllPlans:100]];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"updateTodayPlan"]) {
        XmTodayPlansTableVC *todayTableVC = segue.sourceViewController;
        UITableViewCell *cell = [todayTableVC.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
        UILabel *nameLabel = [cell.contentView viewWithTag:1];
        UILabel *contentLabel = [cell.contentView viewWithTag:2];
        UILabel *idLabel = [cell.contentView viewWithTag:3];
        
        if (idLabel) {
            NSLog(@"%@",idLabel.text);
        }
        XmUpdatePlansViewController *updateVC = segue.destinationViewController;
        [updateVC setValue:idLabel.text forKey:@"idValue"];
        [updateVC setValue:nameLabel.text forKey:@"nameValue"];
        [updateVC setValue:contentLabel.text forKey:@"contentValue"];
    }
}

#pragma mark - 配置行 Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *xmReusedId = @"xmReusedID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xmReusedId forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xmReusedId];
    }
        UILabel *title = [cell.contentView viewWithTag:1];
        UILabel *content = [cell.contentView viewWithTag:2];
        UILabel *planId = [cell.contentView viewWithTag:3];
        UILabel *beginTime = [cell.contentView viewWithTag:4];
        UIProgressView *process = [cell.contentView viewWithTag:5];
        
        title.text = [_tableData[indexPath.row] valueForKey:@"name"];
        content.text = [_tableData[indexPath.row] valueForKey:@"content"];
        planId.text = [_tableData[indexPath.row] valueForKey:@"Id"];  //可能 id是关键字， 使用Id时就能取出来了
        //int planId = [[_tableData[indexPath.row] valueForKey:@"Id"] intValue];
        //cell.tag = planId;
        //右上角-新建的时间
        NSString *beginTimeStr = [_tableData[indexPath.row] valueForKey:@"begin_time"];
        NSString *tagetTimeStr = [_tableData[indexPath.row] valueForKey:@"target_time"];
        if (beginTimeStr) {
            
            beginTime.text = [beginTimeStr substringWithRange:NSMakeRange(11, 5)];
            //TODO
        } else {
            beginTime.text = @"无时间";
        }
        
        //进度条
        if (beginTimeStr && tagetTimeStr) {
            NSDate *beginDate = [XmDateAndCalendar dateFromString:beginTimeStr];
            NSDate *targetDate = [XmDateAndCalendar dateFromString:tagetTimeStr];
            NSDate *nowDate = [NSDate date];
            
            if (targetDate.timeIntervalSince1970 > nowDate.timeIntervalSince1970) {
                float rate = [nowDate timeIntervalSinceDate:beginDate] / [targetDate timeIntervalSinceDate:beginDate];
                process.progress = rate;
            }
        } else {
            process.hidden = YES;
        }
    
    return cell;
}


#pragma mark - 左划出现操作按钮
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //置顶
    UITableViewRowAction *topAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath2) {
        
        [self.tableView beginUpdates];
        //取出数据， 删掉+反映tableView, 插入首位+反映tableView
        id topData = [_tableData objectAtIndex:indexPath.row];
        [_tableData removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //插入首位
        [_tableData insertObject:topData atIndex:0];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        //将moveRow换成delete + insert
       // NSIndexPath *topIndex = [NSIndexPath indexPathForRow:0 inSection:indexPath2.section];
        //[tableView moveRowAtIndexPath:indexPath2 toIndexPath:topIndex];
        
    }];
    topAction.backgroundColor = [UIColor lightGrayColor];
    //完成
    UITableViewRowAction *completeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"完成" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath2) {
        
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
    }];
    completeAction.backgroundColor = [UIColor greenColor];
    return @[completeAction,topAction];
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"commit");
//}

//-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"will edit");
//}

#pragma mark - 展示多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *planArr = [XmTodayPlansService queryLastAllPlans:100];
    return planArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
