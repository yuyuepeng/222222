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

@implementation GCDHighLevelVC {
    dispatch_semaphore_t _semaphore;
    int count;
}
+ (NSThread *)shareThread {
    
    static NSThread *shareThread = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        
        shareThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
        
        [shareThread setName:@"threadTest"];
        
        [shareThread start];
    });
    
    return shareThread;
}
+ (void)threadTest {
    @autoreleasepool {
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];

        [runLoop run];
        NSLog(@"test:%@", [NSThread currentThread]);

    }
//    NSLog(@"test:%@", [NSThread currentThread]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _semaphore = dispatch_semaphore_create(1);
    self.title = @"GCD的高级用法";
    count = 0;
    _dataSource = @[@"延时执行",@"串行，异步顺序下载",@"并行同步顺序下载",@"任务1、2在子线程上先顺序执行后，任务3、4在主线程上执行，最后任务5、6、7在子线程上并发无序执行",@"队列组1",@"队列组2",@"两个网络请求同步问题",@"dispatch_barrier_sync栅栏函数",@"dispatch_group_async",@"Dispatch Semaphore信号量",@"Dispatch Semaphore为线程加锁",@"NSOperation和NSOperationQueue",@"NSThread+runloop实现常驻线程"];
    
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
//    而dispatch_barrier_sync和dispatch_barrier_async的区别也就在于会不会阻塞当前线程

    dispatch_barrier_sync(concurrentQueue, ^{//阻碍当前线程
        
        NSLog(@"barrier");
    });
    
    for (NSInteger i = 10; i < 20; i++) {
        
        dispatch_sync(concurrentQueue, ^{
            
            NSLog(@"%zd",i);
        });
    }
}
- (void)test8 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("test1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, concurrentQueue, ^{
               
               sleep(1.0f);
               NSLog(@"网络请求");
        
    });
    dispatch_group_async(group, concurrentQueue, ^{
               
               sleep(1.0f);
               NSLog(@"网络请求0");
        
    });
    dispatch_group_async(group, concurrentQueue, ^{
               
               sleep(1.0f);
               NSLog(@"网络请求1");
        
    });
    dispatch_group_async(group, concurrentQueue, ^{
               
               sleep(1.0f);
               NSLog(@"网络请求2");
        
    });
    dispatch_group_async(group, concurrentQueue, ^{
               
               sleep(1.0f);
               NSLog(@"网络请求3");
        
    });
//    for (NSInteger i = 0; i < 10; i++) {
//
//        dispatch_group_async(group, concurrentQueue, ^{
//
//            sleep(1);
//
//            NSLog(@"%zd:网络请求 %@",i);
//        });
//    }
//    NSLog(@"刷新页面1");如果不加dispatch_group_notify  会在一开始的时候就会走到这儿，group_async 不会阻碍当前线程
    

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{//会在当前线程里的任务都完成后执行
        NSLog(@"刷新页面");
    });
    
   
}
- (void)test9 {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block NSInteger number = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        异步解锁
        number = 100;
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//加锁
    
    NSLog(@"semaphore---end,number = %zd",number);
    
//    1.dispatch_semaphore_create：创建一个Semaphore并初始化信号的总量
//    2.dispatch_semaphore_signal：发送一个信号，让信号总量加1
//    3.dispatch_semaphore_wait：可以使总信号量减1，当信号总量（在该函数执行前）为0时就会一直等待（阻塞所在线程），>=0时就可以正常执行。
//    Dispatch Semaphore 在实际开发中主要用于：
//
//    保持线程同步，将异步执行任务转换为同步执行任务
//    保证线程安全，为线程加锁
}
- (void)test10 {
    for (NSInteger i = 0; i < 100; i++) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self asyncTask];
//            然后发现打印是从任务1顺序执行到100，没有发生两个任务同时执行的情况。
//            原因如下:
//            在子线程中并发执行asyncTask，那么第一个添加到并发队列里的，会将信号量减1，此时信号量等于0，可以执行接下来的任务。而并发队列中其他任务，由于此时信号量不等于0，必须等当前正在执行的任务执行完毕后调用dispatch_semaphore_signal将信号量加1，才可以继续执行接下来的任务，以此类推，从而达到线程加锁的目的。
            
            
        });
    }
}
- (void)test11 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperation:op];
}
- (void)test12 {
    [self performSelector:@selector(test) onThread:[GCDHighLevelVC shareThread] withObject:nil waitUntilDone:NO];

}
- (void)test {
    NSLog(@"test:%@", [NSThread currentThread]);
}
- (void)asyncTask
{
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    count++;
    
    sleep(1);
    
    NSLog(@"执行任务:%zd",count);
//    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);

    dispatch_semaphore_signal(_semaphore);
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
