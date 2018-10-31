//
//  HXFCalendarCell.h
//  HXFCalendar
//
//  Created by 玉岳鹏 on 2018/10/8.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface HXFCalendarCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *calendarTitleColor;

@property (nonatomic, assign) BOOL isDaka;
@end

//NS_ASSUME_NONNULL_END
