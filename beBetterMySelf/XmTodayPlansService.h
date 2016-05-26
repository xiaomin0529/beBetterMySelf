//
//  XmTodayPlansService.h
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/29.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XmSqlite3Dao.h"

@interface XmTodayPlansService : NSObject

+(NSArray *) queryLastAllPlans:(int) maxCount;

@end
