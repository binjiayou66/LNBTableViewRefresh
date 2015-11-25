//
//  LNBViewController.h
//  LNBTableViewRefresh
//
//  Created by Naibin on 15/11/25.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNBTableViewRefreshView.h"
#import "LNBTableViewLoadMoreView.h"

@interface LNBViewController : UIViewController <UIScrollViewDelegate, LNBTableViewRefreshViewDelegate, LNBTableViewLoadMoreViewDelegate>

@end
