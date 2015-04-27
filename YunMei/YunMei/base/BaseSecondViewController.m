//
//  BaseSecondViewController.m
//  YunMei
//
//  Created by  macbook on 15-1-13.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "BaseSecondViewController.h"
#import "RDVTabBarController.h"

@interface BaseSecondViewController ()

@end

@implementation BaseSecondViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    
     UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:COLOR_NAVIGATIONBAR_BACK_IMAGE style:UIBarButtonItemStyleBordered target:self action:@selector(backAction:)];
     backItem.tintColor=COLOR_NAVIGATIONBAR_BACK_COLOR;
    
     //backItem.imageInsets=COLOR_NAVIGATIONBAR_BACK_imageInsets;
     self.navigationItem.leftBarButtonItem=backItem;
     
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
