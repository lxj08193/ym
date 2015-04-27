//
//  CollectionSpController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-22.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "CollectionSpController.h"

@interface CollectionSpController ()

@end

@implementation CollectionSpController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我收藏的商品";
    }
    return self;
}
@synthesize tableViewList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------上拉下拉刷新------------------------------------------------

- (void)viewWillAppear:(BOOL)animated {
    listeDate=[[NSMutableArray alloc]initWithCapacity:0];
    
    [super viewWillAppear:animated];
    // 集成刷新控件
    [self setupRefresh];
    //集成完成第一次开始刷新
    [self.tableViewList headerBeginRefreshing];
    
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    //分割线离边框总是短了一截
    /*
     if ([self.tableViewList respondsToSelector:@selector(setSeparatorInset:)]) {
     
     [self.tableViewList setSeparatorInset:UIEdgeInsetsZero];
     
     }*/
    //-------隐藏UITableView多余的分割线(使用原因是没有数据时ios还会显示分割线)
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableViewList setTableFooterView:view];
    //--------隐藏UITableView多余的分割线
    
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableViewList addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[self.tableViewList headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableViewList addFooterWithTarget:self action:@selector(footerRereshing)];
}

//pragma mark 开始进入刷新状态（上拉）
- (void)headerRereshing
{
    //1,访问网络数据
    
    //2解析数据
    [listeDate removeAllObjects];
    [listeDate addObject:@"1"];
    //3刷新tablvew
    [self.tableViewList reloadData];
    //4(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态（网络结束）
    [self didRereshing];
}
//加载更多(下拉)
- (void)footerRereshing
{
    //1,访问网络数据
    //do
    
    //2解析数据
    [listeDate addObject:@"2"];
    //3刷新tablvew
    [self.tableViewList reloadData];
    //4(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态（网络结束）
    [self didRereshing];
    
}
-(void)didRereshing{
    [self.tableViewList headerEndRefreshing];
    [self.tableViewList footerEndRefreshing];
}
//--------------------------------------上拉下拉刷新-end-----------------------------------------------



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [listeDate count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    /*
     [cell.imageView setImage:[UIImage imageNamed:image]];
     [cell.textLabel setText:title];
     [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
     */
    
    return cell;
    
}

@end
