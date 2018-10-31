//
//  HXFCalendarView.m
//  HXFCalendar
//
//  Created by 玉岳鹏 on 2018/10/8.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "HXFCalendarView.h"
#import "HXFCalendarCell.h"
@interface HXFCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL todayBool;  // 是否是今日
    NSInteger dayInWeek; // 本月第一天是周几
    NSInteger currentMonth;//当前月
    NSInteger currentDay;//当前日
    NSInteger currentYear;//当前年份
}

@property(nonatomic, strong) UICollectionView *calendarCollectionView;

@property(nonatomic, strong) UIView * weekView;
@property (nonatomic,copy)NSString *systemDate; //当前系统时间
@property (nonatomic, assign)NSInteger systemDay;

@property(nonatomic, strong)NSArray <NSNumber *>*dakaArr;//打卡的时间数组

/*
 ****用来存放天数的数组
 */
@property (nonatomic,strong)NSMutableArray * dayArray; // cell所有数据
@property (nonatomic, assign)NSInteger monthLength; // 当前月有多少天

@property (nonatomic, assign) NSInteger selectedRow;// 选择的日期

@end



@implementation HXFCalendarView {
    CGFloat selfWidth;
    CGFloat selfHeight;
}
- (NSMutableArray *)dayArray {
    if (_dayArray == nil) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}
- (UIView *)weekView {
    if (_weekView == nil) {
        _weekView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, selfWidth, 50)];
        NSArray <NSString *>*arr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        for (NSInteger i = 0; i < arr.count; i ++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(selfWidth/7 * i, 0, selfWidth/7, 50)];
            [button setTitle:[NSString stringWithFormat:@"周%@",arr[i]] forState:UIControlStateNormal];
            if (i == 0) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

            }else {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [_weekView addSubview:button];
        }
    }
    return _weekView;
}
- (UICollectionView *)calendarCollectionView {
    if (_calendarCollectionView == nil) {
        _calendarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, selfWidth, selfHeight - 70) collectionViewLayout:[self createFlowLayout2]];
        _calendarCollectionView.dataSource = self;
        _calendarCollectionView.delegate = self;
        _calendarCollectionView.backgroundColor = [UIColor whiteColor];
        [_calendarCollectionView registerClass:[HXFCalendarCell class] forCellWithReuseIdentifier:@"HXFCalendarCell"];
        [self showCalendarDate:[NSDate date]];

    }
    return _calendarCollectionView;
}
- (UICollectionViewFlowLayout *)createFlowLayout2 {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    CGFloat width = (SCREENW - 60 * singleLength)/2;
    //    UIEdgeInsetsMake(CGFloat top, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//    layout.sectionInset = UIEdgeInsetsMake(0, 15 , 0, 15);
//    layout.itemSize = CGSizeMake(330 * px, 390 * px);
    //    layout.itemSize = CGSizeMake(360 * singleLength, 540 * singleLength);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0 ;
    layout.minimumLineSpacing = 0 ;
    return layout;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    selfWidth = self.bounds.size.width;
    selfHeight = self.bounds.size.height;
    _dakaArr = @[@(1),@(2),@(7),@(26) ,@(22),@(12),@(18)];
    if (self) {
        [self initDataSource];
        [self createViews];
    }
    return self;
}
- (void)createViews {
    [self addSubview:self.weekView];
    [self addSubview:self.calendarCollectionView];
    
}
-(void)initDataSource{
    
    
    _calendar = [NSCalendar currentCalendar];
    NSDate *date2;
    NSDateComponents *nowDate;
    nowDate = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    _monthLength = [self calculationThisMonthDays:[NSDate date]];
    
    date2 = [NSDate date];
    currentYear = nowDate.year;
    currentMonth = nowDate.month;
    currentDay = nowDate.day;
    todayBool = YES;
    self.selectedRow = -1;// 重置已选日期
    
}

// 返回今日
- (void)toDayClick{
    [self.dayArray removeAllObjects];
    self.selectedRow = -1;// 重置已选日期
    todayBool = YES;
    
    [self showCalendarDate:[NSDate date]];
    
    [self.calendarCollectionView reloadData];
}

//请求下一个月的数据
-(void)NextbuttonClick{
    
    [self.dayArray removeAllObjects];
    self.selectedRow = -1;// 重置已选日期
    
    if (_month == 12) {
        _month = 1;
        _year++;
    }else{
        _month++;
    }
    [self showCalendarDate:nil];
    [self setMydayArrayWithYear:_year AndMonth:_month AndDay:_day];
    
    [self.calendarCollectionView reloadData];
    
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                    } completion:^(BOOL finished) {
                    }];
    
}
//请求下一个年的数据
-(void)NextbuttonClick1 {
    
    [self.dayArray removeAllObjects];
    self.selectedRow = -1;// 重置已选日期
    
    
    _year++;
    [self showCalendarDate:nil];
    [self setMydayArrayWithYear:_year AndMonth:_month AndDay:_day];
    
    [self.calendarCollectionView reloadData];
    
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                    } completion:^(BOOL finished) {
                    }];
    
}
//请求上一个月的数据
-(void)LastMonthClick{
    
    [self.dayArray removeAllObjects];
    self.selectedRow = -1;// 重置已选日期
    
    if (_month == 1) {
        _month = 12;
        _year--;
    }else{
        _month--;
    }
    [self showCalendarDate:nil];
    [self setMydayArrayWithYear:_year AndMonth:_month AndDay:_day];
    
    [self.calendarCollectionView reloadData];
    
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                    } completion:^(BOOL finished) {
                    }];
}


- (void)loadSelectIndexPath:(NSIndexPath *)indexPath{
    // 计算日期 年月日
    NSString *dayDate =  [self selectMonthDay:(long)indexPath.row + 1 - dayInWeek];
    [self selectDate:dayDate showStatus:@""];
}
// 选中的时间差 @"yyyy-MM-dd" 设置日期
- (void)selectDate:(NSString *)dayDate showStatus:(NSString *)status{
    NSArray *arraySystem = [_systemDate componentsSeparatedByString:@"-"];
    NSArray *arrayDate = [dayDate componentsSeparatedByString:@"-"];
    if ([status isEqualToString:@"-1"]) { // 选择日期时候对比 如果和系统时间年月一致 就显示进入
        if ([arraySystem[0] integerValue] == [arrayDate[0] integerValue] & [arraySystem[1] integerValue] == [arrayDate[1] integerValue]) {
            todayBool = YES;
        }else{
            todayBool = NO;
        }
        _selectedRow = dayInWeek + [arrayDate[2] integerValue] - 1; //picker 选择日期
    }
    
    NSDate* target = [[self showDateFormatter] dateFromString:dayDate];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDate* now = [NSDate date];
    NSDateComponents* diff = [calendar components:unit fromDate:now toDate:target options:0];
    
    NSInteger week = [_calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:target];
    
    //    NSLog(@"时间差:\n" "year: %ld\n" "month: %ld\n" "day:%ld\n" "hour:%ld\n" "minute:%ld\n" "second:%ld\n", diff.year, diff.month, diff.day, diff.hour, diff.minute, diff.second);
    
    NSString *distanceTime;
    diff.hour > 0 ? diff.day++ : diff.day;
    if (diff.day > 0) { // 多少日后
        
        if (diff.year > 0) {
            distanceTime = [NSString stringWithFormat:@"%ld年%ld月%ld日(%ld年%ld月%ld日后)第%ld周",[arraySystem[0] integerValue],[arraySystem[1] integerValue],[arraySystem[2] integerValue],diff.year, diff.month, diff.day,week];
        }
        if (diff.year == 0) {
            distanceTime = [NSString stringWithFormat:@"%ld年%ld月%ld日(%ld月%ld日后)第%ld周",[arraySystem[0] integerValue],[arraySystem[1] integerValue],[arraySystem[2] integerValue], diff.month, diff.day,week];
        }
        if (diff.month == 0) {
            distanceTime = [NSString stringWithFormat:@"%ld年%ld月%ld日(%ld日后)第%ld周",[arraySystem[0] integerValue],[arraySystem[1] integerValue],[arraySystem[2] integerValue],diff.day,week];
        }
        
    }else if (diff.day < 0){ // 多少日前
        
        if (diff.year < 0) {
            distanceTime = [NSString stringWithFormat:@"%ld年%ld月%ld日(%ld年%ld月%ld日前)第%ld周",[arraySystem[0] integerValue],[arraySystem[1] integerValue],[arraySystem[2] integerValue],diff.year, diff.month, diff.day,week];
        }
        if (diff.year == 0) {
            distanceTime = [NSString stringWithFormat:@"%ld年%ld月%ld日(%ld月%ld日前)第%ld周",[arraySystem[0] integerValue],[arraySystem[1] integerValue],[arraySystem[2] integerValue], diff.month, diff.day,week];
        }
        if (diff.month == 0) {
            distanceTime = [NSString stringWithFormat:@"%ld年%ld月%ld日(%ld日前)第%ld周",[arraySystem[0] integerValue],[arraySystem[1] integerValue],[arraySystem[2] integerValue],diff.day,week];
        }
        
    }else{
        distanceTime = [NSString stringWithFormat:@"%ld年%ld月%ld日 第%ld周",[arraySystem[0] integerValue],[arraySystem[1] integerValue],[arraySystem[2] integerValue],week];
    }
    [self.calendarCollectionView reloadData]; // 选中日历刷新
    
    self.day = [arrayDate[2] integerValue];
    
    // block返回当前月份
    NSString *replacingDistance = [distanceTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (self.returnValueBlock) {
        self.returnValueBlock(replacingDistance);
    }
}
- (NSString *)selectMonthDay:(NSInteger)row{
    NSString *selectDate;
    if (row < 1) { // 上月
        
        [self LastMonthClick];
        NSInteger daySelect =  _monthLength + (long)row;
        _day = daySelect;
        selectDate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)_year,(long)_month,(long)daySelect];
        
        [self selectMonthClick:daySelect];
        
    }else if(row > _monthLength){ // 下月
        
        NSInteger daySelect = (long)row - _monthLength;//本月的总长度
        _day = daySelect;
        [self NextbuttonClick];
        selectDate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)_year,(long)_month,daySelect];
        
        [self selectMonthClick:daySelect];
        
    }else{
        selectDate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)_year,(long)_month,(long)row];
    }
    return selectDate;
}
// 选择不是本月内容进行跳转
- (void)selectMonthClick:(NSInteger)daySelect{
    _selectedRow = dayInWeek + daySelect - 1;
}
//请求上一个月的数据
-(void)LastMonthClick1{
    
    [self.dayArray removeAllObjects];
    self.selectedRow = -1;// 重置已选日期
    _year--;
    [self showCalendarDate:nil];
    [self setMydayArrayWithYear:_year AndMonth:_month AndDay:_day];
    
    [self.calendarCollectionView reloadData];
    
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                    } completion:^(BOOL finished) {
                    }];
}
// 刷新月份 DatePicker
- (void)refreshMonth:(NSInteger)year AndMonth:(NSInteger)month AndDay:(NSInteger)day{
    [self.dayArray removeAllObjects];
    [self showCalendarDate:nil];
    [self setMydayArrayWithYear:year AndMonth:month AndDay:day];
    [self.calendarCollectionView reloadData];
}

// 显示 年 月 日 一月有几天
- (void)showCalendarDate:(NSDate *)date{
    NSDateComponents * nowDate;
    NSDate *date2;
    if (date) { // 初始化 今日
        nowDate = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
        _monthLength = [self calculationThisMonthDays:[NSDate date]];
        
        NSInteger week = [_calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:[NSDate date]]; // 今天是今年的第多少周
        date2 = [NSDate date];
        
        _year = nowDate.year;
        _month = nowDate.month;
        _systemDay = nowDate.day;
        _day = nowDate.day;
        _systemDate = [NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_systemDay];
        [self setMydayArrayWithYear:_year AndMonth:_month AndDay:_systemDay];//给dayarray赋值
        
        NSArray *arraySystem = [_systemDate componentsSeparatedByString:@"-"];
        NSString *distanceTime = [NSString stringWithFormat:@"%ld年%ld月%ld日 第%ld周",[arraySystem[0] integerValue],[arraySystem[1] integerValue],[arraySystem[2] integerValue],week];
        if (self.returnValueBlock) {
            self.returnValueBlock(distanceTime);
        }
        
    }else{ // 上月 下月
        NSInteger dayNumber = [self getDaysInMonth:_year month:_month];
        if (_day > dayNumber) {
            _day = dayNumber;
        }
        NSDate * nowDate2 = [[self showDateFormatter] dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day]];
        nowDate = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:nowDate2];
        date2 = nowDate2;
        
        // 显示今日
        NSArray *arraySystem = [_systemDate componentsSeparatedByString:@"-"];
        if ([arraySystem[0] integerValue] == nowDate.year & [arraySystem[1] integerValue] == nowDate.month) {
            todayBool = YES;
        }else{
            todayBool = NO;
        }
        _monthLength = [self calculationThisMonthDays:nowDate2];
    }
    [self calculationThisMonthFirstDayInWeek:date2];
    if (self.returnTitleValueBlock) {
        self.returnTitleValueBlock([NSString stringWithFormat:@"%ld年%ld月",(long)_year,(long)_month]);
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dayArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(selfWidth/7,selfWidth/7);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 点击本月
    _selectedRow = indexPath.row;
    
    [self loadSelectIndexPath:indexPath];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXFCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXFCalendarCell" forIndexPath:indexPath];
    cell.isDaka = false;
    cell.title = self.dayArray[indexPath.row];
    if (indexPath.row < dayInWeek || (indexPath.row) % 7 == 0 || (indexPath.row) % 7 == 6) {
        if (indexPath.row < dayInWeek || indexPath.row >= (_monthLength + dayInWeek)) {
            cell.calendarTitleColor = [UIColor grayColor];
            cell.isDaka = false;
        }else{ // 是否属于双休日
            cell.calendarTitleColor = [UIColor redColor];
            if (currentYear == _year) {
                if (currentMonth == _month) {
                    if ([_dakaArr containsObject:[NSNumber numberWithInteger:indexPath.row + 1 - dayInWeek]]) {
                        cell.isDaka = YES;
                        NSLog(@"daka == %@",[NSNumber numberWithInteger:indexPath.row + 1 - dayInWeek]);
                        NSLog(@"set = %@",[NSSet setWithArray:_dakaArr]);
                    }
                }else {
                    cell.isDaka = false;
                }
            }else {
                cell.isDaka = false;
            }
        }
    }else{ // 本月日期
        if (indexPath.row < (_monthLength + dayInWeek)) {
            cell.calendarTitleColor = [UIColor blackColor];
            if (currentYear == _year) {
                if (currentMonth == _month) {
                    if ([_dakaArr containsObject:[NSNumber numberWithInteger:indexPath.row + 1 - dayInWeek]]) {
                        cell.isDaka = YES;
                        NSLog(@"daka == %@",[NSNumber numberWithInteger:indexPath.row + 1 - dayInWeek]);
                    }
                }else {
                    cell.isDaka = false;
                }
            }else {
                cell.isDaka = false;
            }
            
        }else{
            cell.calendarTitleColor = [UIColor grayColor];
            cell.isDaka = false;
        }
        
    }
    // 标示今天
    if (todayBool == YES) {
        if (indexPath.row == (_systemDay + dayInWeek) -1) {
            cell.title = @"今日";
            cell.calendarTitleColor = [UIColor redColor];
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    
    if (_selectedRow == indexPath.row) {
        cell.backgroundColor = kUIColorFromHex(0x3B9FF7);
    }
    return cell;
}

-(void)setMydayArrayWithYear:(NSInteger)year AndMonth:(NSInteger)month AndDay:(NSInteger)day{
    
    NSInteger dayNumber = [self getDaysInMonth:year month:month];
    if (day > dayNumber) {
        day = dayNumber;
    }
    NSDate * nowDate = [[self showDateFormatter] dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day]];
    
    // 当月
    NSRange dayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:nowDate];
    // 上月
    NSRange lastdayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self setLastMonthWithYear:year AndMonth:month AndDay:day]];
    
    NSDate *NowMonthfirst = [[self showDateFormatter] dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",year,month,1]];
    NSDateComponents * components = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:NowMonthfirst];
    
    NSDate * nextDay = [[self showDateFormatter] dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,dayRange.length]];
    NSDateComponents * lastDay = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:nextDay];
    
    for (NSInteger i = lastdayRange.length - components.weekday + 2; i <= lastdayRange.length; i++) {
        
        NSString * string = [NSString stringWithFormat:@"%ld",i];
        [self.dayArray addObject:string];
    }
    for (NSInteger i = 1; i <= dayRange.length ; i++) {
        
        NSString * string = [NSString stringWithFormat:@"%ld",i];
        [self.dayArray addObject:string];
    }
    for (NSInteger i = 1; i <= (7 - lastDay.weekday); i++) {
        
        NSString * string = [NSString stringWithFormat:@"%ld",i];
        [self.dayArray addObject:string];
    }
}

-(NSDate*)setLastMonthWithYear:(NSInteger)year AndMonth:(NSInteger)month AndDay:(NSInteger)day{
    NSDate * date = nil;
    if (month != 1) {
        NSInteger dayNumber = [self getDaysInMonth:year month:month-1];
        if (day > dayNumber) {
            day = dayNumber;
        }
        date = [[self showDateFormatter] dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",year,month-1,day]];
    }else{
        NSInteger dayNumber = [self getDaysInMonth:year month:12];
        if (day > dayNumber) {
            day = dayNumber;
        }
        date = [[self showDateFormatter] dateFromString:[NSString stringWithFormat:@"%ld-%d-%ld",year,12,day]];
    }
    return date;
}


#pragma mark - 计算本月天数
- (NSInteger)calculationThisMonthDays:(NSDate *)days
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    if (isEmpty(days)) {
        days = [NSDate date];
    }
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:days];
    return range.length;
}

#pragma mark - 计算本月第一天是周几
- (void)calculationThisMonthFirstDayInWeek:(NSDate *)date;
{
    if (isEmpty(date)) {
        date = [NSDate date];
    }
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    NSDateComponents * theComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
    comps = [calendar components:unitFlags fromDate:date];
    theComps = [calendar components:unitFlags fromDate:[NSDate date]];
    //    NSInteger theMonth = [theComps month];// 本月的月份
    NSUInteger day = [comps day];// 是本月第几天
    //    NSInteger todayInMonth = day;
    //    NSString *dateStr = [[self showDateFormatter] stringFromDate:date];
    //    NSString *todayStr = [dateFormatter stringFromDate:[NSDate date]];
    if (day > 1) {// 如果不是本月第一天
        // 将日期推算到本月第一天
        NSInteger hours = (day - 1) * -24;
        date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:date];
    }
    comps = [calendar components:unitFlags fromDate:date];
    dayInWeek = [comps weekday] - 1;// 是周几
    
    //    NSInteger year = [comps year];// 公历年
    //    NSInteger month = [comps month];// 公里月
    //    if ([dateStr isEqualToString:todayStr]) {
    //        NSLog(@"%ld",(long)day + dayInWeek - 2);
    //    }
}


- (NSDateFormatter *)showDateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return dateFormatter;
}

// 获取某年某月总共多少天
- (NSInteger)getDaysInMonth:(NSInteger)year month:(NSInteger)imonth {
    // imonth == 0的情况是应对在CourseViewController里month-1的情况
    if((imonth == 0)||(imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
