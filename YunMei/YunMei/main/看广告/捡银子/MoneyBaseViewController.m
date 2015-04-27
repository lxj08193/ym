//
//  MoneyBaseViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "MoneyBaseViewController.h"

@interface MoneyBaseViewController ()

@end

@implementation MoneyBaseViewController
@synthesize scrollView,txtTatol,txtAdvert,txtFuns,txtGive,txtUsed;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.contentSize = self.view.frame.size;
    
    NSString *url = [NSString stringWithFormat:@"%@/client/act/sale/integral/getSumFeeByTypes",LocalHostm];
    [YunMeiHttpUtils httpRequest:url withBlock:^(NSDictionary *dict) {
        for(id item in [dict allKeys])
        {
            switch([item intValue])
            {
                case 0:
                    txtTatol.text=[[dict objectForKey:item] stringValue];
                    break;
                case 2:
                    txtGive.text=[[dict objectForKey:item] stringValue];
                    break;
                case 6:
                    txtAdvert.text=[[dict objectForKey:item] stringValue];
                    break;
                case 7:
                    txtFuns.text=[[dict objectForKey:item] stringValue];
                    break;
                case 8:
                    txtUsed.text=[[dict objectForKey:item] stringValue];
                    break;
            }
        }
    }];
    
    // Do any additional setup after loading the view from its nib.
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"银库";
    }
    return self;
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

@end
