//
//  XmAddPlansViewController.h
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/28.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface XmAddPlansViewController : UIViewController <UITextFieldDelegate,UIViewControllerTransitioningDelegate>
@property (weak, nonatomic)  UITextField *planTitle;
@property (weak, nonatomic)  UITextField *planContent;

#pragma mark C语言库的不能加weak,strong修饰， 它们只能修饰对象
@property (nonatomic) sqlite3 *database;
@end
