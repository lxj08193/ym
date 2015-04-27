//
//  AdSPAddViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "AdSPAddViewController.h"

@interface AdSPAddViewController ()

@end

@implementation AdSPAddViewController


@synthesize adName,adImageF,adImage1,adImage2,adImage3,adImage4,adIntros,adLink,adPrice1,adPrice2,adType,adCount;
@synthesize scrollView;
-(void)viewDidLoad {
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
    
    
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width,sh);
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
    //scrollView.contentSize=CGSizeMake(self.view.frame.size.width,sh);
    
}


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




-(IBAction)saveAction:(id)sender{
    if(adName.text.length<1){
        [adName becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"商品名称输入不正确"];
        return;
    }
    
    
    NSString *typeName=adType.titleLabel.text;
    if(typeName.length<1|| [typeName isEqualToString:@"选择类别"]){
        //[adIntros becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"请选择商品类别"];
        return;
    }

    if(adIntros.text.length<1){
        [adIntros becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"商品简介输入不正确"];
        return;
    }
    if(adLink.text.length<1){
        [adLink becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"商品地址输入不正确"];
        return;
    }
    
    if(adCount.text.length<1){
        [adCount becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"商品数量输入不正确"];
        return;
    }
    if(adPrice1.text.length<1){
        [adPrice1 becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"商品价格输入不正确"];
        return;
    }
    if(adPrice2.text.length<1){
        [adPrice2 becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"商品价格输入不正确"];
        return;
    }
    
    
    
    NSMutableDictionary *pm=[[NSMutableDictionary alloc]initWithCapacity:0];
    
    [pm setObject:adName.text forKey:@"productName"];
    [pm setObject:adLink.text forKey:@"linkAddress"];
    [pm setObject:adIntros.text forKey:@"remark"];
    [pm setObject:adCount.text forKey:@"productQuantity"];
    [pm setObject:adPrice1.text forKey:@"productPrice"];
    [pm setObject:adPrice2.text forKey:@"discountPrice"];
    [pm setObject:currtypeId forKey:@"typeId"];
    
    
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
    
    NSString *url=[NSString stringWithFormat:@"%@/client/act/product/create",LocalHostm];
    
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
    SPTypeTreeViewController *viewController=[[SPTypeTreeViewController alloc]init];
    viewController.title=@"选择商品类型";
    [self.navigationController pushViewController:viewController animated:YES];
    
    viewController.shopTypeBlock = ^(BDDynamicTreeNode *model){
        currtypeId=model.nodeId;
        [adType setTitle:model.name forState:UIControlStateNormal];
    };

}

@end
