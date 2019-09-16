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
    _dataSource = @[@"延时执行",@"串行，异步顺序下载",@"并行同步顺序下载",@"任务1、2在子线程上先顺序执行后，任务3、4在主线程上执行，最后任务5、6、7在子线程上并发无序执行",@"队列组1",@"队列组2",@"两个网络请求同步问题",@"dispatch_barrier_sync栅栏函数"];
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
    NSLog(@"外部主线程");
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
- (void)test3 {//"任务1、2在子线程上先顺序执行后，任务3、4在主线程上执行，最后任务5、6、7在子线程上并发无序执行
    
    //同步串行队列是一个个执行  异步并发队列是无序执行
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t currentQueue = dispatch_queue_create("currentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(currentQueue, ^{
        dispatch_sync(serialQueue, ^{
            NSLog(@"任务1");
        });
        dispatch_sync(serialQueue, ^{
            NSLog(@"任务2");
        });
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"任务3");
        });
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"任务4");
        });
        
        dispatch_async(currentQueue, ^{//异步获取子队列， 又在子队列里  异步添加任务
            dispatch_async(currentQueue, ^{
                NSLog(@"任务5");
            });
            dispatch_async(currentQueue, ^{
                NSLog(@"任务6");
            });
            dispatch_async(currentQueue, ^{
                NSLog(@"任务7");
            });
        });
        
    });
}
- (void)test4 {
    //异步并发
    NSLog(@"begin");
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:arc4random_uniform(5)];
        NSLog(@"下载任务1");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:arc4random_uniform(5)];
        NSLog(@"下载任务2");
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"下载完成");
    });
   
}
- (void)test5 {
     //一个一个来
    NSLog(@"begin");
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:arc4random_uniform(5)];
        NSLog(@"下载任务1");
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:arc4random_uniform(5)];
        NSLog(@"下载任务2");
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"下载完成");
    });
    //
}
- (void)test6 {
//    NSString *appIdKey = @"8781e4ef1c73ff20a180d3d7a42a8c04";
//    NSString* urlString_1 = @"http://api.openweathermap.org/data/2.5/weather";
//    NSString* urlString_2 = @"http://api.openweathermap.org/data/2.5/forecast/daily";
//    NSDictionary* dictionary =@{@"lat":@"40.04991291",
//                                @"lon":@"116.25626162",
//                                @"APPID" : appIdKey};
//    // 创建组
//    dispatch_group_t group = dispatch_group_create();
//    // 将第一个网络请求任务添加组中
//    dispatch_group_async(group,  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 创建信号量
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//        // 开始网络请求任务
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager GET:urlString_1 parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"成功请求数据1:%@",[responseObject class]);
//            // 如果请求成功，发送信号量
//            dispatch_semaphore_signal(semaphore);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"失败请求数据");
//            // 如果请求失败，也发送信号量
//            dispatch_semaphore_signal(semaphore);
//        }];
//        // 在网络请求任务成功之前，信号量等待中
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    });
//    
//    // 将第二个网络请求任务添加到组中
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 创建信号量
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//        // 开始网络请求任务
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager GET:urlString_2
//          parameters:dictionary
//            progress:nil
//             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                 NSLog(@"成功请求数据2:%@",[responseObject class]);
//                 // 如果请求成功，发送信号量
//                 dispatch_semaphore_signal(semaphore);
//             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                 NSLog(@"失败请求数据");
//                 // 如果请求失败，也发送信号量
//                 dispatch_semaphore_signal(semaphore);
//             }];
//        // 在网络请求任务成功之前，信号量等待中
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    });
//    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"完成了网络请求，不管网络请求失败了还是成功了。");
//    });
}
- (void)test7 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    for (NSInteger i = 0; i < 10; i++) {
        
        dispatch_sync(concurrentQueue, ^{
            
            NSLog(@"%zd",i);
        });
    }
    
    dispatch_barrier_sync(concurrentQueue, ^{
        
        NSLog(@"barrier");
    });
    
    for (NSInteger i = 10; i < 20; i++) {
        
        dispatch_sync(concurrentQueue, ^{
            
            NSLog(@"%zd",i);
        });
    }
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
