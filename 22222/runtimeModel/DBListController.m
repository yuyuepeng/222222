//
//  DBListController.m
//  22222
//
//  Created by 王国良 on 2020/1/8.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "DBListController.h"
#import "RMYVideoModel.h"
@interface DBListController ()

@property(nonatomic, strong) NSMutableArray <RMYVideoModel *>*dataSource;

@end

@implementation DBListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray arrayWithArray:[RMYVideoModel findAll]];
    for (RMYVideoModel *model in _dataSource) {
        NSLog(@"%@ --- ",model.sandBoxPath);
    }
    // Do any additional setup after loading the view.
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
