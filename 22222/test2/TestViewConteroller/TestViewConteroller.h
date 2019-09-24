//
//  TestViewConteroller.h
//  HeXinFound
//
//  Created by lishaopeng on 2018/7/5.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import "HXFBaseViewController.h"


typedef void(^block)(void);

@interface TestViewConteroller : HXFBaseViewController

@property(nonatomic, copy) block block1;

@end
