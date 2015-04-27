//
//  AddressEditViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseSecondViewController.h"
#import "HZAreaPickerView.h"


@interface AddressEditViewController : BaseSecondViewController<UITextFieldDelegate, HZAreaPickerDelegate>


@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;

@property(strong)IBOutlet UITextField *txtPelple;
@property(strong)IBOutlet UITextField *txtTel;

@property(strong)IBOutlet UITextField *txtProvince;
@property(strong)IBOutlet UITextField *txtCity;
@property(strong)IBOutlet UITextField *txtTown;

@property(strong)IBOutlet UITextField *txtPostCode;
@property(strong)IBOutlet UITextView *txtAddress;

@property(strong)NSDictionary *infoDictionary;

-(IBAction)addAction:(id)sender;

@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;

-(void)cancelLocatePicker;

@end
