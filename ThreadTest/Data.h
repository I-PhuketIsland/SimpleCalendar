//
//  Data.h
//  ThreadTest
//
//  Created by Lee on 2017/3/3.
//  Copyright © 2017年 李家乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
#pragma mark -- 获取日
+ (NSInteger)day:(NSDate *)date;

#pragma mark -- 获取月
+ (NSInteger)month:(NSDate *)date;

#pragma mark -- 获取年
+ (NSInteger)year:(NSDate *)date;
+ (NSMutableArray *)yearMonthDay:(NSDate *)date;
#pragma mark -- 获得当前月份第一天星期几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

#pragma mark -- 获取当前月共有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
@end
