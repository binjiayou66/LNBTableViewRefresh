//
//  LNBTableViewRefreshView.m
//  Day2-EGODemo
//
//  Created by Naibin on 15/11/25.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "LNBTableViewRefreshView.h"

@implementation LNBTableViewRefreshView {
    UIImageView * _refreshImageView;
    UILabel * _titleLabel;
    
    BOOL _isRefreshing;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //背景颜色
        self.backgroundColor = BACKGROUND_COLOR;
        //定制加载图片
        [self formulateLoadImageView];
        //定制加载提示语
        [self formulateTitleLabel];
    }
    return self;
}

- (void)formulateLoadImageView {
    _refreshImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - PULLED_HEIGHT, self.frame.size.width, PULLED_HEIGHT - 20)];
    _refreshImageView.image = [UIImage imageNamed:LOAD_IMAGE_NAME];
    _refreshImageView.contentMode = UIViewContentModeScaleAspectFit;
    //添加动画
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < IMAGES_COUNT; i++) {
        NSString * imageName = [NSString stringWithFormat:@"pig%d", i];
        [arr addObject:[UIImage imageNamed:imageName]];
    }
    _refreshImageView.animationImages = arr;
    _refreshImageView.animationRepeatCount = 0;
    _refreshImageView.animationDuration = ANIMATION_TIMEINTERVAL;
    
    [self addSubview:_refreshImageView];
}

- (void)formulateTitleLabel {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 19, self.frame.size.width, 14)];
    _titleLabel.text = K_PULL_TO_REFRESH;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = TITLE_COLOR;
    
    [self addSubview:_titleLabel];
}

//用户操作
- (void)aceRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -(PULLED_HEIGHT + 5) && _isRefreshing == NO) {
        _titleLabel.text = K_RELEASE_TO_REFRESH;
    }

    if (scrollView.isDragging) {
        if (scrollView.contentInset.top != 0) {
            _isRefreshing = NO;
            [UIView animateWithDuration:0.11 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }];
        }
    }
}

- (void)aceRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    NSLog(@"%f ... %d", scrollView.contentOffset.y, _isRefreshing);
    if (scrollView.contentOffset.y < -(PULLED_HEIGHT + 5) && _isRefreshing == NO) {
        _isRefreshing = YES;
        _titleLabel.text = K_IT_IS_REFRESHING;
        [_refreshImageView startAnimating];
        NSTimeInterval time = scrollView.contentOffset.y / 80;
        [UIView animateWithDuration:time animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(PULLED_HEIGHT, 0, 0, 0);
            [scrollView setContentOffset:CGPointZero animated:YES];
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(aceRefreshDidBeginRefresh:)]) {
            [self.delegate aceRefreshDidBeginRefresh:self];
        }
    }
}

//数据加载
- (void)aceRefreshScrollViewFinishRefreshData:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.33 animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _titleLabel.text = K_REFRESH_FINISHED;
    } completion:^(BOOL finished) {
        _titleLabel.text = K_PULL_TO_REFRESH;
    }];
    [_refreshImageView stopAnimating];
    _isRefreshing = NO;
}

@end
