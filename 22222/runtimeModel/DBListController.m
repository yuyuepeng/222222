//
//  DBListController.m
//  22222
//
//  Created by 王国良 on 2020/1/8.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "DBListController.h"
#import "RMYVideoModel.h"
#import "RMYVideoDownLoadCell.h"
@interface DBListController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray <RMYVideoModel *>*dataSource;

@property(nonatomic, strong) UITableView *tableView;


@end

@implementation DBListController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, mainWidth, mainHeight - Height_NavBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 44;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray arrayWithArray:[RMYVideoModel findAll]];
    for (RMYVideoModel *model in _dataSource) {
        NSLog(@"%@ --- ",model.sandBoxPath);
    }
    [self.view addSubview:self.tableView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(mainWidth - 64, 100, 44, 44)];
    [button setTitle:@"下载3个" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
- (void)buttonClick:(UIButton *)button {
    for (NSInteger i = 0 ; i < 3; i ++) {
        NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:0.2f repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"i = %ld", i);
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSRunLoopCommonModes];
//        timer1 = i;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RMYVideoDownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RMYVideoDownLoadCellID"];
    if (cell == nil) {
        cell = [[RMYVideoDownLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RMYVideoDownLoadCellID"];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
