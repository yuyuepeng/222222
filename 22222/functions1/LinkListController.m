//
//  LinkListController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/5/30.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "LinkListController.h"
#import "SingleLinkList.h"

@interface LinkListController ()

@end

@implementation LinkListController

- (void)viewDidLoad {
    [super viewDidLoad];
    SingleLinkList *singleLinkList = [[SingleLinkList alloc] init];
    [singleLinkList addElement:@(2)];
    [singleLinkList addElement:@(3)];
    [singleLinkList addElement:@(4)];
    [singleLinkList addElement:@(5)];
    [singleLinkList addElement:@(6)];
    [singleLinkList addElement:@(7)];
    [singleLinkList addElement:@(8)];
    [singleLinkList addElement:@(9)];
    for (NSInteger i = 0; i < 9; i ++) {
        [singleLinkList removeWithIndex:0];
    }
    
    NSLog(@"wodeSingleLinkList = %@",[singleLinkList formatToString]);
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
