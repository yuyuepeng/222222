//
//  suanfaController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/6/19.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "suanfaController.h"

@interface suanfaController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation suanfaController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, mainWidth, mainHeight - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = @[@"判断数组中随机三个数之和等于一个已知数",@"数组奇偶数排列"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
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
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [self seekRandomThreeElementSum1:5 Arr1:@[@(1),@(2),@(4),@(5),@(6),@(7),@(3)]];//没有
            [self seekRandomThreeElementSum1:6 Arr1:@[@(1),@(2),@(3),@(4),@(5),@(6),@(7)]];//有
            [self seekRandomThreeElementSum1:7 Arr1:@[@(1),@(4),@(3),@(5),@(6),@(7)]];//没有
            [self seekRandomThreeElementSum1:8 Arr1:@[@(1),@(4),@(3),@(5),@(6),@(7)]];//有
            [self seekRandomThreeElementSum1:3 Arr1:@[@(1),@(4),@(3),@(5),@(6),@(7)]];//没有
        }
            break;
        case 1:{
            NSLog(@"arr1 = %@",[self jiOushuRankWithArr:@[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),@(14),@(15),@(16),@(17),@(18),@(19),@(20)]]);
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
            
        default:
            break;
    }
}
#pragma --mark 判断数组中随机三个数之和等于一个已知数
- (BOOL)seekRandomThreeElementSum:(NSInteger)sum Arr:(NSArray *)array {
    NSInteger b,c,d,i,j,k;
    //    for (i = 0; i < array.count - 2; i ++) {
    //        b = [array[i] integerValue];
    //        for (j = i + 1 ; j < array.count - 1; j ++) {
    //            c = [array[j] integerValue];
    //            for (k = j + 1; k < array.count; k ++) {
    //                d = [array[k] integerValue];
    //                if (b + c + d == sum) {
    //                    NSLog(@"have the sum");
    //                    return YES;
    //                }
    //            }
    //        }
    //    }
    for (i = 0; i < array.count; i ++) {
        b = [array[i] integerValue];
        for (j = 0 ; j < array.count; j ++) {
            if (j != i) {
                c = [array[j] integerValue];
                for (k = 0; k < array.count; k ++) {
                    if (k != i && k != j) {
                        d = [array[k] integerValue];
                        if (b + c + d == sum) {
                            NSLog(@"have the sum");
                            return YES;
                        }
                    }
                }
            }
        }
    }
    
    NSLog(@"have not the sum");
    return NO;
}
- (BOOL)seekRandomThreeElementSum1:(NSInteger)sum Arr1:(NSArray *)array {
    NSArray *arr1 = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];//将数组排序
    NSLog(@"arr == %@",arr1);
    NSInteger length = arr1.count;
    // 三个数 只需循环length - 2次；
    for (NSInteger i = 0; i < length - 2; i ++) {
        NSInteger left = i + 1;
        NSInteger right = length - 1;
        NSInteger m, n, l, all;
        while (left < right) {
            m = [arr1[i] integerValue];
            n = [arr1[left] integerValue];
            l = [arr1[right] integerValue];
            all = m + n + l;
            if (all == sum) {
                NSLog(@"have the sum");
                return YES;
            }
            if (all < sum) {
                left ++;
            }
            if (all > sum) {
                right --;
            }
        }
    }
    NSLog(@"have not the sum");
    return NO;
}
#pragma --mark 数组奇偶数排列两个奇数两个偶数
- (NSArray *)jiOushuRankWithArr:(NSArray *)arr {
    //两个基数两个偶数
    NSMutableArray *arr2 = [NSMutableArray array];
    NSMutableArray *arr3 = [NSMutableArray array];
    for (NSInteger i = 0; i < arr.count; i ++) {
        if ([arr[i] integerValue]%2) {
            [arr2 addObject:arr[i]];//奇数
        }else {
            [arr3 addObject:arr[i]];//偶数
        }
    }
    NSMutableArray *arr1 = [NSMutableArray array];
    if (arr2.count > arr3.count) {
        for (NSInteger i = 0; i < arr3.count; i ++) {
            if (i%2 == 0) {
                if (i < arr3.count - 1) {
                    [arr1 addObject:arr2[i]];
                    [arr1 addObject:arr2[i + 1]];
                    [arr1 addObject:arr3[i]];
                    [arr1 addObject:arr3[i + 1]];
                }else {
                    [arr1 addObject:arr2[i]];
                    [arr1 addObject:arr2[i + 1]];//记得减去arr2[arr2.count]
                    [arr1 addObject:arr3[i]];
                    if (i < arr3.count - 1) {
                        [arr1 addObject:arr3[i + 1]];
                    }
                }
            }
        }
        //因为在else里多加了一个
         [arr1 addObjectsFromArray:[arr2 subarrayWithRange:NSMakeRange(arr3.count + 1, arr2.count - arr3.count - 1)]];
    }else {
        for (NSInteger i = 0; i < arr2.count; i ++) {
            if (i%2 == 0) {
                if (i < arr2.count - 1) {
                    [arr1 addObject:arr2[i]];
                    [arr1 addObject:arr2[i + 1]];
                    [arr1 addObject:arr3[i]];
                    [arr1 addObject:arr3[i + 1]];
                }else {
                    [arr1 addObject:arr2[i]];
                    [arr1 addObject:arr3[i]];
                    if (i < arr3.count - 1) {
                        [arr1 addObject:arr3[i + 1]];
                    }
                }
            }

        }
        [arr1 addObjectsFromArray:[arr3 subarrayWithRange:NSMakeRange(arr2.count, arr3.count - arr2.count)]];
    }
    return arr1;
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
