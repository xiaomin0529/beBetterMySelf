//
//  XmDateAndCalendar.h
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/30.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSCalendar *calendar ;

@interface XmDateAndCalendar : NSObject


+(NSString *) stringFromDate:(NSDate *)date;
+(NSDate *) dateFromString:(NSString *)string;
+(NSString *) stringFromDate:(NSDate *)date withTime:(NSString *) time;
+(NSDateComponents *) dateCompnFromUnits:(NSUInteger) units;
@end
