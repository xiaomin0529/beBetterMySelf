//
//  XmSqlite3Dao.m
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/28.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmSqlite3Dao.h"

#ifndef xmDbName

#define xmDbName @"/xmPlan.db"  //网上例子是 @"xx.db" 不带/号的， 导致拼成的路径错误真机不让创建文件。应该最后是/var/.../Document/xmPlan.db

#endif



@implementation XmSqlite3Dao

static XmSqlite3Dao *instance = nil;

#pragma mark - 简单单例模式 之 线程不安全的
+(XmSqlite3Dao *) sharedInstance {
    if (!instance) {
        instance = [[XmSqlite3Dao alloc] init];
        [instance openDB:xmDbName];
    }
    return instance;
}


-(void)openDB:(NSString *)dbName {
    //取得数据库保存路径，通常保存沙盒Documents目录
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"沙盒地址：%@",directory);
    NSString *filePath = [directory stringByAppendingString:dbName];
    
    //打开数据库， 并验证打开状态， 是否成功
    int status = sqlite3_open(filePath.UTF8String, &_ds);
    if (SQLITE_OK == status) {
        NSLog(@"数据库打开成功!");
    }else{
        NSLog(@"数据库打开失败!%d",status);
    }
}


-(void)executeUpdate:(NSString *)sql {
    char * error;
    //单步执行sql语句，用于插入、修改、删除
    if (SQLITE_OK != sqlite3_exec(_ds, sql.UTF8String, NULL, NULL, &error)) {
        NSLog(@"执行SQL语句过程中发生错误！错误信息：%s",error); //error还可输出查看
    } else {
        NSLog(@"执行SQL:%@成功",sql);
    }
}
-(NSArray *)executeQuery:(NSString *)sql {
    NSMutableArray *rows = [NSMutableArray array];
    //评估语法正确性
    sqlite3_stmt *stmt;
    //检查语法正确性
    if (SQLITE_OK == sqlite3_prepare_v2(_ds, sql.UTF8String, -1, &stmt, NULL)) {
        //单步执行sql语句
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            //column数
            int columnCount= sqlite3_column_count(stmt);
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (int i=0; i<columnCount; i++) {
                const char *name= sqlite3_column_name(stmt, i);//取得列名
                const unsigned char *value= sqlite3_column_text(stmt, i);//取得某列的值
                dic[[NSString stringWithUTF8String:name]]= (value)?[NSString stringWithUTF8String:(const char *)value]:nil;
            }
            [rows addObject:dic]; //array<dir>就是返回结果集
        }
    }
    //NSLog(@"共取%lu条数据",rows.count);
    //释放句柄
    sqlite3_finalize(stmt);
    
    return rows;
}
@end
