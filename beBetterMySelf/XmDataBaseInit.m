//
//  XmDataBaseInit.m
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/28.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmDataBaseInit.h"
#import "XmSqlite3Dao.h"

@implementation XmDataBaseInit

+(void)initDatabase{
    NSString *key=@"hasCreatedDb";   //用自定义key验证用户是否已经执行过创建DB了。
    NSUserDefaults *defaults=[[NSUserDefaults alloc]init];
    if ([[defaults valueForKey:key] intValue]!=1) {
        NSLog(@"用户第一次进入程序，初始化数据库表结构");
        [self createDailyPlanTable];
        [self createPlanRouteTable];
        [defaults setValue:@1 forKey:key];
    } else {
        NSLog(@"非第一次登陆，各表已经创建齐了。");
    }
    //TODO 以后每次更新表结构怎么办？ 不能drop表再建，数据不答应。根据上面自定义的key来吗？ 上面代码重来几次？
}

+(void)createDailyPlanTable{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS DAILY_PLANS (Id integer PRIMARY KEY AUTOINCREMENT,name text,content text,state text,topic_img text,important_level text,begin_time date,target_time date,completed_time date,completed_rate integer,remark text)";
    [[XmSqlite3Dao sharedInstance] executeUpdate:sql];
}

+(void)createPlanRouteTable{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS PLAN_ROUTE (Id integer PRIMARY KEY AUTOINCREMENT,plan_id integer,state integer,update_time date,reason text)";
    [[XmSqlite3Dao sharedInstance] executeUpdate:sql];
}


//+(void)createStatusTable{
//    NSString *sql=@"CREATE TABLE IF NOT EXISTS Status (Id integer PRIMARY KEY AUTOINCREMENT,source text,createdAt date,\"text\" text,user integer REFERENCES User (Id))";
//    [[XmSqlite3Dao sharedInstance] executeUpdate:sql];
//}

@end
