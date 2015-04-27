//
//  AdSPAddViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "SFRZViewController.h"

@interface SFRZViewController ()
{
    UIButton *imageView;
}

@end

@implementation SFRZViewController
@synthesize btnLincense,btnTax;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Submit:(id)sender
{
//    接口：/client/act/comsumer/shopComfirm/add
//    传入参数：dusinessNum(营业执照号码)
//    上传营业执照dusinessUrl，承诺书commitBookUrl，税务证书taxLicenseUrl，营业场所dusinessPlace
    
   
    if(btnLincense.imageView.image == nil)
    {
        [self showtips:@"请选择营业执照图片"];
        return;
    }
    if(btnTax.imageView.image == nil)
    {
        [self showtips:@"请选择税务登记证图片"];
        return;
    }
   
    
    NSString *url=[NSString stringWithFormat:@"%@/client/act/comsumer/shopComfirm/add",LocalHostm];
    NSMutableDictionary *md=[[NSMutableDictionary alloc]init];
    
    
    //加入图片文件流
    NSMutableArray *fileData=[[NSMutableArray alloc]initWithCapacity:0];
    
    
    NSMutableDictionary *fileDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [fileDic setObject:@"lincense.png" forKey:@"fileName"];
    [fileDic setObject:@"image/png" forKey:@"type"];
    [fileDic setObject:@"businessUrl" forKey:@"name"];
    [fileDic setObject:UIImagePNGRepresentation(btnLincense.imageView.image) forKey:@"data"];
    [fileData addObject:fileDic];
    
    fileDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [fileDic setObject:@"tax" forKey:@"fileName"];
    [fileDic setObject:@"image/png" forKey:@"type"];
    [fileDic setObject:@"taxLicenseUrl" forKey:@"name"];
    [fileDic setObject:UIImagePNGRepresentation(btnTax.imageView.image) forKey:@"data"];
    [fileData addObject:fileDic];
    
    
    [YunMeiHttpUtils httpRequest:url  pm:md data:fileData withBlock:^(NSDictionary *dict) {            [self showtips:[dict objectForKey:@"message"]];
    }];
}


//---------------------------------选择图片----------------------------------
-(IBAction)carmaAction:(id)sender{
    imageView=sender;
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
    imageView.imageView.image=image;
    [imageView setBackgroundImage: image forState:UIControlStateNormal];
}
//---------------------------------------------选择图片------------------------------------------------

@end
