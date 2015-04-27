//
//  CartViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "CartViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface CartViewController ()
{
    NSInteger page;
    NSMutableArray *datas;
   
    double totalPrice;
}

@end

@implementation CartViewController

@synthesize tableViewList;
@synthesize lblTotolPrice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"购物车";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    selectIds = [[NSMutableArray alloc]initWithCapacity:0];
    checkBoxs =[[NSMutableArray alloc]initWithCapacity:0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    for(id obj in datas){
        for (id item in [obj objectForKey:@"children"]) {
            [item setValue:@"0" forKey:@"check"];
        }
        [obj setValue:@"0" forKey:@"check"];
    }

    [tableViewList reloadData];
}

-(void)GetHttpData
{
    NSMutableDictionary *pm=[[NSMutableDictionary alloc]init];
    [pm setValue:[NSString stringWithFormat:@"%d",page]  forKey:@"page"];
    [pm setValue:[NSString stringWithFormat:@"%d",PageSize] forKey:@"pagesize"];
    
    //url=[NSString stringWithFormat:@"%@?%@=%@&%@=%d&%@=%d&%@=%d",url,@"condition",condition,@"flag",flag,@"page",page,@"pagesize",PageSize];
    NSString *url =[NSString stringWithFormat:@"%@/client/act/sale/trolley/getByPeople",LocalHostm];
    [self httpRequest:url pm:pm data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"tag", nil]];
    /*
    [YunMeiHttpUtils httpRequest:url pm:pm withBlock:^(NSDictionary *dict) {
        [self SetData:[dict objectForKey:@"Rows"]];
    }];
     */
}
////执行成功处理数据

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
        [self GetHttpData];
        return;
    }
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"add"]){
        [self GetHttpData];
        return;
    }
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"subtract"]){
        [self GetHttpData];
        return;
    }
    
    
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
    
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 200, 30)];
    titleLable.text=[[datas objectAtIndex:section] objectForKey:@"shopname"];;
    titleLable.font=[UIFont boldSystemFontOfSize:14];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:titleLable];
    
    UILabel *lineLable=[[UILabel alloc]initWithFrame:CGRectMake(4, 29, self.tableViewList.frame.size.width-8, 1)];
    [lineLable setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [view addSubview:lineLable];
    
    UIButton *buuton1=[[UIButton alloc]initWithFrame:CGRectMake(self.tableViewList.frame.size.width-80, 5, 80, 20)];
    //[buuton1 setBackgroundImage:[UIImage imageNamed:@"联系卖家"] forState:UIControlStateNormal];
    [buuton1 setImage:[UIImage imageNamed:@"联系卖家"] forState:UIControlStateNormal];
    [buuton1 setTitle:@"联系卖家" forState:UIControlStateNormal];
    [buuton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buuton1.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [view addSubview:buuton1];
    
    
    UIButton *buutonCheck=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    [buutonCheck setBackgroundImage:[UIImage imageNamed:@"icon_check_alt1.png"] forState:UIControlStateNormal];
    [buutonCheck setBackgroundImage:[UIImage imageNamed:@"icon_check_alt2"] forState:UIControlStateSelected];
    [buutonCheck setTag:section];
    [buutonCheck addTarget:self action:@selector(CheckBoxThuch:) forControlEvents:UIControlEventTouchUpInside];
    [checkBoxs addObject:buutonCheck];
    [view addSubview:buutonCheck];
    
    id obj=[datas objectAtIndex:section];
    
    if([[obj allKeys]containsObject:@"check"]){
        NSString *checktag=[obj objectForKey:@"check"];
        if([checktag isEqualToString:@"0"]){
            [buutonCheck setSelected:false];
        }else{
            [buutonCheck setSelected:true];
        }
    }
    
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
#define TAG_DESC5  15
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    id obj = [[[datas objectAtIndex:indexPath.section] objectForKey:@"children"] objectAtIndex:indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(40,10,80,70)];
        [cell.contentView addSubview:imgView];
        imgView.backgroundColor = COLOR_SEP;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = TAG_IMAGE;
        //商品名
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 180, 21)];
        titleLabel.textColor = COLOR_MAIN_TEXT;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:titleLabel];
        titleLabel.tag = TAG_TITLE;
        
        //原价
//        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(130,25,50,40)];
//        descLabel.textColor = COLOR_SUB_TEXT;
//        descLabel.font = [UIFont systemFontOfSize:12];;
//        descLabel.numberOfLines = 2;
//        descLabel.backgroundColor = [UIColor clearColor];
//        [cell.contentView addSubview:descLabel];
//        descLabel.tag = TAG_DESC;
        
        //现价
        UILabel *descLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(190,25,50,40)];
        descLabel2.textColor = COLOR_RED_DOWN;
        descLabel2.font = [UIFont systemFontOfSize:12];;
        descLabel2.numberOfLines = 2;
        descLabel2.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel2];
        descLabel2.tag = TAG_DESC2;
        
        
        //数量
        UILabel *descLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(130,50,50,40)];
        descLabel3.textColor = COLOR_MAIN_TEXT;
        descLabel3.font = [UIFont systemFontOfSize:12];
        descLabel3.numberOfLines = 2;
        descLabel3.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel3];
        descLabel3.tag = TAG_DESC3;
        
        UILabel *textCount=[[UILabel alloc]initWithFrame:CGRectMake(205,60,60,20)];
        [textCount setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:textCount];
        textCount.tag = TAG_DESC4;
        
        
        UIButton *buuton1=[[UIButton alloc]initWithFrame:CGRectMake(170, 60, 20, 20)];
        [buuton1 setBackgroundImage:[UIImage imageNamed:@"4购物车_03"] forState:UIControlStateNormal];
        [buuton1 setTag:indexPath.row];
        [buuton1 addTarget:self action:@selector(CountSubtract:) forControlEvents:UIControlEventTouchUpInside];
        [buuton1 setTitle:[NSString stringWithFormat:@"%d",indexPath.section] forState:UIControlStateDisabled];
        
        UIButton *buuton2=[[UIButton alloc]initWithFrame:CGRectMake(280, 60, 20, 20)];
        [buuton2 setBackgroundImage:[UIImage imageNamed:@"4购物车_05"] forState:UIControlStateNormal];
        [buuton2 setTag:indexPath.row];
        [buuton2 addTarget:self action:@selector(CountAdd:) forControlEvents:UIControlEventTouchUpInside];
        [buuton2 setTitle:[NSString stringWithFormat:@"%d",indexPath.section] forState:UIControlStateDisabled];
        
        [cell.contentView addSubview:buuton1];
        [cell.contentView addSubview:buuton2];
        
        
        UIButton *buutonCheck=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        [buutonCheck setBackgroundImage:[UIImage imageNamed:@"icon_check_alt1.png"] forState:UIControlStateNormal];
        [buutonCheck setBackgroundImage:[UIImage imageNamed:@"icon_check_alt2"] forState:UIControlStateSelected];
        [buutonCheck setTag:TAG_DESC5];
        
        [buutonCheck addTarget:self action:@selector(CheckBoxThuch:) forControlEvents:UIControlEventTouchUpInside];
        //[checkBoxs addObject:buutonCheck];
        [cell.contentView addSubview:buutonCheck];
    }
    /*
     for(UIView *view in cell.contentView.subviews){
     [view removeFromSuperview];
     }*/
     UIButton *buuton1=(UIButton *)[cell viewWithTag:TAG_IMAGE];
    
    NSURL  *imageurl=[NSURL URLWithString:[ NSString stringWithFormat: @"%@/client/act/product/img/get?url=%@",LocalHostm,[obj objectForKey:@"pictureminurl"]]];
    
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:TAG_IMAGE];
    [imgView setImageWithURL:imageurl placeholderImage:nil options:SDWebImageRetryFailed];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE];
    [titleLabel setText:[obj objectForKey:@"productname"]];
    
    
//    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:TAG_DESC];
//    [descLabel setText:@"$555"];
    
    UILabel *descLabel2 = (UILabel *)[cell.contentView viewWithTag:TAG_DESC2];
    [descLabel2 setText:[[obj objectForKey:@"productPrice"] stringValue]];
    
    UILabel *descLabel3 = (UILabel *)[cell.contentView viewWithTag:TAG_DESC3];
    [descLabel3 setText:@"数量:"];
    
    UILabel *textCount=[cell.contentView viewWithTag:TAG_DESC4];
    [textCount setText:[[obj objectForKey:@"productnum"]stringValue]];
    
    UIButton *buutonCheck=[cell.contentView viewWithTag:TAG_DESC5];
    [buutonCheck setTitle:[NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row] forState:UIControlStateDisabled];
    
    if([[obj allKeys]containsObject:@"check"]){
        NSString *checktag=[obj objectForKey:@"check"];
        if([checktag isEqualToString:@"0"]){
            [buutonCheck setSelected:false];
        }else{
            [buutonCheck setSelected:true];
        }
    }
    
    return cell;
}

-(IBAction)CheckBoxThuch:(id)sender
{
    UIButton *checkBox=sender;
    NSString *section=[checkBox titleForState:UIControlStateDisabled];
    id objsection;
    id pro;
    int val;
    int pid;
    
    if(section !=nil)
    {
        int section1;
        int row;
        
        NSArray *arra=[section componentsSeparatedByString:@","];
        section1=[[arra objectAtIndex:0] intValue];
        row=[[arra objectAtIndex:1] intValue];
        
       objsection = [datas objectAtIndex:section1];
    
       pro=[[objsection objectForKey:@"children"] objectAtIndex:row];
        val=[[pro objectForKey:@"trolleyid"] intValue];
        pid=[[objsection objectForKey:@"shopid"] intValue];
    }
    else
    {
        pro=[datas objectAtIndex:checkBox.tag];
        val=[[pro objectForKey:@"shopid"] intValue];
    }
    
    [self validate:val p:section==nil thePid:pid];

    /*
    if(checkBox.selected)
    {
        [checkBox setSelected:NO];
        if(section!=nil)
        {
            [selectIds removeObject:[obj objectForKey:@"trolleyid"]];
            totalPrice = totalPrice - [[obj objectForKey:@"productprice"]doubleValue];
            lblTotolPrice.text = [NSString stringWithFormat:@"￥%.2f",totalPrice];
        }
    }
    else
    {
        [checkBox setSelected:YES];
        if(section!=nil)
        {
            [selectIds addObject:[obj objectForKey:@"trolleyid"]];
            totalPrice = totalPrice + [[obj objectForKey:@"productprice"]doubleValue];
            lblTotolPrice.text = [NSString stringWithFormat:@"￥%.2f",totalPrice];
        }
    }
    
    if([checkBox titleForState:UIControlStateDisabled]==nil)
    {
        for (UIButton *btn in checkBoxs) {
            NSString *title=[btn titleForState:UIControlStateDisabled];
            if(title!=nil && [title intValue] == checkBox.tag)
            {
                [btn setSelected:checkBox.selected];
            }
        }
    }
     */
    
}

-(IBAction)CountAdd:(id)sender
{
    UIButton *btn=sender;
    
    NSString *section=[btn titleForState:UIControlStateDisabled];
    NSLog(section);
    
    
    id objsection = [datas objectAtIndex:[section intValue]];
    
    NSArray *pro=[objsection objectForKey:@"children"];
    
    id obj=[pro objectAtIndex:btn.tag];
    
    NSInteger count =[[obj objectForKey:@"productnum"] integerValue];
    count=count+1;
    NSMutableDictionary *pm=[[NSMutableDictionary alloc]init];
    [pm setValue:[obj objectForKey:@"trolleyid"]  forKey:@"trolleyId"];
    [pm setValue:[NSString stringWithFormat:@"%d",count] forKey:@"productNum"];
    [pm setValue:[obj objectForKey:@"productprice"] forKey:@"productPrice"];
    NSString *url =[NSString stringWithFormat:@"%@/client/act/sale/trolley/update",LocalHostm];
    /*
    [YunMeiHttpUtils httpRequest:url pm:pm withBlock:^(NSDictionary *dict) {
        [self GetHttpData];
    }];
     */
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self httpRequest:url pm:pm data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"add",@"tag", nil]];
}

-(IBAction)CountSubtract:(id)sender
{
    
    UIButton *btn=sender;
    
    NSString *section=[btn titleForState:UIControlStateDisabled];
    NSLog(section);
    
    
    id objsection = [datas objectAtIndex:[section intValue]];
    
    NSArray *pro=[objsection objectForKey:@"children"];
    
    id obj=[pro objectAtIndex:btn.tag];
    
    NSInteger count =[[obj objectForKey:@"productnum"] integerValue];
    if(count ==1 )
    {
        return;
    }
    count=count-1;
    
    NSMutableDictionary *pm=[[NSMutableDictionary alloc]init];
    [pm setValue:[obj objectForKey:@"trolleyid"]  forKey:@"trolleyId"];
    [pm setValue:[NSString stringWithFormat:@"%d",count] forKey:@"productNum"];
    [pm setValue:[obj objectForKey:@"productprice"] forKey:@"productPrice"];
    NSString *url =[NSString stringWithFormat:@"%@/client/act/sale/trolley/update",LocalHostm];
    /*
    [YunMeiHttpUtils httpRequest:url pm:pm withBlock:^(NSDictionary *dict) {
        [self GetHttpData];
    }];
    */
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self httpRequest:url pm:pm data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"subtract",@"tag", nil]];
}

-(IBAction)Remove:(id)sender
{
    NSString *ids=@"";
    for (id trolleyid in selectIds) {
        
        ids= [NSString stringWithFormat:@"%@%@,",ids,trolleyid];
        
    }
    if(ids.length<1){
        [SVProgressHUD showInfoWithStatus:@"没有选中移除项"];
        return;
    }
    ids = [ids substringToIndex:ids.length-1];
    NSMutableDictionary *pm=[[NSMutableDictionary alloc]init];
    [pm setValue:ids  forKey:@"trolleyIds"];
    NSString *url =[NSString stringWithFormat:@"%@/client/act/sale/trolley/delete",LocalHostm];
   /*
    [YunMeiHttpUtils httpRequest:url pm:pm withBlock:^(NSDictionary *dict) {
        [self GetHttpData];
    }];
    */

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self httpRequest:url pm:pm data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"remove",@"tag", nil]];
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

-(void)validate:(int)proid   p:(BOOL)ptag thePid:(int)pid{
    
    NSMutableArray *datas1=[[NSMutableArray alloc]initWithCapacity:0];
    
    //商户
    if(ptag){
        for(NSDictionary *oo in datas){
            NSMutableDictionary *root=[[NSMutableDictionary alloc]initWithDictionary:oo];
            if([[oo objectForKey:@"shopid"] intValue]==proid){
                if([[oo allKeys]containsObject:@"check"] ){
                    NSString *tag1=[oo objectForKey:@"check"];
                    
                    if([tag1 isEqualToString:@"1"]){//选中
                        [root setObject:@"0" forKey:@"check"];
                        NSArray *childs=[oo objectForKey:@"children"];
                        NSMutableArray *childs1=[[NSMutableArray alloc]initWithCapacity:0];
                        for(id child in childs){
                            NSMutableDictionary *ch=[[NSMutableDictionary alloc]initWithDictionary:child];
                            [ch setObject:@"0" forKey:@"check"];
                            [childs1 addObject:ch];
                        }
                        [root setObject:childs1 forKey:@"children"];
                        
                    }else if([tag1 isEqualToString:@"0"]){//取消选中
                        [root setObject:@"1" forKey:@"check"];
                        
                        NSArray *childs=[oo objectForKey:@"children"];
                        NSMutableArray *childs1=[[NSMutableArray alloc]initWithCapacity:0];
                        for(id child in childs){
                            NSMutableDictionary *ch=[[NSMutableDictionary alloc]initWithDictionary:child];
                            [ch setObject:@"1" forKey:@"check"];
                            [childs1 addObject:ch];
                        }
                        [root setObject:childs1 forKey:@"children"];
                        
                    }
                    
                }
            }
            [datas1 addObject:root];
            
        }
    }else{
        //商品
        for(NSDictionary *oo in datas){
            NSMutableDictionary *root=[[NSMutableDictionary alloc]initWithDictionary:oo];
            if([[oo objectForKey:@"shopid"] intValue]==pid){
                NSArray *childs=[oo objectForKey:@"children"];
                
                NSMutableArray *childs1=[[NSMutableArray alloc]initWithCapacity:0];
                
                for(id child in childs){
                    if([[child objectForKey:@"trolleyid"]intValue]==proid){
                        NSMutableDictionary *mchild=[[NSMutableDictionary alloc]initWithDictionary:child];
                        NSString *tag1=[child objectForKey:@"check"];
                        if([tag1 isEqualToString:@"0"]){
                            [mchild setObject:@"1" forKey:@"check"];
                            [root setObject:@"1" forKey:@"check"];
                        }else{
                            [mchild setObject:@"0" forKey:@"check"];
                            [root setObject:@"0" forKey:@"check"];
                        }
                        [childs1 addObject:mchild];
                    }else{
                        [childs1 addObject:child];
                    }
                }
                [root setObject:childs1 forKey:@"children"];
            }
            [datas1 addObject:root];
            
        }
        
    }
    
    datas=datas1;
    [self.tableViewList reloadData];
}

-(double)getOrderPriceCount{
    double pricCount=0.00;
    for(NSDictionary *root in datas){
        NSArray *childs=[root objectForKey:@"children"];
        for(id child in childs){
            NSString *tag1=[child objectForKey:@"check"];
            if([tag1 isEqualToString:@"1"]){//选中
                double pric= [[child objectForKey:@"productprice"] doubleValue];
                pricCount=pricCount+pric;
            }
        }
    }
    
    return pricCount;
}

@end
