//
//  XmDateAndCalendar.m
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/30.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmDateAndCalendar.h"

@implementation XmDateAndCalendar


+(NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}
+(NSDate *)dateFromString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:string];
}

+(NSString *) stringFromDate:(NSDate *)date withTime:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [[formatter stringFromDate:date] stringByAppendingString:time];
    return string;
}

+(NSDateComponents *) dateCompnFromUnits:(NSUInteger) units {
    if (calendar==nil) {
       calendar  = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return nil;
}
@end
