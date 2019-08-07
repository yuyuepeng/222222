//
//  GCDHighLevelVC.m
//  22222
//
//  Created by 玉岳鹏 on 2019/7/30.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "GCDHighLevelVC.h"

@interface GCDHighLevelVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray <NSString *>*dataSource;

@end

@implementation GCDHighLevelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GCD的高级用法";
    _dataSource = @[@"延时执行",@"串行，异步顺序下载",@"并行同步顺序下载",@"任务1、2在子线程上先顺序执行后，任务3、4在主线程上执行，最后任务5、6、7在子线程上并发无序执行",@"队列组1",@"队列组2",@"两个网络请求同步问题"];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, mainWidth, mainHeight - Height_NavBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getHeightWithWidth:mainWidth - 100 andfont:[UIFont systemFontOfSize:17] andText:self.dataSource[indexPath.row]] + 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)getHeightWithWidth:(CGFloat)contentWidth andfont:(UIFont *)contentFont andText:(NSString *)contentString {
    float contentLabelHEIGHT = 0;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(contentWidth, 10000) options: NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    contentLabelHEIGHT = size.height;
    return contentLabelHEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"test%ld",indexPath.row])];
}
- (void)test0 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"3秒以后");
    });
    NSLog(@"三秒前");
}
- (void)test1 {
    dispatch_queue_t serialQueue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        dispatch_async(serialQueue, ^{
            NSLog(@"执行任务1");
        });
//        [NSThread sleepForTimeInterval:arc4random_uniform(5)];//5秒内的随机时间

        dispatch_async(serialQueue, ^{
            NSLog(@"执行任务2");
        });
//        [NSThread sleepForTimeInterval:arc4random_uniform(5)];//5秒内的随机时间
        dispatch_async(serialQueue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"执行完成");
            });
        });
    });
}
- (void)test2 {
    dispatch_queue_t currentQueue = dispatch_queue_create("currentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(currentQueue, ^{
        dispatch_sync(currentQueue, ^{
            NSLog(@"执行任务1");
        });
        dispatch_sync(currentQueue, ^{
            NSLog(@"执行任务2");
        });
        dispatch_async(currentQueue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"执行完成");
            });
        });
    });
    
}
- (void)test3 {
    
}
- (void)test4 {
    
}
- (void)test5 {
    
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
