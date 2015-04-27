//
//  ShopListViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopViewController.h"

@interface ShopListViewController ()
{
    NSArray *datas;
}
@end

@implementation ShopListViewController
@synthesize myTableView,find;

- (void)viewDidLoad {
    [super viewDidLoad];
    if(find==nil)
    {
    [self setTitle:@"商户列表"];
    }
    else
    {
        [self setTitle:@"发现"];
    }
    
    //-------隐藏UITableView多余的分割线
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.myTableView setTableFooterView:view];
    //--------隐藏UITableView多余的分割线
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *url=[NSString stringWithFormat:@"%@/client/act/comsumer/shop/queryShops",LocalHost];
    NSMutableDictionary *md=[[NSMutableDictionary alloc]init];
    [md setValue:@"1" forKey:@"page"];
    [md setValue:@"1000" forKey:@"pagesize"];
    if(find!=nil)
    {
        [md setValue:find forKey:@"find"];
    }
    
    [self httpRequest:url pm:md data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"tag", nil]];
    
    /*
    [YunMeiHttpUtils httpRequest:url  pm:md withBlock:^(NSDictionary *dict) {
        [self LoadData:dict];
    }];
     */
}


-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    if(userInfo==nil){
        return;
    }
    
    //处理列表
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"list"]){
        [self LoadData:dict];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)LoadData:(NSDictionary *)dict
{
    datas=[NSArray arrayWithArray:[dict objectForKey:@"Rows"]];
    [myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datas count];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ShopViewController *controller = [[ShopViewController alloc]initWithNibName:@"ShopViewController" bundle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
//}

#define TAG_IMAGE 1
#define TAG_TITLE 2
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,90,90)];
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
    
    NSURL  *imageurl=[NSURL URLWithString:[ NSString stringWithFormat: @"%@/client/act/comsumer/getImg?url=%@",LocalHostm,[obj objectForKey:@"shoplogurl"]]];
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:TAG_IMAGE];
    [imgView setImageWithURL:imageurl placeholderImage:nil options:SDWebImageRetryFailed];
    
    UILabel *titleLable=(UILabel *)[cell viewWithTag:TAG_TITLE];
    titleLable.text=[obj objectForKey:@"shopintroduce"];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
