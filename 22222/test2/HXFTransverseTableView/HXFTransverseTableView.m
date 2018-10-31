//
//  HXFTransverseTableView.m
//  HeXinFound
//
//  Created by lishaopeng on 2018/7/5.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import "HXFTransverseTableView.h"
#import "HXFTransverseTableViewCell.h"

@interface HXFTransverseTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableV;

@property (nonatomic, copy) NSArray *imageArray;

@end

@implementation HXFTransverseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    self = [super init];
    if(self)
    {
        [self setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageArray = [NSArray arrayWithArray:imageArray];
        [self createTableView];
    }
    return self;
}

- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"HXFTransverseTableViewCell";
    HXFTransverseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[HXFTransverseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell clearCell];
    NSString *imageName = self.imageArray[indexPath.row];
    [cell fillCellImage:[UIImage imageNamed:imageName]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(transverseTableView:didSelectRowAtIndexPath:)])
    {
        [self.delegate transverseTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSIndexPath *showIndex = tableView.indexPathsForVisibleRows.lastObject;
    NSLog(@"visible = %ld",(long)showIndex.row);
//    NSLog(@"currentDidendDisplay = %ld",(long)indexPath.row);
    if(self.delegate && [self.delegate respondsToSelector:@selector(showOtherImageIndex:)])
    {
        [self.delegate showOtherImageIndex:showIndex];
    }
}

@end
