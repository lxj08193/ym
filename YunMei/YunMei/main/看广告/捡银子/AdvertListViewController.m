//
//  AdvertListViewController.m
//  YunMei
//
//  Created by  macbook on 15-1-30.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "AdvertListViewController.h"
#import "SmallMoneyViewController.h"

@interface AdvertListViewController ()
{
    NSMutableArray *datas;
    NSArray *typeDatas;
    int page;
}
@end

@implementation AdvertListViewController
@synthesize myTableView,mySegCtrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    page=1;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)SegmentAction:(UISegmentedControl *)segment
{
    int index=segment.selectedSegmentIndex;
    NSString *url=[NSString stringWithFormat:@"%@/client/act/advert/query",LocalHostm];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [dic setValue:@"1" forKey:@"page"];
    [dic setValue:@"1" forKey:@"pagesize"];
    [dic setValue:[[typeDatas objectAtIndex:index] objectForKey:@"id"] forKey:@"advertType"];
    [YunMeiHttpUtils httpRequest:url pm:dic withBlock:^(NSDictionary *dict) {
        [self GetData:[dict objectForKey:@"Rows"]];
    }];

}

-(void)GetTypeData:(NSArray *)arr
{
    [mySegCtrl removeAllSegments];
    mySegCtrl.layer.borderWidth=0;
    [mySegCtrl setHidden:NO];
    typeDatas =arr;
    for (int i=0; i<[arr count]; i++) {
        id obj = [arr objectAtIndex:i];
        [mySegCtrl insertSegmentWithTitle:[obj objectForKey:@"name"] atIndex:i animated:YES];
    }
    [mySegCtrl setSelectedSegmentIndex:0];
}

-(void)GetData:(NSArray *)data
{
    if(page==1){
        datas=[[NSMutableArray alloc]initWithArray:data];
    }else if(page>1){
        for(id obj in data){
            [datas addObject:obj];
        }
    }

    [myTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *url=[NSString stringWithFormat:@"%@/client/act/product/type/query",LocalHostm];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [dic setValue:@"1" forKey:@"page"];
    [dic setValue:@"10000" forKey:@"pagesize"];
    [YunMeiHttpUtils httpRequest:url pm:dic withBlock:^(NSDictionary *dict) {
        [self GetTypeData:[dict objectForKey:@"Rows"]];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return myTableView.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmallMoneyViewController *controller=[[SmallMoneyViewController alloc]initWithNibName:@"SmallMoneyViewController" bundle:nil];
    controller.dicAdvert = [datas objectAtIndex:0];
    [self.navigationController pushViewController:controller animated:YES];
}

#define TAG_IMAGE     1
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,myTableView.frame.size.width-10,myTableView.frame.size.height-10)];
        [cell.contentView addSubview:imgView];
        imgView.backgroundColor = COLOR_SEP;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = TAG_IMAGE;
    }
    id obj = [datas objectAtIndex:indexPath.row];
    NSURL  *imageurl=[NSURL URLWithString:[ NSString stringWithFormat: @"%@/client/act/advert/image/get?id=%@",LocalHostm,[obj objectForKey:@"maxfileid"]]];
    
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:TAG_IMAGE];
    [imgView setImageWithURL:imageurl placeholderImage:nil options:SDWebImageRetryFailed];
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
