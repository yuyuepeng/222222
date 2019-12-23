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
    _dataSource = @[@"判断数组中随机三个数之和等于一个已知数",@"数组奇偶数排列",@"斐波那契数",@"冒泡排序",@"递归计算1-n的和",@"选择排序",@"快速排序",@"插入升序排列",@"NSComparator排序"];
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
            NSInteger m = [self fib:10];
            NSLog(@"%ld",m);
        }
            break;
        case 3:{
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(4),@(9),@(3),@(11),@(5),@(8),@(10),@(1), nil];
            NSLog(@"%@",arr);
            [self maopaoSortWithArr:arr];
        }
            break;
        case 4:{
            NSLog(@"%ld",[self diguiSum:10]);
            NSLog(@"%ld",[self diguiSum:9]);
            NSLog(@"%ld",[self diguiSum:8]);
            NSLog(@"%ld",[self diguiSum:7]);
            NSLog(@"%ld",[self diguiSum:6]);
            NSLog(@"%ld",[self diguiSum:5]);
        }
            break;
            case 5:{
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(4),@(9),@(3),@(11),@(5),@(8),@(10),@(1), nil];
            NSLog(@"%@",arr);
            [self selectedSort:arr];
            }
                break;
            case 6:{
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(4),@(9),@(3),@(11),@(5),@(8),@(10),@(1), nil];
            NSLog(@"%@",arr);
            [self quickSort:arr];
            }
                break;
            case 7:{
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(4),@(9),@(3),@(11),@(5),@(8),@(10),@(1), nil];
            NSLog(@"%@",arr);
            [self insertionAscendingOrderSort:arr];
            }
                break;
            case 8:{
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(4),@(9),@(3),@(11),@(5),@(8),@(10),@(1), nil];
            NSLog(@"%@",arr);
            [self sortWithComparator:arr];
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
#pragma mark -- 斐波那契数列 求第n个斐波那契数
- (NSInteger)fib:(NSInteger)n {
    if (n <= 1) {
        return n;
    }
    NSInteger first = 0;
    NSInteger second = 1;
    NSLog(@"0 \n1");
    while (n -- > 1) {
        second += first;//fib(2) = fib(1) + fib(0);
        first = second - first;//first = 原来的second = 现在的second - 原来的first
        NSLog(@"%ld",second);
    }
    return second;
}
//冒泡排序算法
- (void)maopaoSortWithArr:(NSMutableArray *)arr {
    for (NSInteger i = 0; i < arr.count - 1; i ++) {
        for (NSInteger j = i + 1; j < arr.count; j ++) {
            if ([arr[i] integerValue] > [arr[j] integerValue]) {
                NSNumber *temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }
    NSLog(@"%@",arr);
}

- (NSInteger)diguiSum:(NSInteger)n {
    if (n == 1) {
        return 1;
    }
    return [self diguiSum:n - 1] + n;
}
- (void)selectedSort:(NSMutableArray *)array {
    
    NSInteger min;
      for (int i = 0; i < array.count; i ++) {
          min = i;
          for (int j = i + 1; j < array.count; j ++) {//查找最小值
              if ([array[min] integerValue]> [array[j] integerValue]) {
                  min = j;
              }
          }
          if (min != i) {//将最小值赋给i位置上的数字对象
              [array exchangeObjectAtIndex:i withObjectAtIndex:min];
          }
      }

    NSLog(@"%@",array);
}
- (void)quickSort:(NSMutableArray *)array {
    NSInteger i = 0, j = array.count - 1;
//    [self quickAscendingOrderSort:array leftIndex:i rightIndex:j];
    [self quickSortArray:array withLeftIndex:i andRightIndex:j];

    NSLog(@"%@",array);
}
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex {
    
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }

    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];

    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];

        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];

    }

    //将基准数放到正确位置
    array[i] = @(key);

    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}
- (void)quickAscendingOrderSort:(NSMutableArray *)arr leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    if (left < right) {
        NSInteger temp = [self getMiddleIndex:arr leftIndex:left rightIndex:right];//取一次较小值下标
        [self quickAscendingOrderSort:arr leftIndex:left rightIndex:temp - 1];//第一次可能会有temp大于left
        [self quickAscendingOrderSort:arr leftIndex:temp + 1 rightIndex:right];
    }
}

- (NSInteger)getMiddleIndex:(NSMutableArray *)arr leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    NSInteger tempValue = [arr[left] integerValue];
    while (left < right) {
        while (left < right && tempValue <= [arr[right] integerValue]) {
            right --;
        }
        if (left < right) {
            arr[left] = arr[right];
        }
        while (left < right && [arr[left] integerValue] <= tempValue) {
            left ++;
        }
        if (left < right) {
            arr[right] = arr[left];
        }
    }
    arr[left] = [NSNumber numberWithInteger:tempValue];
    return left;
}
- (void)insertionAscendingOrderSort:(NSMutableArray *)ascendingArr {
    for (NSInteger i = 1; i < ascendingArr.count; i ++) {
        NSInteger temp = [ascendingArr[i] integerValue];
        for (NSInteger j = i - 1; j >=0 && temp < [ascendingArr[j] integerValue]; j --) {
            ascendingArr[j + 1] = ascendingArr[j];
            ascendingArr[j] = [NSNumber numberWithInteger:temp];//不能直接用数组下标  深拷贝
        }
    }
    NSLog(@"%@",ascendingArr);
}
- (void)sortWithComparator:(NSMutableArray *)array {
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSInteger value1 = [obj1 integerValue];
        NSInteger value2 = [obj2 integerValue];
        if (value1 < value2) {
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
    NSLog(@"%@",array);
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
