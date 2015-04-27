//
//  BookViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BookViewController.h"
#import "UIImageView+WebCache.h"
@interface BookViewController ()

@end

@implementation BookViewController

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"订单详情";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    listeDate=[[NSMutableArray alloc]initWithCapacity:0];
    [listeDate addObject:@"1"];
    [listeDate addObject:@"2"];
    [listeDate addObject:@"3"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self loadHttpData];
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
    return [listeDate count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableViewList.frame.size.width, 30)];
    
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 30)];
    titleLable.text=@"商品信息";
    [titleLable setTextColor:[UIColor redColor]];
    titleLable.font=[UIFont boldSystemFontOfSize:14];
    [titleLable setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:titleLable];
    
    UILabel *lineLable=[[UILabel alloc]initWithFrame:CGRectMake(4, 29, self.tableViewList.frame.size.width-8, 1)];
    [lineLable setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [view addSubview:lineLable];
    
    UILabel *titleLable2=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 100, 30)];
    titleLable2.text=@"伍草集";
    [titleLable2 setTextColor:[UIColor blackColor]];
    titleLable2.font=[UIFont boldSystemFontOfSize:14];
    [titleLable2 setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:titleLable2];
    
    
    UIButton *buuton1=[[UIButton alloc]initWithFrame:CGRectMake(self.tableViewList.frame.size.width-80, 5, 80, 20)];
    //[buuton1 setBackgroundImage:[UIImage imageNamed:@"联系卖家"] forState:UIControlStateNormal];
    [buuton1 setImage:[UIImage imageNamed:@"联系卖家"] forState:UIControlStateNormal];
    [buuton1 setTitle:@"联系卖家" forState:UIControlStateNormal];
    [buuton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buuton1.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [view addSubview:buuton1];
    
    
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
#define TAG_TITLE5                   5
#define TAG_TITLE6                   6

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
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,80,70)];
        [cell.contentView addSubview:imgView];
        imgView.backgroundColor = COLOR_SEP;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = TAG_IMAGE;
        //商品名
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 180, 25)];
        titleLabel.textColor = COLOR_MAIN_TEXT;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.numberOfLines=1;
        titleLabel.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:titleLabel];
        titleLabel.tag = TAG_TITLE;
        
        //产地
        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 180, 25)];
        titleLabel1.textColor = COLOR_MAIN_TEXT;
        titleLabel1.font = [UIFont systemFontOfSize:10];
        titleLabel1.numberOfLines=1;
        titleLabel1.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:titleLabel1];
        titleLabel1.tag = TAG_TITLE5;
        
        //品牌
        UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 180, 25)];
        titleLabel2.textColor = COLOR_MAIN_TEXT;
        titleLabel2.font = [UIFont systemFontOfSize:10];
        titleLabel2.numberOfLines=1;
        titleLabel2.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:titleLabel2];
        titleLabel2.tag = TAG_TITLE6;
        
        
        //原价
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,60,150,40)];
        descLabel.textColor = COLOR_SUB_TEXT;
        descLabel.font = [UIFont systemFontOfSize:10];;
        descLabel.numberOfLines = 2;
        descLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel];
        descLabel.tag = TAG_DESC;
        
        //现价
        UILabel *descLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(190,60,50,40)];
        descLabel2.textColor = COLOR_RED_DOWN;
        descLabel2.font = [UIFont systemFontOfSize:10];;
        descLabel2.numberOfLines = 2;
        descLabel2.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:descLabel2];
        descLabel2.tag = TAG_DESC2;
        
    }
    /*
     for(UIView *view in cell.contentView.subviews){
     [view removeFromSuperview];
     }*/
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:TAG_IMAGE];
    [imgView setImageWithURL:[NSURL URLWithString:@"http://imgnew.jiatx.com/news/2011_08/03/home/1312360607458_000.jpg"] placeholderImage:nil options:SDWebImageRetryFailed];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE];
    [titleLabel setText:@"居民基础养老金最低标准首上调 增至70元"];
    
    UILabel *titleLabel5 = (UILabel *)[cell.contentView viewWithTag:TAG_TITLE5];
    [titleLabel5 setText:@"产  地:中国昆明"];
    
    UILabel *titleLabel6= (UILabel *)[cell.contentView viewWithTag:TAG_TITLE6];
    [titleLabel6 setText:@"品  牌:伍草集"];
    
    
    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:TAG_DESC];
    [descLabel setText:@"数  量:1"];
    
    UILabel *descLabel2 = (UILabel *)[cell.contentView viewWithTag:TAG_DESC2];
    [descLabel2 setText:@"$40"];
    
    
   
    
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    
}

@end
