//
//  BookListViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BookListViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface BookListViewController ()
{
    NSMutableArray *datas;
    int page;
}

@end

@implementation BookListViewController
@synthesize tableViewList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"订单管理";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    listeDate=[[NSMutableArray alloc]initWithCapacity:0];
    [listeDate addObject:@"1"];
    [listeDate addObject:@"2"];
    [listeDate addObject:@"3"];
    
    page=1;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [datas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[[datas objectAtIndex:section] objectForKey:@"children"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableViewList.frame.size.width, 30)];
    
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 100, 30)];
    titleLable.text=@"待收货";
    [titleLable setTextColor:[UIColor redColor]];
    titleLable.font=[UIFont boldSystemFontOfSize:14];
    [titleLable setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:titleLable];
    
    UILabel *lineLable=[[UILabel alloc]initWithFrame:CGRectMake(4, 29, self.tableViewList.frame.size.width-8, 1)];
    [lineLable setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [view addSubview:lineLable];
    
    UILabel *titleLable2=[[UILabel alloc]initWithFrame:CGRectMake(120, 0, 200, 30)];
    titleLable2.text=@"订单号:1234556566565";
    [titleLable2 setTextColor:[UIColor blackColor]];
    titleLable2.font=[UIFont boldSystemFontOfSize:14];
    [titleLable2 setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:titleLable2];

    
    return view;
    
}

#define TAG_BUTTON                  1
#define TAG_UNDERLINE               2
#define TAG_IMAGE                   3
#define TAG_IMAGE1                   7
#define TAG_IMAGE2                   8
#define TAG_IMAGE3                   9
#define TAG_IMAGE4                   10
#define TAG_TITLE                   4

#define TAG_DESC  11
#define TAG_DESC2  12
#define TAG_DESC3  13
#define TAG_DESC4  14
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,30,80,70)];
        [cell.contentView addSubview:imgView];
        imgView.backgroundColor = COLOR_SEP;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = TAG_IMAGE;
        //商品名
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 180, 55)];
        titleLabel.textColor = COLOR_MAIN_TEXT;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.numberOfLines=3;
        titleLabel.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:titleLabel];
        titleLabel.tag = TAG_TITLE;
        
        //原价
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,75,150,40)];
        descLabel.textColor = COLOR_SUB_TEXT;
        descLabel.font = [UIFont systemFontOfSize:12];;
        descLabel.numberOfLines = 2;
        descLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel];
        descLabel.tag = TAG_DESC;
        
        //现价
        UILabel *descLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(190,75,50,40)];
        descLabel2.textColor = COLOR_RED_DOWN;
        descLabel2.font = [UIFont systemFontOfSize:12];;
        descLabel2.numberOfLines = 2;
        descLabel2.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel2];
        descLabel2.tag = TAG_DESC2;
        
       
        UILabel *descLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10,5,200,20)];
        descLabel3.textColor = [UIColor blackColor];
        descLabel3.font = [UIFont systemFontOfSize:12];;
        descLabel3.numberOfLines = 2;
        descLabel3.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel3];
        descLabel3.tag = TAG_DESC3;
        
        
        UILabel *lineLable=[[UILabel alloc]initWithFrame:CGRectMake(4, 110, self.tableViewList.frame.size.width-8, 1)];
        [lineLable setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [cell.contentView addSubview:lineLable];
    }
    /*
     for(UIView *view in cell.contentView.subviews){
     [view removeFromSuperview];
     }*/
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:TAG_IMAGE];
    [imgView setImageWithURL:[NSURL URLWithString:@"http://imgnew.jiatx.com/news/2011_08/03/home/1312360607458_000.jpg"] placeholderImage:nil options:SDWebImageRetryFailed];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE];
    [titleLabel setText:@"居民基础养老金最低标准首上调 增至70元居民基础养老金最低标准首上调 增至70元居民基础养老金最低标准首上调 增至70元"];
    
    
    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:TAG_DESC];
    [descLabel setText:@"实付款:555"];
    
    UILabel *descLabel2 = (UILabel *)[cell.contentView viewWithTag:TAG_DESC2];
    [descLabel2 setText:@"$40"];
    
    UILabel *descLabel3 = (UILabel *)[cell.contentView viewWithTag:TAG_DESC3];
    [descLabel3 setText:@"佰草集（商家名称）"];
    
    
    UIButton *buuton1=[[UIButton alloc]initWithFrame:CGRectMake(10, 120, 145, 30)];
    [buuton1 setTitle:@"评  价" forState:UIControlStateNormal];
    [buuton1 setBackgroundImage:[UIImage imageNamed:@"用户_01"] forState:UIControlStateNormal];
    
    UIButton *buuton2=[[UIButton alloc]initWithFrame:CGRectMake(165, 120, 145, 30)];
    [buuton2 setTitle:@"再次购买" forState:UIControlStateNormal];
    [buuton2 setBackgroundImage:[UIImage imageNamed:@"用户_01"] forState:UIControlStateNormal];

    UIButton *buuton3=[[UIButton alloc]initWithFrame:CGRectMake(290, 50, 25, 25)];
    [buuton3 setImage:[UIImage imageNamed:@"5个人中心_03"] forState:UIControlStateNormal];
    //[buuton3 setBackgroundImage:[UIImage imageNamed:@"5个人中心_03"] forState:UIControlStateNormal];
    
    [cell.contentView addSubview:buuton3];
    [cell.contentView addSubview:buuton1];
    [cell.contentView addSubview:buuton2];
    
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    
}
//UITableView section随着cell滚动
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 40;
    //固定section 随着cell滚动而滚动
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookViewController *deatilView=[[BookViewController alloc]initWithNibName:@"BookViewController" bundle:nil];

    [self.navigationController pushViewController:deatilView animated:YES];
}

-(void)loadHttpData{
    NSString *url=[NSString stringWithFormat:@"%@/client/act/sale/bill/getByPeople",LocalHost];
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setObject:@"1" forKey:@"page"];
    [md setObject:@"10" forKey:@"pagesize"];
    [md setObject:@"1" forKey:@"billState"];
    [YunMeiHttpUtils httpRequest:url pm:md withBlock:^(NSDictionary *dict) {
        
        NSInteger type=[[dict objectForKey:@"type"]integerValue];
        if (type==1)
        {
            //[self.navigationController.navigationBar setHidden:TRUE];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [self showtips:[dict objectForKey:@"message" ]];
        }
        
        
        
    }];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"全选";
    [backItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = backItem;
    [self GetHttpData];
    
    // 集成刷新控件
    [self setupRefresh];
    //集成完成第一次开始刷新
    [self.tableViewList headerBeginRefreshing];
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
    [pm setValue:[NSString stringWithFormat:@"%d",page]  forKey:@"page"];
    [pm setValue:[NSString stringWithFormat:@"%d",PageSize] forKey:@"pagesize"];
    
    //url=[NSString stringWithFormat:@"%@?%@=%@&%@=%d&%@=%d&%@=%d",url,@"condition",condition,@"flag",flag,@"page",page,@"pagesize",PageSize];
    NSString *url =[NSString stringWithFormat:@"%@/client/act/sale/bill/getByPeople",LocalHostm];
    [YunMeiHttpUtils httpRequest:url pm:pm withBlock:^(NSDictionary *dict) {
        [self SetData:[dict objectForKey:@"Rows"]];
    }];
}

//--------------------------------------上拉下拉刷新------------------------------------------------
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


@end
