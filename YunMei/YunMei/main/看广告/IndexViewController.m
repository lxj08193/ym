//
//  IndexViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-3.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "MoneyBaseViewController.h"
#import "SmallMoneyViewController.h"
#import "CollectionIndexController.h"
#import "AdvertListViewController.h"


@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize btnImage,mBTitleView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"看广告";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar setHidden:TRUE];
    
    images =[[NSMutableArray alloc]init];
    [images addObject:@"money.png"];
    [images addObject:@"mearby.png"];
    [images addObject:@"exchange.png"];
    [images addObject:@"copper.png"];

    
    
//    NSTimer *timer=nstime
    // Do any additional setup after loading the view from its nib.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   [self initMBView];
}


//--------------------------循环滚动视图----------------------------
-(void)initMBView{
    
    if(nil!=titleView&&nil!=arrayImageObj&&[arrayImageObj count]>0){
        return;
    }
    
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setValue:[NSString stringWithFormat:@"%d",1]  forKey:@"page"];
    [md setValue:@"100" forKey:@"pagesize"];
    
    arrayImageObj = [[NSMutableArray alloc]init];
    
    NSString *url =[NSString stringWithFormat:@"%@/client/act/advert/first/query",LocalHostm];
    [self httpRequest:url pm:md];
   
    
   
}
-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    
    NSMutableArray *arrayImage = [[NSMutableArray alloc]init];
    for (id obj in [dict objectForKey:@"Rows"]) {
        [arrayImageObj addObject:obj];
        [arrayImage addObject:[NSString stringWithFormat:@"%@/client/act/advert/image/get?id=%@",LocalHostm,[obj objectForKey:@"fileid"]]];
    }
    if([arrayImageObj count]>0){
        titleView =  [[MBTitleView alloc]initWithFrame:CGRectMake(0, 0, 320, mBTitleView.frame.size.height)];;
        titleView.imageArray = arrayImage;
        titleView.delegate = self;
        [titleView addTitleViewImages];
        [mBTitleView addSubview:titleView];
        
    }

}
-(void)titleImageDidSelect:(UIImageView *)v
{
    int index=v.tag-100;
    
    id obj=[arrayImageObj objectAtIndex:index-1];
    [self showDetailView:[obj objectForKey:@"linkaddress"] thetitle:[obj objectForKey:@"name"]];
  
    
}

//--------------------------循环滚动视图----------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)PageChanged:(id)sender
{
    
}

-(IBAction)ShopList:(id)sender
{
    ShopListViewController *controller=[[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)PersonalList:(id)sender
{
    PersonalViewController *controller=[[PersonalViewController alloc]initWithNibName:@"PersonalViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)Cart:(id)sender
{
    CartViewController *controller=[[CartViewController alloc]initWithNibName:@"CartViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)SendAd:(id)sender
{
    SendAdViewController *controller=[[SendAdViewController alloc]initWithNibName:@"SendAdViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}


-(IBAction)jtpAction:(id)sender{
    AdvertListViewController *yk=[[AdvertListViewController alloc]initWithNibName:@"AdvertListViewController" bundle:nil];
    [self.navigationController pushViewController:yk animated:YES];
}


-(IBAction)ykAction:(id)sender{
    MoneyBaseViewController *jtb=[[MoneyBaseViewController alloc]initWithNibName:@"MoneyBaseViewController" bundle:nil];
    [self.navigationController pushViewController:jtb animated:YES];
}
-(IBAction)scAction:(id)sender;{
    CollectionIndexController *jtb=[[CollectionIndexController alloc]initWithNibName:@"CollectionIndexController" bundle:nil];
    [self.navigationController pushViewController:jtb animated:YES];

}
-(IBAction)shopAction:(id)sender{
    MyShopViewController *jtb=[[MyShopViewController alloc]initWithNibName:@"MyShopViewController" bundle:nil];
    [self.navigationController pushViewController:jtb animated:YES];


}
-(IBAction)hdAction:(id)sender{
    HDViewController *jtb=[[HDViewController alloc]initWithNibName:@"HDViewController" bundle:nil];
    [self.navigationController pushViewController:jtb animated:YES];
}
-(IBAction)fxAction:(id)sender{
    ShopListViewController *jtb=[[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
    jtb.find=@"4";
   [self.navigationController pushViewController:jtb animated:YES];
}
-(IBAction)jyAction:(id)sender{

    JYViewController *jtb=[[JYViewController alloc]initWithNibName:@"JYViewController" bundle:nil];
    [self.navigationController pushViewController:jtb animated:YES];
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
