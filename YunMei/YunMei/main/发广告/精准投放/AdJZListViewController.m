//
//  SortViewController.m
//  YunMei
//
//  Created by  macbook on 15-1-13.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "AdJZListViewController.h"


@interface AdJZListViewController ()

@end

@implementation AdJZListViewController
@synthesize tableViewList,state;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page=1;
    listeDate=[[NSMutableArray alloc]initWithCapacity:0];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SetData:(NSArray *)data
{
    if(page==1){
        listeDate=[[NSMutableArray alloc]initWithArray:data];
    }else if(page>1){
        for(id obj in data){
            [listeDate addObject:obj];
        }
    }
    [tableViewList reloadData];
}
-(void)GetHttpData
{
    NSMutableDictionary *pm=[[NSMutableDictionary alloc]init];
    [pm setValue:[NSString stringWithFormat:@"%d",page]  forKey:@"page"];
    [pm setValue:[NSString stringWithFormat:@"%d",PageSize] forKey:@"pagesize"];
    [pm setValue:[NSString stringWithFormat:@"%d",state]  forKey:@"state"];
    [pm setValue:@"0"  forKey:@"type"];
    
    NSString *url =[NSString stringWithFormat:@"%@/client/act/advert/shop/query",LocalHostm];
    [self httpRequest:url pm:pm data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"tag", nil]];
    
}
-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    if(userInfo==nil){
        return;
    }
    
    //处理列表
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"list"]){
        [self SetData:[dict objectForKey:@"Rows"]];
        return;
    }
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
    page=1;
    [self GetHttpData];
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
    page++;
    [self GetHttpData];
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
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    id obj=[listeDate objectAtIndex:indexPath.row];
    
    
    //[cell.imageView setImage:[UIImage imageNamed:image]];
    [cell.textLabel setText:[obj objectForKey:@"name"]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.detailTextLabel setText:[obj objectForKey:@"description"]];
    [cell.detailTextLabel setNumberOfLines:2];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id obj=[listeDate objectAtIndex:indexPath.row];
    
    AdGGAddViewController *viewController=viewController=[[AdGGAddViewController alloc]initWithNibName:@"AdGGAddViewController" bundle:nil];
    viewController.adNSDictionary=obj;
    
    [viewController setTitle:@"广告修改"];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
