//
//  LNBViewController.m
//  LNBTableViewRefresh
//
//  Created by Naibin on 15/11/25.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "LNBViewController.h"

@interface LNBViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView * tableView;

@end

@implementation LNBViewController {
    NSMutableArray * _dataSource;
    
    LNBTableViewRefreshView * _refreshHeaderView;
    LNBTableViewLoadMoreView * _refreshFooterView;
    BOOL _isLoading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createDataSource];
    [self createTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    
    //添加刷新头脚视图
    [self refreshAbout];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)createDataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i < 3; i++) {
        NSMutableArray * temp = [[NSMutableArray alloc] init];
        for (int j = 0; j < 10; j++) {
            NSString * str = [NSString stringWithFormat:@"我是第%d组，%d行", i, j];
            [temp addObject:str];
        }
        [_dataSource addObject:temp];
    }
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)];
    view.backgroundColor= [UIColor redColor];
    self.tableView.tableHeaderView = view;
    
    [self.view addSubview:self.tableView];
}

- (void)refreshAbout {
    
    _refreshHeaderView = [[LNBTableViewRefreshView alloc] initWithFrame:CGRectMake(0, - self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    [self.tableView addSubview:_refreshHeaderView];
    
    _refreshFooterView = [[LNBTableViewLoadMoreView alloc] initWithFrame:CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    _refreshFooterView.delegate = self;
    [self.tableView addSubview:_refreshFooterView];
}

- (void)beginRefreshTableViewData {
    _isLoading = YES;
    NSArray * arr = @[@"我是新加的1", @"我是新加的2", @"我是新加的3"];
    [_dataSource addObject:arr];
}

- (void)finishedRefreshTableViewData {
    _isLoading = NO;
    [self.tableView reloadData];
    [_refreshHeaderView aceRefreshScrollViewFinishRefreshData:self.tableView];
    [_refreshFooterView aceLoadMoreScrollViewFinishLoadData:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LNBTableViewRefreshViewDelegate
- (void)aceRefreshDidBeginRefresh:(LNBTableViewRefreshView *)refreshView {
    [self beginRefreshTableViewData];
    [self performSelector:@selector(finishedRefreshTableViewData) withObject:nil afterDelay:2.0];
}

- (void)aceLoadMoreDidBeginLoadMore:(LNBTableViewLoadMoreView *)loadMoreView {
    [self beginRefreshTableViewData];
    [self performSelector:@selector(finishedRefreshTableViewData) withObject:nil afterDelay:2.0];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refreshHeaderView aceRefreshScrollViewDidScroll:scrollView];
    [_refreshFooterView aceLoadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView aceRefreshScrollViewDidEndDragging:scrollView];
    [_refreshFooterView aceLoadMoreScrollViewDidEndDragging:scrollView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %li begins here!", (long)section];
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %li ends here!", (long)section];
    
}

@end
