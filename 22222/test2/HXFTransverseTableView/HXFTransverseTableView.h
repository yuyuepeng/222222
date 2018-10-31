//
//  HXFTransverseTableView.h
//  HeXinFound
//
//  Created by lishaopeng on 2018/7/5.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXFTransverseTableView;

@protocol HXFTransverseTableViewDelegate <NSObject>

@required
- (void)transverseTableView:(HXFTransverseTableView *)transverseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)showOtherImageIndex:(NSIndexPath *)indexPath;

@end

@interface HXFTransverseTableView : UIView

@property (nonatomic, weak) id<HXFTransverseTableViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

@end
