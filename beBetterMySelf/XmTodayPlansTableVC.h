//
//  XmTodayPlansTableVC.h
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/28.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XmTodayPlansTableVC : UITableViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *tableData;

@end
