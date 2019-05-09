//
//  HanziController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/5/6.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "HanziController.h"
//master
@interface HanziController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation HanziController

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
        _textField.backgroundColor = [UIColor lightGrayColor];
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textField];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 200, 50)];
    button.backgroundColor = [UIColor brownColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:self.textField];
    // Do any additional setup after loading the view.
}
- (void)buttonClick {
    if ([self isChinese:self.textField.text]) {
        self.textField.text = @"纯汉字";
    }else {
        self.textField.text = @"含有非汉字字符";
    }
}

//根据正则，过滤特殊字符
- (BOOL)isChinese:(NSString *)str
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
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
