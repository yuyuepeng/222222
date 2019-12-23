//
//  RMYMasController.m
//  22222
//
//  Created by 扶摇先生 on 2019/11/27.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//
#import "RMYMasController.h"
#import "RMYMaskCell.h"
void didLayOut (void (^layout)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (layout) {
            layout();
        }
    });
}

@interface RMYMasController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UIView *RMYNewChangeLayer;

@property(nonatomic, assign) CGFloat addHeight;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation RMYMasController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, mainWidth, mainHeight - Height_NavBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *data = [NSMutableArray arrayWithArray:@[@"我是你老公啊你是我老婆啊",@"我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊我是你老公啊你是我老婆啊",@"我是你老公啊你是我老啊你是我老婆啊"]];
    self.dataArray = data;
    [self.view addSubview:self.tableView];
    
//    _addHeight = 100;
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 60, 60)];
//
//
//    button.backgroundColor = [UIColor brownColor];
//    [button addTarget:self action:@selector(changeFrame:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).offset(10);
//        make.top.mas_equalTo(self.view).offset(_addHeight);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//    }];
//
//       didLayOut(^{
//           NSLog(@"LayerFrame %@",NSStringFromCGRect(button.frame));
//       });
//    _RMYNewChangeLayer = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame) + 10, 100, 100)];
//    _RMYNewChangeLayer.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:_RMYNewChangeLayer];
//    [_RMYNewChangeLayer mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(button.mas_right).with.offset(10);
//        make.top.mas_equalTo(button.mas_bottom).with.offset(10);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//    }];
//    WeakSelf
//    didLayOut(^{
//        NSLog(@"LayerFrame %@",NSStringFromCGRect(weakSelf.RMYNewChangeLayer.frame));
//    });
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RMYMaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RMYMaskCellID"];
    if (cell == nil) {
        cell = [[RMYMaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RMYMaskCellID"];
    }
    [cell refreshText:self.dataArray[indexPath.row]];
    return cell;
}
- (void)changeFrame:(UIButton *)button {
//    BOOL decrease = NO;
//    CGFloat originY = _RMYNewChangeLayer.y;
//    if (_RMYNewChangeLayer.bottom + 50 > mainHeight && (decrease)) {
//        _addHeight -= 50;
//    }else if(_RMYNewChangeLayer.y < 50 &&(!decrease)) {
//        _addHeight += 50;
//    }else {
//        _addHeight += 50;
//    }
//    CGFloat newY = _RMYNewChangeLayer.y;
//    if (newY > originY) {
//        decrease = NO;
//    }else {
//        decrease = YES;
//
//    }
//
//    [button mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).offset(_addHeight);
//    }];
//    WeakSelf
//    didLayOut(^{
//        NSLog(@"LayerFrame %@",NSStringFromCGRect(weakSelf.RMYNewChangeLayer.frame));
//    });
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
