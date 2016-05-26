//
//  XmSqlite3Dao.h
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/28.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface XmSqlite3Dao : NSObject

@property (nonatomic) sqlite3 *ds;

+(XmSqlite3Dao *) sharedInstance;

#pragma  mark - 公共方法

/**
 * 打开数据库
 */
- (void) openDB:(NSString *) dbName;


/**
 * 执行不返回值的sql
 */
- (void) executeUpdate:(NSString *) sql;


/**
 * 执行sql, 返回执行结果
 */
- (NSArray *) executeQuery:(NSString *) sql;


@end
