//
//  AddressViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "AddressViewController.h"
#import "MJRefresh.h"
#import "AreaViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController
{
    NSInteger page;
    NSMutableArray *datas;//discountPrice
    NSString *sortName;
    NSString *sortorder;
}
@synthesize tableViewList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"收货地址管理";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page=1;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonItemAction:)];
    [backItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = backItem;
    // Do any additional setup after loading the view from its nib.
    
    
    if (self.rdv_tabBarController.tabBar.translucent) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0,
                                               0,
                                               CGRectGetHeight(self.rdv_tabBarController.tabBar.frame),
                                               0);
        
        self.tableViewList.contentInset = insets;
        self.tableViewList.scrollIndicatorInsets = insets;
    }

}

-(IBAction)rightBarButtonItemAction:(id)sender{
    AddressEditViewController *editController=[[AddressEditViewController alloc]initWithNibName:@"AddressEditViewController" bundle:nil];
    
    [self.navigationController pushViewController:editController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self GetHttpData];
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
    
    NSString *url =[NSString stringWithFormat:@"%@/client/act/comsumer/queryAddress",LocalHostm];
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
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"remove"]){
        if([[dict allKeys]containsObject:@"status"]&&[[dict objectForKey:@"status"] boolValue]){
            [SVProgressHUD showSuccessWithStatus:[dict objectForKey:@"message"]];
            [self GetHttpData];
        }else{
            [SVProgressHUD showErrorWithStatus:[dict objectForKey:@"message"]];
        }
        return;
    }
}


//--------------------------------------上拉下拉刷新------------------------------------------------

- (void)viewWillAppear:(BOOL)animated {
    
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [datas count];
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

#define TAG_BUTTON20                  20
#define TAG_BUTTON21                  21

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        
        UIImageView *imageBack=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 100)];
        [imageBack setImage:[UIImage imageNamed:@"5个人中心-1全部订单-1详情_03"]];
        [cell.contentView addSubview:imageBack];
        
        //商品名
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 280, 65)];
        titleLabel.textColor = COLOR_MAIN_TEXT;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.numberOfLines=3;
        titleLabel.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:titleLabel];
        titleLabel.tag = TAG_TITLE;
        
        //原价
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,15,100,40)];
        descLabel.textColor = COLOR_MAIN_TEXT;
        descLabel.font = [UIFont systemFontOfSize:12];;
        descLabel.numberOfLines = 2;
        descLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel];
        descLabel.tag = TAG_DESC;
        
        
        
        UILabel *descLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(20,25,100,20)];
        descLabel3.textColor = [UIColor blackColor];
        descLabel3.font = [UIFont systemFontOfSize:12];;
        descLabel3.numberOfLines = 1;
        descLabel3.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel3];
        descLabel3.tag = TAG_DESC3;
        
        UIButton *buuton1=[[UIButton alloc]initWithFrame:CGRectMake(10, 120, 145, 30)];
        [buuton1 setTitle:@"删   除" forState:UIControlStateNormal];
        [buuton1 setBackgroundImage:[UIImage imageNamed:@"用户_01"] forState:UIControlStateNormal];
        [buuton1 addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];
        buuton1.tag = TAG_BUTTON20;
        
        UIButton *buuton2=[[UIButton alloc]initWithFrame:CGRectMake(165, 120, 145, 30)];
        [buuton2 setTitle:@"编   辑" forState:UIControlStateNormal];
        [buuton2 setBackgroundImage:[UIImage imageNamed:@"用户_01"] forState:UIControlStateNormal];
        [buuton2 addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
         buuton2.tag = TAG_BUTTON21;

        
        [cell.contentView addSubview:buuton1];
        [cell.contentView addSubview:buuton2];
        
    }
    /*
     for(UIView *view in cell.contentView.subviews){
     [view removeFromSuperview];
     }*/
    
    id obj =[datas objectAtIndex:indexPath.row];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE];
    [titleLabel setText:[obj objectForKey:@"receiveraddress"]];
    
    
    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:TAG_DESC];
    [descLabel setText:[obj objectForKey:@"receiverphone"]];
    
    
    UILabel *descLabel3 = (UILabel *)[cell.contentView viewWithTag:TAG_DESC3];
    [descLabel3 setText:[obj objectForKey:@"receivername"]];
    
    
    UIButton *buuton1= (UIButton *)[cell.contentView viewWithTag:TAG_BUTTON20];
    [buuton1 setTitle:[NSString stringWithFormat:@"%d",indexPath.row] forState:UIControlStateDisabled];
    
    UIButton *buuton2= (UIButton *)[cell.contentView viewWithTag:TAG_BUTTON21];
    [buuton2 setTitle:[NSString stringWithFormat:@"%d",indexPath.row] forState:UIControlStateDisabled];
    
    
    
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    
}
/*
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
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // BookViewController *deatilView=[[BookViewController alloc]initWithNibName:@"BookViewController" bundle:nil];
    
    // [self.navigationController pushViewController:deatilView animated:YES];
}

-(void)removeAction:(id)sender{
    UIButton *but=(UIButton *)sender;
    NSString *indexString=[but titleForState:UIControlStateDisabled];
    int index=[indexString intValue];
    
    id obj=[datas objectAtIndex:index];
    
     NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setObject:[obj objectForKey:@"receiverid"] forKey:@"receiverid"];
    
    NSString *url=[NSString stringWithFormat:@"%@/client/act/comsumer/deleteAddress",LocalHostm];
    
    [self httpRequest:url pm:md data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"remove",@"tag", nil]];
    

}
-(void)editAction:(id)sender{
    UIButton *but=(UIButton *)sender;
    NSString *indexString=[but titleForState:UIControlStateDisabled];
    int index=[indexString intValue];
    
    id obj=[datas objectAtIndex:index];
    
    AddressEditViewController *editController=[[AddressEditViewController alloc]initWithNibName:@"AddressEditViewController" bundle:nil];
    
    editController.infoDictionary=obj;
    
    [self.navigationController pushViewController:editController animated:YES];
}


@end
