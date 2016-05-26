//
//  XmAddPlansViewController.m
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/28.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmAddPlansViewController.h"
#import "XmSqlite3Dao.h"
#import "XmAddPlansPresentationViewController.h"
#import "XmDateAndCalendar.h"

@implementation XmAddPlansViewController

- (instancetype)init
{
    if ((self = [super init])) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

-(void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    _planContent.delegate = self;
    _planTitle.delegate = self;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(20, 100, 60, 40);
    titleLabel.text = @"标题";
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.frame = CGRectMake(20, 140, 60, 40);
    contentLabel.text  = @"内容";
    
    self.planTitle = [[UITextField alloc] init];
    self.planTitle.frame = CGRectMake(70, 100, 140, 40);
    self.planTitle.placeholder = @"标题";
    
    self.planContent = [[UITextField alloc] init];
    self.planContent.frame = CGRectMake(70, 140, 140, 40);
    self.planContent.placeholder = @"内容";
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(5, 2, 60, 40);
    [cancelBtn addTarget:self action:@selector(dismissVC:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    finishBtn.frame = CGRectMake(300, 2, 60, 40);
    [finishBtn addTarget:self action:@selector(addPlanAndDismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:contentLabel];
    [self.view addSubview:self.planTitle];
    [self.view addSubview:self.planContent];
    [self.view addSubview:cancelBtn];
    [self.view addSubview:finishBtn];
    
}



- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSLog(@"presentationControllerForPresentedViewController");
    if (presented == self) {
        NSLog(@"presented self");
        XmAddPlansPresentationViewController *presen = [[XmAddPlansPresentationViewController alloc ]initWithPresentedViewController:presented presentingViewController:presenting];
        
        return presen;
    }
    return nil;
}


#pragma mark textField收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}


#pragma mark - 取消和完成。 都dismiss
- (void)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 完成时，会插入DB，返回，并通知前一VC来更新table
 */
- (void)addPlanAndDismiss:(id)sender {
    NSString *title = self.planTitle.text;
    NSString *content = self.planContent.text;
    NSString *sql = [NSString stringWithFormat:
                     @"insert into DAILY_PLANS (name,content,state,topic_img,important_level,begin_time,target_time) values ('%@','%@',0,'default.png',1,'%@','%@')",
                     title,
                     content,
                     [XmDateAndCalendar stringFromDate:[NSDate date]],
                     [XmDateAndCalendar stringFromDate:[NSDate date] withTime:@" 22:30:00"] //默认当天22.30; 参数前面带空格
                    ];
    [[XmSqlite3Dao sharedInstance] executeUpdate:sql];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissFromAddPlansVC" object:self];
    }];
    
}

@end
