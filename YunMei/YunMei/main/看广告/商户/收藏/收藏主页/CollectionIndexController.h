//
//  CollectionIndexController.h
//  YunMei
//
//  Created by XingJian Li on 15-1-22.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"
#import "CollectionSpController.h"
#import "CollectionSJController.h"
#import "CollectionGGController.h"

@interface CollectionIndexController : BaseSecondViewController

@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;

-(IBAction)spAction:(id)sender;
-(IBAction)sjAction:(id)sender;
-(IBAction)ggAction:(id)sender;
@end
