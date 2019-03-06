
//
//  AllFontsController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/3/6.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "AllFontsController.h"

@interface AllFontsController ()

@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation AllFontsController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    NSArray *arr = [UIFont familyNames];
    _scrollView.contentSize = CGSizeMake(mainWidth, 44 * arr.count);
    for (NSInteger i = 0; i < arr.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * 44, mainWidth, 44)];
        label.text = [NSString stringWithFormat:@"郁孤台下清江水123456789%@",arr[i]];
        if ([arr[i] hasPrefix:@"MH"]) {
            NSLog(@"小袁袁----123-- %@",arr[i]);
            label.backgroundColor = [UIColor redColor];
        }
        label.font = [UIFont fontWithName:arr[i] size:15];
        label.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:label];
    }
    [self.view addSubview:self.scrollView];
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
