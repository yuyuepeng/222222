//
//  TableViewRefreshController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/12.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "TableViewRefreshController.h"
#import <MJRefresh.h>
@interface TableViewRefreshController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray <NSString *>*datasouce;

@property(nonatomic, assign) NSInteger page ;

@property(nonatomic, strong) UIImageView *rocketView;

@property(nonatomic, strong) CABasicAnimation *groupAnimations;

@end

@implementation TableViewRefreshController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, mainWidth, mainHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (CABasicAnimation *)groupAnimations {
    if (_groupAnimations == nil) {
        _groupAnimations = [TableViewRefreshController scale:@(1.2) orgin:@(0.8) durTimes:10 Rep:MAXFLOAT];
    }
    return _groupAnimations;
}
- (UIImageView *)rocketView {
    if (_rocketView == nil) {
        _rocketView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - 80, 40, 80)];
        _rocketView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _rocketView.centerX = mainWidth/2;
        
    }
    return _rocketView;
}
- (NSMutableArray<NSString *> *)datasouce {
    if (_datasouce == nil) {
        _datasouce = [NSMutableArray array];
    }
    return _datasouce;
}
#pragma mark =====缩放-=============
+ (CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = Multiple;
    animation.toValue = orginMultiple;
    animation.autoreverses = NO;
    animation.repeatCount = repertTimes;
    animation.duration = time;//不设置时候的话，有一个默认的缩放时间.
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return  animation;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self.view addSubview:self.tableView];
    [self loadData];
    [self.view addSubview:self.rocketView];
    WeakSelf
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadData];
        //        [UIView animateWithDuration:1 animations:^{
        //            weakSelf.rocketView.centerY = 190;
        //        }];
    }];
    self.tableView.mj_header = header;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf loadData];
    }];
//    [self.tableView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    if (self.rocketView.centerY == 190) {
        [self.rocketView.layer addAnimation:self.groupAnimations forKey:@"wwwewq"];

    }
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8/*延迟执行时间*/ * NSEC_PER_SEC));
    WeakSelf
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        if (weakSelf.page == 1) {
            [weakSelf.datasouce removeAllObjects];
        }
        [weakSelf.datasouce addObjectsFromArray:@[@"玉岳鹏是个小狗狗",@"潘监藏是个小狗狗",@"于金宏是个小狗狗",@"李少朋是个小狗狗",@"小英英是个小狗狗",@"喻争志是个小狗狗"]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];

    });
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentInset"] && [object isEqual:self.tableView]) {
        NSLog(@"change == %@",change);
    }
}
#pragma mark tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
        NSLog(@"第%ld个 cell",indexPath.row);

    }
    NSLog(@"外部第%ld个 cell",indexPath.row);

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.datasouce[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

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
