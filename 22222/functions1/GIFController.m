//
//  GIFController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/1/14.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "GIFController.h"
#import "GifLoadCell.h"
#import <WebKit/WebKit.h>
@interface GIFController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation GIFController {
    NSArray *arr;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"downLoadHtml" ofType:@"html"];
    NSURL *url;// = [NSURL fileURLWithPath:path/*[[NSBundle mainBundle] pathForResource:@"BX_合成_1" ofType:@"html"]*/];
    url = [NSURL URLWithString:@"http://download.ad6755.com/extend?type=landing_page&channel=hexin"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
    
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:request];
//    [self.view addSubview:self.tableView];
//    arr = @[@"我的发财树",@"泰信空间站",@"AR找不同"];

    // Do any additional setup after loading the view.
}
//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return mainHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GifLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell ==  nil) {
        cell = [[GifLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.gifPath = @"/Users/yuyuepeng/222222/22222/source/321/BX_合成_1.html";//arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
