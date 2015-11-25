//
//  LNBTableViewLoadMoreView.m
//  Day2-EGODemo
//
//  Created by Naibin on 15/11/25.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "LNBTableViewLoadMoreView.h"

@implementation LNBTableViewLoadMoreView {
    UIImageView * _loadImageView;
    UILabel * _titleLabel;
    
    BOOL _isLoading;
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
    _loadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, PULLED_HEIGHT - 20)];
    _loadImageView.image = [UIImage imageNamed:LOAD_IMAGE_NAME];
    _loadImageView.contentMode = UIViewContentModeScaleAspectFit;
    //添加动画
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < IMAGES_COUNT; i++) {
        NSString * imageName = [NSString stringWithFormat:@"pig%d", i];
        [arr addObject:[UIImage imageNamed:imageName]];
    }
    _loadImageView.animationImages = arr;
    _loadImageView.animationRepeatCount = 0;
    _loadImageView.animationDuration = 1;
    
    [self addSubview:_loadImageView];
}

- (void)formulateTitleLabel {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, PULLED_HEIGHT - 16, self.frame.size.width, 14)];
    _titleLabel.text = K_PULL_TO_LOAD;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = TITLE_COLOR;
    
    [self addSubview:_titleLabel];
}

//用户操作
- (void)aceLoadMoreScrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y + SCREEN_SIZE.height - PULLED_HEIGHT > scrollView.contentSize.height + PULLED_HEIGHT + 10 && _isLoading == NO) {
        _titleLabel.text = K_RELEASE_TO_LOAD;
    }else if (scrollView.isDragging) {
        if (scrollView.contentInset.bottom != 0) {
            _isLoading = NO;
            [UIView animateWithDuration:0.11 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }];
        }
    }
}

- (void)aceLoadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y + SCREEN_SIZE.height - PULLED_HEIGHT > scrollView.contentSize.height + PULLED_HEIGHT + 10 && _isLoading == NO) {
        _isLoading = YES;
        _titleLabel.text = K_IT_IS_LOADING;
        [_loadImageView startAnimating];
        NSTimeInterval time = (scrollView.contentOffset.y - SCREEN_SIZE.height - scrollView.contentSize.height) / 80;
        [UIView animateWithDuration:time animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, PULLED_HEIGHT, 0);
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(aceLoadMoreDidBeginLoadMore:)]) {
            [self.delegate aceLoadMoreDidBeginLoadMore:self];
        }
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + PULLED_HEIGHT) animated:YES];
    }
}

//数据加载
- (void)aceLoadMoreScrollViewFinishLoadData:(UIScrollView *)scrollView {
    self.frame = CGRectMake(self.frame.origin.x,MAX(scrollView.bounds.size.height, scrollView.contentSize.height), self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.33 animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _titleLabel.text = K_LOAD_FINISHED;
    } completion:^(BOOL finished) {
        _titleLabel.text = K_PULL_TO_LOAD;
    }];
    [_loadImageView stopAnimating];
    _isLoading = NO;
}

@end
