//
//  LNBTableViewRefreshView.h
//  LNBTableViewRefresh
//
//  Created by Naibin on 15/11/25.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNBTableViewRefreshDefine.h"
@class LNBTableViewRefreshView;

@protocol LNBTableViewRefreshViewDelegate <NSObject>

- (void)aceRefreshDidBeginRefresh:(LNBTableViewRefreshView *)refreshView;

@end

@interface LNBTableViewRefreshView : UIView

@property (weak, nonatomic) id<LNBTableViewRefreshViewDelegate> delegate;

//用户操作
- (void)aceRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)aceRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
//数据加载
- (void)aceRefreshScrollViewFinishRefreshData:(UIScrollView *)scrollView;


@end









