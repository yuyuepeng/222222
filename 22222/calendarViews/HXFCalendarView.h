//
//  HXFCalendarView.h
//  HXFCalendar
//
//  Created by 玉岳鹏 on 2018/10/8.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnValueBlock) (NSString *strValue);
typedef void (^ReturnTitleValueBlock) (NSString *strValue);

NS_ASSUME_NONNULL_BEGIN

@interface HXFCalendarView : UIView
/**
 *  声明一个ReturnValueBlock属性，这个Block是获取传值的界面传进来的
 */
@property(nonatomic, copy) ReturnValueBlock returnValueBlock; //  底部显示选中 name
@property(nonatomic, copy) ReturnTitleValueBlock returnTitleValueBlock; // title name

@property (nonatomic, assign)NSInteger year;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, assign)NSInteger day;
@property (nonatomic,strong)NSCalendar *calendar;

-(void)LastMonthClick;
-(void)NextbuttonClick;
-(void)NextbuttonClick1;
-(void)LastMonthClick1;
- (void)toDayClick;

- (void)initDataSource; // 初始化

// 刷新月份
- (void)refreshMonth:(NSInteger)year AndMonth:(NSInteger)month AndDay:(NSInteger)day;
- (void)selectDate:(NSString *)dayDate showStatus:(NSString *)status;
- (NSDateFormatter *)showDateFormatter;
@end

NS_ASSUME_NONNULL_END
