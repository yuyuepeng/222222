//
//  lightedController.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/18.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "lightedController.h"
@interface lightedController ()

@end

@implementation lightedController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (NSInteger i = 0; i < 10; i ++) {
        UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(10 + ((mainWidth - 110)/10 +10) * i , 100, (mainWidth - 110)/10, (mainWidth - 110)/10)];
        lightView.backgroundColor = [UIColor orangeColor];
        lightView.tag = 11 + i;
        [self.view addSubview:lightView];
    }
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self lightViewWithTouches:touches];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self lightViewWithTouches:touches];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self lightViewWithTouches:touches];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
}
- (void)lightViewWithTouches:(NSSet<UITouch *> *)touches {
    CGPoint piont = [[touches anyObject] locationInView:self.view];
    for (NSInteger i = 0; i < 10; i ++) {
        UIView *view = [self.view viewWithTag:11 +i];
        if (CGRectContainsPoint(view.frame, piont)) {
            view.backgroundColor = [UIColor blackColor];
        }
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
