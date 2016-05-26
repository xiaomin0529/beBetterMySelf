//
//  DailyPlan.h
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/29.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyPlan : NSObject
@property  int id;
@property (weak,nonatomic) NSString *name;
@property (weak,nonatomic) NSString *content;
@property int state;
@property (weak,nonatomic) NSString *topicImg;
@end
