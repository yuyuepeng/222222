//
//  CalendarController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/10.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "CalendarController.h"
#import "HXFCalendarView.h"

@interface CalendarController ()
@property(nonatomic, strong) HXFCalendarView *calendar;
@property(nonatomic, strong) NSArray *weekArray;

@property(nonatomic, strong) UILabel *showTimeLabel;


@property(nonatomic, strong) UIView *changeView;
@end

@implementation CalendarController

- (UILabel *)showTimeLabel {
    if (_showTimeLabel == nil) {
        _showTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kmainHeight/2 + 50, kmainWidth, 50)];
        _showTimeLabel.numberOfLines = 0;
        _showTimeLabel.textColor = [UIColor blueColor];
        _showTimeLabel.textAlignment = NSTextAlignmentCenter;
        _showTimeLabel.font = [UIFont boldSystemFontOfSize:19];
    }
    return _showTimeLabel;
}
- (HXFCalendarView *)calendar {
    if (_calendar == nil) {
        _calendar = [[HXFCalendarView alloc] initWithFrame:CGRectMake(0, 0, kmainWidth, kmainHeight/2)];
    }
    return _calendar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.calendar];
        NSArray *arr = @[@"上一月",@"下一月",@"上一年",@"下一年"];
        for (NSInteger i = 0; i < arr.count; i ++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kmainWidth/(arr.count) * i, kmainHeight/2, kmainWidth/(arr.count), 50)];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.tag = 10 + i;
            [self.view addSubview:button];
        }
        [self.view addSubview: self.showTimeLabel];
        WeakSelf
        self.calendar.returnTitleValueBlock = ^(NSString *strValue) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.showTimeLabel.text = strValue;
            });
        };
        _changeView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _changeView.userInteractionEnabled = YES;
        _changeView.backgroundColor = [UIColor yellowColor];
        [_changeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
        [self.view addSubview:_changeView];
//    for (NSInteger i = 0; i < 4; i ++) {
//        
//    }
}

- (void)tapClick {
    WeakSelf
    [UIView animateWithDuration:0.8f animations:^{
        weakSelf.changeView.frame = CGRectMake(235, 20, 30, 30);
        weakSelf.changeView.layer.masksToBounds = YES;
        weakSelf.changeView.layer.borderColor = [UIColor redColor].CGColor;
        weakSelf.changeView.layer.borderWidth = 1;
        weakSelf.changeView.layer.cornerRadius = 15;
        weakSelf.changeView.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
        
    }];
    
    //    [UIView animateWithDuration:0.8f animations:^{
    //        weakSelf.changeView.frame = CGRectMake(235, 20, 30, 30);
    //
    //    } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:0.02f animations:^{
    //            weakSelf.changeView.layer.masksToBounds = YES;
    //            weakSelf.changeView.layer.borderColor = [UIColor redColor].CGColor;
    //            weakSelf.changeView.layer.borderWidth = 1;
    //            weakSelf.changeView.layer.cornerRadius = 15;
    //            weakSelf.changeView.backgroundColor = [UIColor blueColor];
    //        } completion:^(BOOL finished) {
    //
    //        }];
    //
    //    }];
}
- (void)buttonClick:(UIButton *)button {
    if (button.tag == 10) {
        [self.calendar LastMonthClick];
    }else if (button.tag == 11) {
        [self.calendar NextbuttonClick];
    }else if (button.tag == 12) {
        [self.calendar LastMonthClick1];
    }else if (button.tag == 13) {
        [self.calendar NextbuttonClick1];
    }
    
    
}
- (void)initRecognizer{
    
    //    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
    //    [self.nowMouth addGestureRecognizer:recognizer];
    
    UISwipeGestureRecognizer *recognizer2;
    recognizer2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.calendar addGestureRecognizer:recognizer2];
    
    recognizer2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.calendar addGestureRecognizer:recognizer2];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
