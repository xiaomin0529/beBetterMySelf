//
//  XmUpdatePlansViewController.m
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/29.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmUpdatePlansViewController.h"
#import "XmSqlite3Dao.h"
#import "XmDateAndCalendar.h"

@implementation XmUpdatePlansViewController

-(void)viewDidLoad {
    if (_idValue) {
        _planId.text = _idValue;
    }
    if (_nameValue) {
        _name.text = _nameValue;
    }
    if (_contentValue) {
        _content.text = _contentValue;
    }
    
    _content.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tapGesture];
    
}

-(void)hideKeyBoard {
    [self.view endEditing:YES];
}

- (IBAction)updatePlan:(id)sender {
    NSString *sql = [NSString stringWithFormat:@"update DAILY_PLANS set name='%@',content='%@' where id=%@ ",_name.text,_content.text,_planId.text];
    [[XmSqlite3Dao sharedInstance] executeUpdate:sql];
    
}
- (IBAction)deletePlan:(id)sender {
    NSString *sql = [NSString stringWithFormat:@"update DAILY_PLANS set state=1,completed_time='%@' where id=%@ ",
                     [XmDateAndCalendar stringFromDate:[NSDate date]],
                     _planId.text
                     ];
    [[XmSqlite3Dao sharedInstance] executeUpdate:sql];
}

@end
