//
//  SortViewController.m
//  YunMei
//
//  Created by  macbook on 15-1-13.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "SortFSViewController.h"


@interface SortFSViewController ()
{
    NSInteger page;
}

@end

@implementation SortFSViewController
{
    NSMutableArray *datas;
}
@synthesize tableViewList,condition,url,flag,viewType;

- (void)viewDidLoad {
    [super viewDidLoad];
    page=1;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SetData:(NSArray *)data
{
    if(page==1){
        datas=[[NSMutableArray alloc]initWithArray:data];
    }else if(page>1){
        for(id obj in data){
            [datas addObject:obj];
        }
    }
    [tableViewList reloadData];
}

-(void)GetHttpData
{
    NSMutableDictionary *pm=[[NSMutableDictionary alloc]init];
    [pm setValue:condition forKey:@"condition"];
    [pm setValue:[NSString stringWithFormat:@"%d",flag] forKey:@"flag"];
    [pm setValue:[NSString stringWithFormat:@"%d",page]  forKey:@"page"];
    [pm setValue:[NSString stringWithFormat:@"%d",PageSize] forKey:@"pagesize"];

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
    
    if ([self.tableViewList respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableViewList setSeparatorInset:UIEdgeInsetsZero];
        
    }
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
    page=1;
    [self GetHttpData];
    //2解析数据
//    [listeDate removeAllObjects];
//    [listeDate addObject:@"1"];
//    //3刷新tablvew
//    [self.tableViewList reloadData];
    //4(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态（网络结束）
    [self didRereshing];
}
//加载更多(下拉)
- (void)footerRereshing
{
    page ++;
    [self GetHttpData];
    //1,访问网络数据
     //do
    
    //2解析数据
//    [listeDate addObject:@"2"];
//    //3刷新tablvew
//    [self.tableViewList reloadData];
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
    
    return [datas count];
}

#define TAG_IMAGE  1
#define TAG_TITLE  2

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        //设置选中效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,50,50)];
        [cell.contentView addSubview:imgView];
        imgView.backgroundColor = COLOR_SEP;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = TAG_IMAGE;
    
         [cell.contentView addSubview:imgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.size.width+10, imgView.frame.origin.y, cell.frame.size.width-imgView.frame.size.width+5, cell.frame.size.height)];
        titleLabel.textColor = COLOR_MAIN_TEXT;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setNumberOfLines:2];
        titleLabel.tag = TAG_TITLE;
        [cell.contentView addSubview:titleLabel];
        
    }
    
    id obj=[datas objectAtIndex:indexPath.row];
    
    
    if(viewType==0){
        NSURL  *imageurl=[NSURL URLWithString:[ NSString stringWithFormat: @"%@/client/act/comsumer/getImg?url=%@",LocalHostm,[obj objectForKey:@"peoplelogurl"]]];
        
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:TAG_IMAGE];
        [imgView setImageWithURL:imageurl placeholderImage:nil options:SDWebImageRetryFailed];
        
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE];
        [titleLabel setText:[obj objectForKey:@"peoplename"]];

    }else if(viewType==1){
        NSURL  *imageurl=[NSURL URLWithString:[ NSString stringWithFormat: @"%@/client/act/comsumer/getImg?url=%@",LocalHostm,[obj objectForKey:@"shoplogurl"]]];
        
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:TAG_IMAGE];
        [imgView setImageWithURL:imageurl placeholderImage:nil options:SDWebImageRetryFailed];
        
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE];
        [titleLabel setText:[obj objectForKey:@"shopname"]];
    
    
    }
    
    return cell;
    
}

@end
