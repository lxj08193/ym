//
//  SmallMoneyViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "SmallMoneyViewController.h"
#import "Utils.h"

@interface SmallMoneyViewController ()

@end

@implementation SmallMoneyViewController
@synthesize scrollView,imgAdvert,txtAdvert,txtDes,btnGet,dicAdvert;

- (void)viewDidLoad {
    [super viewDidLoad];
     scrollView.contentSize = self.view.frame.size;
    [self setTitle:[dicAdvert objectForKey:@"name"]];
    
    txtAdvert.layer.borderWidth=1;
    txtAdvert.layer.borderColor=[COLOR_BORDER CGColor];
    txtAdvert.layer.cornerRadius=5;
    txtAdvert.layer.masksToBounds=YES;
    txtAdvert.text=[dicAdvert objectForKey:@"slogan"];
    
    txtDes.layer.borderWidth=1;
    txtDes.layer.borderColor=[COLOR_BORDER CGColor];
    txtDes.layer.cornerRadius=5;
    txtDes.layer.masksToBounds=YES;
    txtAdvert.text=[dicAdvert objectForKey:@"description"];
    
    [imgAdvert setImageWithURL:[NSURL URLWithString:[ NSString stringWithFormat: @"%@/client/act/advert/image/get?id=%@",LocalHostm,[dicAdvert objectForKey:@"maxfileid"]]] placeholderImage:nil options:SDWebImageRetryFailed];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"捡铜板";
    }
    return self;
}

-(IBAction)Get:(id)sender
{
    NSString *url=[NSString stringWithFormat:@"%@/client/act/advert/user/see",LocalHostm];
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setObject:[dicAdvert objectForKey:@"id"] forKey:@"advertId"];
    [md setObject:@"0" forKey:@"seeType"];

    [YunMeiHttpUtils httpRequest:url pm:md withBlock:^(NSDictionary *dict) {
        [self showtips:[dict objectForKey:@"message"]];
        [super BackUp:sender];
    }];
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
