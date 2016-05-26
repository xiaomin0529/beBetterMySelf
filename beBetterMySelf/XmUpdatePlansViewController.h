//
//  XmUpdatePlansViewController.h
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/29.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XmUpdatePlansViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *planId;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *content;


//没办法啊， 在segue那 setValue forKey:@"name.text"不行啊， 只能设置NSString啦
@property (weak, nonatomic) NSString *idValue;
@property (weak,nonatomic) NSString * nameValue;
@property (weak, nonatomic) NSString *contentValue;
@end
