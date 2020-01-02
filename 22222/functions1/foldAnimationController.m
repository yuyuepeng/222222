//
//  foldAnimationController.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/18.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "foldAnimationController.h"

#import "JCFlipPageView.h"
#import "NewsPage.h"

@interface foldAnimationController ()<JCFlipPageViewDataSource>

@property (nonatomic, strong) JCFlipPageView *flipPage;

@end

@implementation foldAnimationController



- (void)viewDidLoad {
    [super viewDidLoad];

    _flipPage = [[JCFlipPageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_flipPage];
    
    _flipPage.dataSource = self;
    [_flipPage reloadData];
}
#pragma mar - JCFlipPageViewDataSource
- (NSUInteger)numberOfPagesInFlipPageView:(JCFlipPageView *)flipPageView
{
    return 5;
}
- (JCFlipPage *)flipPageView:(JCFlipPageView *)flipPageView pageAtIndex:(NSUInteger)index
{
    static NSString *kPageID = @"numberPageID";
    NewsPage *page = [flipPageView dequeueReusablePageWithReuseIdentifier:kPageID];
    if (!page)
    {
        page = [[NewsPage alloc] initWithFrame:flipPageView.bounds reuseIdentifier:kPageID];
    }else{}

//    if (index%3 == 0)
//    {
//        page.backgroundColor = [UIColor blueColor];
//    }
//    else if (index%3 == 1)
//    {
//        page.backgroundColor = [UIColor greenColor];
//    }
//    else if (index%3 == 2)
//    {
//        page.backgroundColor = [UIColor redColor];
//    }else{}
    page.index = index;
    
    return page;
}

#pragma mark -

- (void)showPage:(NSNumber *)pageNum
{
    [_flipPage flipToPageAtIndex:pageNum.integerValue animation:YES];
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
