//
//  CollectionIndexController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-22.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "CollectionIndexController.h"

@interface CollectionIndexController ()

@end

@implementation CollectionIndexController

@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.contentSize = self.view.frame.size;
    // Do any additional setup after loading the view from its nib.
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的收藏";
    }
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)spAction:(id)sender{
    CollectionSpController *sp=[[CollectionSpController alloc]initWithNibName:@"CollectionSpController" bundle:nil];
    [self.navigationController pushViewController:sp animated:YES];
}
-(IBAction)sjAction:(id)sender{
    CollectionSJController *sp=[[CollectionSJController alloc]initWithNibName:@"CollectionSJController" bundle:nil];
    [self.navigationController pushViewController:sp animated:YES];

}
-(IBAction)ggAction:(id)sender{
    CollectionGGController *sp=[[CollectionGGController alloc]initWithNibName:@"CollectionGGController" bundle:nil];
    [self.navigationController pushViewController:sp animated:YES];
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
