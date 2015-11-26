//
//  LNBTableViewRefreshDefine.h
//  LNBTableViewRefresh
//
//  Created by Naibin on 15/11/25.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#ifndef LNBTableViewRefreshDefine_h
#define LNBTableViewRefreshDefine_h

//屏幕大小
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

//个性化设置
//加载过程中头、脚视图显示高度
#define PULLED_HEIGHT 64
//其中包括一个图片动画，动画图片命名规则为xxx0.png ... xxxN.png，N+1表示图片总数，即IMAGES_COUNT
#define LOAD_IMAGE_NAME @"pig0"
#define IMAGES_COUNT 5
//动画时间
#define ANIMATION_TIMEINTERVAL 0.5

//背景色
#define BACKGROUND_COLOR [UIColor whiteColor]
#define TITLE_COLOR [UIColor grayColor]

#define K_PULL_TO_REFRESH @"下拉刷新"
#define K_RELEASE_TO_REFRESH @"松开刷新"
#define K_IT_IS_REFRESHING @"正在刷新..."
#define K_REFRESH_FINISHED @"刷新结束"

#define K_PULL_TO_LOAD @"上拉加载更多"
#define K_RELEASE_TO_LOAD @"松开加载更多"
#define K_IT_IS_LOADING @"正在加载..."
#define K_LOAD_FINISHED @"加载结束"

#endif /* LNBTableViewRefreshDefine_h */







