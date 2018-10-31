//
//  TestViewConteroller.m
//  HeXinFound
//
//  Created by lishaopeng on 2018/7/5.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import "TestViewConteroller.h"
#import "HXFTransverseTableView.h"
#import "ViewController2.h"
@interface TestViewConteroller ()<HXFTransverseTableViewDelegate>

@property (nonatomic, copy) NSArray *imageArray;

@property (nonatomic, weak) UIImageView *otherImageV;

@end

@implementation TestViewConteroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createInterface];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated {

    NSLog(@"我的class = %@, nav = %@",NSStringFromClass(self.class),self.navigationController.viewControllers);
    
}
- (void)createInterface
{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    
    button.backgroundColor = [UIColor blueColor];
    
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
    
    button1.backgroundColor = [UIColor greenColor];
    [button1 addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
//    self.view.backgroundColor = [UIColor lightGrayColor];
//
//    UIView *colorView = [[UIView alloc]init];
//    [colorView setBackgroundColor:[UIColor greenColor]];
//    [colorView setFrame:CGRectMake(0, 200, self.view.frame.size.width, 150)];
//    [self.view addSubview:colorView];
//
//    NSArray *imageArray = [NSArray arrayWithObjects:@"img1.jpg",@"img2.jpg",@"img3.jpg",@"img4.jpg",@"img5.jpg",@"img6.jpg",@"img7.jpg",@"img8.jpg",@"img9.jpg",@"img10.jpg", nil];
//    self.imageArray = [NSArray arrayWithArray:imageArray];
//
//    HXFTransverseTableView *testView = [[HXFTransverseTableView alloc]initWithFrame:CGRectMake(0, 0, colorView.frame.size.width, colorView.frame.size.height) imageArray:imageArray];
//    testView.delegate = self;
//    [colorView addSubview:testView];
//
//    //
//    UIImageView *otherImageV = [[UIImageView alloc]init];
//    [otherImageV setFrame:CGRectMake(200, 400, 100, 150)];
//    self.otherImageV = otherImageV;
//    [self.view addSubview:otherImageV];
}
- (void)click2:(UIButton *)btn {
    ViewController2 *vc = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)click:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:false];
    if (self.block1) {
        self.block1();
    }
   

}
- (void)transverseTableView:(HXFTransverseTableView *)transverseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect row = %ld",indexPath.row);
}

- (void)showOtherImageIndex:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row -1;
    NSString *imageName = self.imageArray[index];
    self.otherImageV.image = [UIImage imageNamed:imageName];
}
@end
