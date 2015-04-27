//
//  AddressEditViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "AddressEditViewController.h"
#import "AreaViewController.h"
#import "Utils.h"


@interface AddressEditViewController ()
{
    NSMutableArray *address;
}
@end

@implementation AddressEditViewController
@synthesize scrollView,infoDictionary;
@synthesize areaValue=_areaValue, cityValue=_cityValue;


@synthesize txtPelple,txtTel,txtProvince,txtCity,txtTown,txtAddress,txtPostCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"收货地址添加";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    txtAddress.layer.borderWidth=1;
    txtAddress.layer.borderColor=[COLOR_BORDER CGColor];
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height*2)-350);
    if(infoDictionary!=nil){
        [self initEditInfo];
    }
    // Do any additional setup after loading the view from its nib.
}


-(void)initEditInfo{
    [self setTitle:@"收货地址编辑"];
    txtPelple.text=[infoDictionary objectForKey:@"receivername"];
    txtTel.text=[infoDictionary objectForKey:@"receiverphone"];
    txtProvince.text=[infoDictionary objectForKey:@"receiverprovincearea"];
    txtCity.text=[infoDictionary objectForKey:@"receivercityarea"];
    txtTown.text=[infoDictionary objectForKey:@"receivercountyarea"];
    txtAddress.text=[infoDictionary objectForKey:@"receiveraddress"];
    txtPostCode.text=[infoDictionary objectForKey:@"receiverpostalcode"];
}

-(IBAction)Area:(id)sender
{
    AreaViewController *editController=[[AreaViewController alloc]initWithNibName:@"AreaViewController" bundle:nil];
    
    [self.navigationController pushViewController:editController animated:YES];
}

-(void)ReturnArea:(NSMutableArray *)area
{
    address=area;
    
}

-(IBAction)addAction:(id)sender
{
    
    if(txtPelple.text.length<1){
        [txtPelple becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"收货人输入不正确"];
        return;
    }
    if(txtTel.text.length<1){
        [txtTel becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"联系电话输入不正确"];
        return;
    }
    
    if(txtProvince.text.length<1){
        [txtProvince becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"省份输入不正确"];
        return;
    }
    if(txtCity.text.length<1){
        [txtCity becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"城市输入不正确"];
        return;
    }
    if(txtTown.text.length<1){
        [txtTown becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"县/区输入不正确"];
        return;
    }
    if(txtPostCode.text.length<5){
        [txtPostCode becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"邮政编码输入不正确"];
        return;
    }
    
    
    
    
//    接口：/client/act/comsumer/addAddress
//    传入参数：receiverpeopleid，receiverName，receiverProvinceArea，receiverCityArea，receiverCountyArea
//    receiverAddress，receiverPhone，receiverPostalcode
    NSString *url=[NSString stringWithFormat:@"%@/client/act/comsumer/addAddress",LocalHostm];
    
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    
    //修改
    if(infoDictionary!=nil){
       url=[NSString stringWithFormat:@"%@/client/act/comsumer/updateAddress",LocalHostm];
        [md setObject:[infoDictionary objectForKey:@"receiverid"] forKey:@"receiverid"];
    }
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    [md setObject:[NSString stringWithFormat:@"%d",app.peopleId] forKey:@"receiverpeopleid"];
    [md setObject:txtPelple.text forKey:@"receiverCityArea"];
    [md setObject:txtProvince.text forKey:@"receiverProvinceArea"];
    [md setObject:txtCity.text forKey:@"receiverCityArea"];
    [md setObject:txtTown.text forKey:@"receiverCountyArea"];
    [md setObject:txtPelple.text forKey:@"receiverName"];
    [md setObject:txtTel.text forKey:@"receiverPhone"];
    [md setObject:txtPostCode.text forKey:@"receiverPostalcode"];
    
     [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [self httpRequest:url pm:nil data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"save",@"tag", nil]];
    
}
-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    if(userInfo==nil){
        return;
    }
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"save"]){
        if([[dict allKeys]containsObject:@"status"]&&[[dict objectForKey:@"status"] boolValue]){
            [SVProgressHUD showSuccessWithStatus:[dict objectForKey:@"message"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[dict objectForKey:@"message"]];
        }
        return;
    }
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

//--------------------城市选择-----------------------------------

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    
    
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
        [self.txtProvince setText:picker.locate.state];
        [self.txtCity setText:picker.locate.city];
        [self.txtTown setText:picker.locate.district];
        [self.txtAddress setText:self.areaValue];
        
    } else{
        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}
#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if ([textField isEqual:self.txtProvince]||[textField isEqual:self.txtCity]||[textField isEqual:self.txtTown]) {
        [self cancelLocatePicker];
         [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
        
        
        [self.locatePicker showInView:self.view];
        
        return NO;
    }else{
       [self cancelLocatePicker];
    }
    /*else {
        [self cancelLocatePicker];
        self.locatePicker = [[[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self] autorelease];
        [self.locatePicker showInView:self.view];
    }*/
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}
//--------------------城市选择-----------------------------------
@end
