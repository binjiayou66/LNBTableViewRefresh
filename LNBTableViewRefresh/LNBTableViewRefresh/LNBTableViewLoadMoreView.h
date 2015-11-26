//
//  LNBTableViewLoadMoreView.h
//  LNBTableViewRefresh
//
//  Created by Naibin on 15/11/25.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNBTableViewRefreshDefine.h"
@class LNBTableViewLoadMoreView;

@protocol LNBTableViewLoadMoreViewDelegate <NSObject>

- (void)aceLoadMoreDidBeginLoadMore:(LNBTableViewLoadMoreView *)loadMoreView;

@end

@interface LNBTableViewLoadMoreView : UIView

@property (weak, nonatomic) id<LNBTableViewLoadMoreViewDelegate> delegate;

//用户操作
- (void)aceLoadMoreScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)aceLoadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView;
//数据加载
- (void)aceLoadMoreScrollViewFinishLoadData:(UIScrollView *)scrollView;

@end
