//
//  SearchController.m
//  22222
//
//  Created by 扶摇先生 on 2020/1/2.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "SearchController.h"
#import "searchView.h"

@interface SearchController ()<searchViewDelegate>

@property(nonatomic, strong) searchView *sv;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sv = [[searchView alloc] initWithFrame:CGRectMake(44, 0, mainWidth - 88, 44)];
    _sv.backgroundColor = [UIColor yellowColor];
    _sv.delegate = self;
    [self.navigationController.navigationBar addSubview:_sv];
    
    // Do any additional setup after loading the view.
}
- (void)clickEnter:(NSDictionary *)dict {
    [[dict objectForKey:@"textField"] resignFirstResponder];
    NSLog(@"%@",dict);
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
