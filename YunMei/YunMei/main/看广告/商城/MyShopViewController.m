//
//  AdSPAddViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "MyShopViewController.h"

@interface MyShopViewController ()

@end

@implementation MyShopViewController
{
    NSInteger page;
    NSMutableArray *datas;//discountPrice
    NSString *sortName;
    NSString *sortorder;
}
@synthesize tableViewList,btnSortByPrice,btnSortByDiscountPrice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商城";
    }
    return self;
}
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
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setValue:[NSString stringWithFormat:@"%d",page]  forKey:@"page"];
    [md setValue:@"10" forKey:@"pagesize"];
    if(sortName!=nil)
    {
        [md setValue:sortName forKey:sortName];
        [md setValue:sortorder forKey:@"sortName"];
    }
    
    NSString *url =[NSString stringWithFormat:@"%@/client/act/product/query",LocalHostm];
    
    [self httpRequest:url pm:md data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"tag", nil]];
    /*
    [YunMeiHttpUtils httpRequest:url pm:md withBlock:^(NSDictionary *dict) {
        [self SetData:[dict objectForKey:@"Rows"]];
    }];
     */
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
    //4(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态（网络结束）
    [self didRereshing];
    
}
-(void)didRereshing{
    [self.tableViewList headerEndRefreshing];
    [self.tableViewList footerEndRefreshing];
}
//--------------------------------------上拉下拉刷新-end-----------------------------------------------

-(IBAction)SortByPrice:(id)sender
{
    
}

-(IBAction)SortByDisountPrice:(id)sender
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [datas count];
}

#define TAG_IMAGE     1
#define TAG_TITLE     2
#define TAG_PRICE     3
#define TAG_ADDBUTTON 4
#define TAG_BUY       5

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    id obj=[datas objectAtIndex:indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,300,200)];
        [cell.contentView addSubview:imgView];
        imgView.backgroundColor = COLOR_SEP;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = TAG_IMAGE;
        
        [cell.contentView addSubview:imgView];
        
        UILabel *lblPrice=[[UILabel alloc]initWithFrame:CGRectMake(10, 205, 200, 30)];
        [lblPrice setTag:TAG_PRICE];
        [cell.contentView addSubview:lblPrice];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 240, cell.frame.size.width - 10, 50)];
        titleLabel.textColor = COLOR_MAIN_TEXT;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setNumberOfLines:2];
        titleLabel.tag = TAG_TITLE;
        [cell.contentView addSubview:titleLabel];
        
        
        UIButton *btnAdd=[[UIButton alloc]initWithFrame:CGRectMake(5, 300, 140, 35)];
        [btnAdd setBackgroundImage:[UIImage imageNamed:@"用户_01.png"] forState:UIControlStateNormal];
        [btnAdd setTitle:@"加入购物车" forState:UIControlStateNormal];
        [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnAdd addTarget:self action:@selector(AddCart:) forControlEvents:UIControlEventTouchUpInside];
        [btnAdd setTag:indexPath.row];
        [cell.contentView addSubview:btnAdd];
        
        UIButton *btnBuy=[[UIButton alloc]initWithFrame:CGRectMake(160, 300, 140, 35)];
        [btnBuy setBackgroundImage:[UIImage imageNamed:@"用户_01.png"] forState:UIControlStateNormal];
        [btnBuy setTitle:@"购买" forState:UIControlStateNormal];
        [btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnBuy setTag:indexPath.row];
        [btnBuy addTarget:self action:@selector(Buy:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnBuy];

    }
    
    NSURL  *imageurl=[NSURL URLWithString:[ NSString stringWithFormat: @"%@/client/act/product/img/get?imgUrl=%@",LocalHostm,[obj objectForKey:@"imgMaxUrl"]]];
    
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:TAG_IMAGE];
    [imgView setImageWithURL:imageurl placeholderImage:nil options:SDWebImageRetryFailed];
    
    UILabel *lblPrice=(UILabel *)[cell.contentView viewWithTag:TAG_PRICE];
    [lblPrice setText:[NSString stringWithFormat:@"￥%.2f",[obj objectForKey:@"productPrice"]]];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE];
    [titleLabel setText:[obj objectForKey:@"productName"]];
    return cell;
}

-(IBAction)AddCart:(id)sender
{
    UIButton *btn=sender;
    id obj = [datas objectAtIndex:btn.tag];
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setValue:[obj objectForKey:@"shopId"]  forKey:@"shopId"];
    [md setValue:[obj objectForKey:@"id"]  forKey:@"productId "];
    [md setValue:@"1"  forKey:@"productNum"];
    [md setValue:[obj objectForKey:@"productPrice"]  forKey:@"productPrice"];
    
    NSString *url =[NSString stringWithFormat:@"%@/client/act/sale/trolley/create",JMY];
    [YunMeiHttpUtils httpRequest:url pm:md withBlock:^(NSDictionary *dict) {
        [self showtips:[dict objectForKey:@"message"]];
    }];

}

-(IBAction)Buy:(id)sender
{
    
}


@end
