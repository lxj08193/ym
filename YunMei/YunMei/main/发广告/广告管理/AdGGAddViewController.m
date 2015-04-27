//
//  AdSPAddViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "AdGGAddViewController.h"



@interface AdGGAddViewController ()

@end

@implementation AdGGAddViewController
@synthesize scrollView,adNSDictionary,saveButton;
@synthesize adName,adTitle,adImageF,adImage1,adImage2,adImage3,adImage4,adIntros,adLink,adStartDate,adEndDate,adType,adCount;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //添加手势
    UITapGestureRecognizer *singleFingerOne1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleFingerEvent:)];
     UITapGestureRecognizer *singleFingerOne2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleFingerEvent:)];
     UITapGestureRecognizer *singleFingerOne3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleFingerEvent:)];
     UITapGestureRecognizer *singleFingerOne4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleFingerEvent:)];
     UITapGestureRecognizer *singleFingerOne5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    
    
    
    [adImageF setUserInteractionEnabled:TRUE];  //设置UIImageView允许点击
    [adImage1 setUserInteractionEnabled:TRUE];
    [adImage2 setUserInteractionEnabled:TRUE];
    [adImage3 setUserInteractionEnabled:TRUE];
    [adImage4 setUserInteractionEnabled:TRUE];
    
    
    [adImageF addGestureRecognizer:singleFingerOne1];
    
    [adImage1 addGestureRecognizer:singleFingerOne2];
    [adImage2 addGestureRecognizer:singleFingerOne3];
    [adImage3 addGestureRecognizer:singleFingerOne4];
    [adImage4 addGestureRecognizer:singleFingerOne5];
    
   
    
    scrollView.pagingEnabled=YES;//是否自己动适应
    sh=self.scrollView.frame.size.height;
    scrollView.frame=self.view.bounds;
    [self.view addSubview:scrollView];
    
    if(nil!=adNSDictionary){
        [self initAdData];
    }
       // Do any additional setup after loading the view from its nib.
}
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    if(sender.numberOfTapsRequired == 1) {
        //单指单击
        NSLog(@"单指单击");
        cureeImageView=sender.view;
        [self carmaAction:nil];
    }
}

-(IBAction)carmaAction:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片"  delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"相册"
                                              otherButtonTitles:@"相机",nil];
    
    [sheet showInView:self.view];
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        if(buttonIndex==0){
            [self showCa:2];
        }else if(buttonIndex==1){
            [self showCa:1];
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //int bh=self.view.frame.size.height-64;
    
    
    
    //scrollView.frame=self.view.frame;
    
    
    
    //scrollView.contentSize =CGSizeMake(self.view.frame.size.width, scrollView.frame.size.height+(scrollView.frame.size.height-self.view.frame.size.height));
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width,sh);
     //[inputHelper setupInputHelperForView:self.scrollView withDismissType:InputHelperDismissTypeTapGusture];
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
-(void)showCa:(int)type{
    //创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if(type==1){
        //指定源类型前，检查图片源是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            //指定源的类型
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
            imagePicker.allowsEditing = YES;
            
            //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
            imagePicker.delegate = self;
            
            //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
            //[self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
            
            
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alert show];
        }
        
    }else if(type==2){
        //指定源类型前，检查图片源是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            //指定源的类型
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
            imagePicker.allowsEditing = YES;
            
            //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
            imagePicker.delegate = self;
            
            //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
            //[self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
            
            
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
    
}


#pragma  mark -
#pragma  mark UIImagePickerControllerDelegate协议的方法

//用户点击图像选取器中的“cancel”按钮时被调用，这说明用户想要中止选取图像的操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//用户点击选取器中的“choose”按钮时被调用，告知委托对象，选取操作已经完成，同时将返回选取图片的实例
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //noticeLabel.hidden = YES;
    //[imageView setImage:image];
    [picker dismissModalViewControllerAnimated:YES];
    
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    //获取图片后的操作
    cureeImageView.image=image;
    //[cureeImageView setBackgroundImage: image forState:UIControlStateNormal];
    [cureeImageView setImage:image];
    
}



-(IBAction)dateAction:(id)sender
{
    
    if (!chvc) {
        
        chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"日期选择";
        
        [chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
        
    }
    
    
    UIButton *but=sender;
    
    
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);
        
    
        if(but.tag==100){
            startDateCurr=model.date;
        }else if(but.tag==101){
            endDateCurr=model.date;
        }
        
        if (model.holiday) {
            
            [but setTitle:[NSString stringWithFormat:@"%@ %@ %@",[model toString],[model getWeek],model.holiday] forState:UIControlStateNormal];
            
        }else{
            
            [but setTitle:[NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]] forState:UIControlStateNormal];
            
        }
    };
    
    [self.navigationController pushViewController:chvc animated:YES];
    
    
    
}
-(IBAction)saveAction:(id)sender{
    
   
    if(adName.text.length<1){
        [adName becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"广告名称输入不正确"];
        return;
    }
    if(adTitle.text.length<1){
        [adTitle becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"广告语输入不正确"];
        return;
    }

    
    if(adIntros.text.length<1){
        [adIntros becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"广告简介输入不正确"];
        return;
    }
    if(adLink.text.length<1){
        [adLink becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"广告链接地址不正确"];
        return;
    }
    if(startDateCurr==nil){
        [SVProgressHUD showErrorWithStatus:@"请选择开始日期"];
        return;
    }
    if(endDateCurr==nil){
        [SVProgressHUD showErrorWithStatus:@"请选择结束日期"];
        return;
    }
    
    NSString *typeName=adType.titleLabel.text;
    if(typeName.length<1|| [typeName isEqualToString:@"选择"]){
        //[adIntros becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"请选择广告类别"];
        return;
    }
    
    if(adCount.text.length<1){
        [adCount becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"投放人数输入不正确"];
        return;
    }
    
    
    NSMutableDictionary *pm=[[NSMutableDictionary alloc]initWithCapacity:0];

    [pm setObject:adName.text forKey:@"name"];
    [pm setObject:adTitle.text forKey:@"slogan"];
    [pm setObject:adLink.text forKey:@"linkAddress"];
    [pm setObject:adIntros.text forKey:@"description"];
    [pm setObject:[self longLongFromDate:startDateCurr] forKey:@"beginTime"];
    [pm setObject:[self longLongFromDate:endDateCurr] forKey:@"endTime"];
    [pm setObject:adCount.text forKey:@"num"];
    [pm setObject:@"0" forKey:@"type"];
    [pm setObject:currtypeId forKey:@"advertType"];

    
    //加入图片文件流
    NSMutableArray *fileDatas=[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableDictionary *fileDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [fileDic setObject:@"shop.png" forKey:@"fileName"];
    [fileDic setObject:@"image/png" forKey:@"type"];
    [fileDic setObject:@"shopLogUrl" forKey:@"name"];
    [fileDic setObject:UIImagePNGRepresentation(adImageF.image) forKey:@"data"];
    [fileDatas addObject:fileDic];
    
    //NSString *url=[NSString stringWithFormat:@"%@/client/act/product/type/query?page=1&pagesize=100",LocalHostm];
    //[self httpRequest:url pm:pm data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"save",@"tag", nil]];
    
    NSString *url=[NSString stringWithFormat:@"%@/client/act/advert/add",LocalHostm];
    
    [self httpRequest:url pm:pm data:fileDatas userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"save",@"tag", nil]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

}
-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    if(userInfo==nil){
        return;
    }
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"save"]){
        
        if([[dict allKeys]containsObject:@"status"]&&[[dict objectForKey:@"status"] boolValue]){
            [SVProgressHUD showSuccessWithStatus:[dict objectForKey:@"message"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
}
-(NSString *)longLongFromDate:(NSDate*)date{
    long longValue= [date timeIntervalSince1970] * 1000;
    
    // long long 型转换
    
    NSNumber *longlongNumber = [NSNumber numberWithLongLong:longValue];
    
    NSString *longlongStr = [longlongNumber stringValue];
    
    return longlongStr;

}

-(IBAction)selectTypeAction:(id)sender{
    AdTypeTreeViewController *viewController=[[AdTypeTreeViewController alloc]init];
    viewController.title=@"选择广告类型";
    [self.navigationController pushViewController:viewController animated:YES];
    
    viewController.adTypeBlock = ^(BDDynamicTreeNode *model){
        currtypeId=model.nodeId;
        [adType setTitle:model.name forState:UIControlStateNormal];
    };
    
}


-(void)initAdData{
    [saveButton setHidden:YES];

    [adName setText:[adNSDictionary objectForKey:@"name"]];
    [adTitle setText:[adNSDictionary objectForKey:@"slogan"]];
    [adLink setText:[adNSDictionary objectForKey:@"linkaddress"]];
    [adCount setText:[NSString stringWithFormat:@"%d",[[adNSDictionary objectForKey:@"num"] integerValue]]];
    [adIntros setText:[adNSDictionary objectForKey:@"description"]];
    
   // [adStartDate setTitle:[adNSDictionary objectForKey:@"begintime"] forState:UIControlStateNormal];
    //[adEndDate setTitle:[adNSDictionary objectForKey:@"endtime"] forState:UIControlStateNormal];
}

@end
