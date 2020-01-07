//
//  ViewController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/7/5.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "ViewController.h"
extern NSString *CTSettingCopyMyPhoneNumber(void);
#import "TestViewConteroller.h"
#import "YYPScrollViewController.h"
#import "YYPBezierViewController.h"
#import "MaksController.h"
#import "ChangeStrController.h"
#import "HealthStepController.h"
#import "NormalStepController.h"
#import "iFlyController.h"
#import "CalendarController.h"
#import "TableViewRefreshController.h"
#import "JianBianCirleController.h"
#import "SiriController.h"
#import "ARController.h"
#import "GifTwoController.h"
#import "_2222-Swift.h"
#import "HanziController.h"
#import <CoreMotion/CoreMotion.h>
#import "KVOVCController.h"
#import "LinkListController.h"
#import "InterViewController.h"
#import "Person.h"
#import "Person+cate.h"
//FOUNDATION_EXPORT NSArray *getArr(NSString *str);

NSArray *getArr(NSString *str) {
    return [str componentsSeparatedByString:@","];
}

@interface YYPCellHeightModel : NSObject

@property(nonatomic, assign) CGFloat cellHeight;

@end

@implementation YYPCellHeightModel



@end

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>


@property (nonatomic, copy) NSArray *arr5;//P

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSMutableArray <YYPCellHeightModel *>*dataModels;

@property (nonatomic, strong) InterViewController *intVC;

@end

@implementation ViewController

- (NSMutableArray<YYPCellHeightModel *> *)dataModels {
    if (_dataModels == nil) {
        _dataModels = [NSMutableArray array];
    }
    return _dataModels;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"我的class = %@, nav = %@",NSStringFromClass(self.class),self.navigationController.viewControllers);
//    [self initRecognizer];

}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, mainWidth, mainHeight - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = getArr(@"wqehqjweehqjehq,ejq,h,e,q");
    NSLog(@"naviHeight = %f",self.navigationController.navigationBar.height);
    NSLog(@"tabbar = %f",self.tabBarController.tabBar.height);
    NSLog(@"statusBarHeight = %f",[[UIApplication sharedApplication] statusBarFrame].size.height);
    NSLog(@"mainwidth %lf",mainWidth);
//    NSLog(@"",self.navigationController);
    _dataSource = @[@"YYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollViewYYPScrollView",@"YYPBezierView",@"maskVC",@"变换字符串",@"healthKit计步",@"正常计步",@"讯飞听写",@"日历",@"tableViewRefresh",@"渐变圆圈",@"SiriKit",@"ARKit",@"gif加载",@"所有字体",@"lottie",@"只输入中文",@"链表",@"runtime",@"算法",@"按钮根据状态变底色",@"菊花",@"gcd高级用法",@"修饰词",@"关于block",@"面试题",@"masonry",@"invocationController",@"播放器",@"对折View",@"点亮View",@"searchViewController",@"AliVideoController"];
    for (NSInteger i = 0; i < _dataSource.count; i ++) {
        [self.dataModels addObject:[[YYPCellHeightModel alloc] init]];
    }
    [self.view addSubview:self.tableView];
    Person *p = [[Person alloc] init];
    [[[Person alloc] init] sayhahahaToAmy];
    [[[Person alloc] init] sayIlikeYouAmy];

//    [Person sayHelloToAmy];
//    [Person ]
//    [p setValue:@"1213" forKey:@"numuber"];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    //高度缓存
    YYPCellHeightModel *model = self.dataModels[indexPath.row];
    CGFloat height = [cell systemLayoutSizeFittingSize:CGSizeMake(tableView.frame.size.width, 0) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel].height;
    
    model.cellHeight = height;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.dataModels[indexPath.row].cellHeight;
    return  height ? height : UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//#import "YYPScrollViewController.h"
//#import "YYPBezierViewController.h"
//#import "MaksController.h"
//#import "ChangeStrController.h"
//#import "HealthStepController.h"
//#import "NormalStepController.h"
//#import "iFlyController.h"
    switch (indexPath.row) {
        case 0:{
            YYPScrollViewController *vc = [[YYPScrollViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            YYPBezierViewController *vc = [[YYPBezierViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            MaksController *vc = [[MaksController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            ChangeStrController *vc = [[ChangeStrController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            HealthStepController *vc = [[HealthStepController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            NormalStepController *vc = [[NormalStepController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            iFlyController *vc = [[iFlyController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            CalendarController *vc = [[CalendarController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:
        {
            TableViewRefreshController *vc = [[TableViewRefreshController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 9:
        {
            JianBianCirleController *vc = [[JianBianCirleController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10:
        {
            SiriController *vc = [[SiriController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 11:
        {
            ARController *vc = [[ARController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        case 12:
        {
            GifTwoController *vc = [[GifTwoController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 13:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"AllFontsController") alloc] init] animated:YES];
            
        }
            break;
        case 14:
        {
            LottieController *lottie = [[LottieController alloc] init];
            
            [self.navigationController pushViewController:lottie animated:YES];
            
        }
            break;
        case 15:
        {
            HanziController *hanzi = [[HanziController alloc] init];
            
            [self.navigationController pushViewController:hanzi animated:YES];
            
        }
            break;
        case 16:
        {
            LinkListController *linkVC = [[LinkListController alloc] init];
            
            [self.navigationController pushViewController:linkVC animated:YES];
            
        }
            break;
        case 17:
        {
            //runtime
            KVOVCController *kvoVC = [[KVOVCController alloc] init];
            
            [self.navigationController pushViewController:kvoVC animated:YES];

        }
            break;
        case 18:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"suanfaController") alloc] init] animated:YES];
        }
            break;
        case 19:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"BtnCateTestController") alloc] init] animated:YES];
        }
            break;
        case 20:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"HudController") alloc] init] animated:YES];
        }
            break;
        case 21:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"GCDHighLevelVC") alloc] init] animated:YES];
        }
            break;
        case 22:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"XiushiciController") alloc] init] animated:YES];
        }
            break;
        case 23:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"aboutBlockVC") alloc] init] animated:YES];
        }
            break;
        case 24:
        {
            InterViewController *intVC = [[InterViewController alloc] init];
            NSLog(@"%zd", malloc_size((__bridge const void *)intVC));

            [self.navigationController pushViewController:intVC animated:YES];
        }
            break;
        case 25:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"RMYMasController") alloc] init] animated:YES];
        }
            break;
        case 26:
        {
            [self.navigationController pushViewController:[[NSClassFromString(@"invocationController") alloc] init] animated:YES];
        }
            break;
        case 27:
        {//foldAnimationController
            [self.navigationController pushViewController:[[NSClassFromString(@"PlayVideoController") alloc] init] animated:YES];
        }
            break;
        case 28:
        {//foldAnimationController
            [self.navigationController pushViewController:[[NSClassFromString(@"foldAnimationController") alloc] init] animated:YES];
        }
            break;
        case 29:
        {//foldAnimationController
            [self.navigationController pushViewController:[[NSClassFromString(@"lightedController") alloc] init] animated:YES];
        }
            break;
        case 30:
         {//foldAnimationController
             [self.navigationController pushViewController:[[NSClassFromString(@"SearchController") alloc] init] animated:YES];
             
         }
            break;
        case 31:
            {//foldAnimationController
                [self.navigationController pushViewController:[[NSClassFromString(@"AliVideoController") alloc] init] animated:YES];
            }
                break;
        default:
            break;
    }
}





+(NSString *)myNumber{
    return CTSettingCopyMyPhoneNumber();
}
- (void)dealloc {
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return  UIStatusBarStyleLightContent;

}
+ (BOOL)isNilOrEmpty:(id)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && ([string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])) {
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning {  
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
