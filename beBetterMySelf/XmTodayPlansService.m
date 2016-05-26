//
//  XmTodayPlansService.m
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/29.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmTodayPlansService.h"

@implementation XmTodayPlansService

+(NSArray *)queryLastAllPlans:(int)maxCount {
    NSString *sql = @"select dp.Id,dp.name,dp.content,dp.state,dp.topic_img,dp.important_level,dp.begin_time,dp.target_time,dp.completed_time,dp.completed_rate,dp.remark from DAILY_PLANS dp where dp.state <> 1 order by dp.Id desc";
    return [[XmSqlite3Dao sharedInstance] executeQuery:sql];
}
@end
