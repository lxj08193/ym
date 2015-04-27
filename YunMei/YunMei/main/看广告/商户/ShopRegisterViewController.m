//
//  ShopRegisterViewController.m
//  YunMei
//
//  Created by  macbook on 15-1-24.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "ShopRegisterViewController.h"
#import "AreaViewController.h"
#import "RDVTabBarController.h"
#import "SendAdViewController.h"

@interface ShopRegisterViewController ()
{
    NSArray *adress;
}

@end

@implementation ShopRegisterViewController
@synthesize imageViewBack,txtName,txtPeople,txtTel,txtAddress,txtIntroduce,scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"商户注册"];
     [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 800)];
    txtIntroduce.layer.borderWidth=1;
    
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(DismissKeyBoard:)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [btnSpace release];
    [doneButton release];
    
    [topView setItems:buttonsArray];
    [txtIntroduce setInputAccessoryView:topView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (void)viewWillAppear:(BOOL)animated {
     scrollView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
   [self.navigationItem setHidesBackButton:YES];
   //[[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
 }


-(IBAction)DismissKeyBoard:(id)sender
{
    [txtIntroduce resignFirstResponder];
}

-(void)ReturnArea:(NSArray *)area
{
    adress=area;
}

-(IBAction)Area:(id)sender
{
    AreaViewController *controller=[[AreaViewController alloc]initWithNibName:@"AreaViewController" bundle:nil];
    controller.delegate=self;
    [self.navigationController pushViewController:controller animated:YES];
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

-(IBAction)Submit:(id)sender
{
//    传入参数：shopName，shopPeople，shopTel，shopAddress，shopProvince，shopCity，shopArea，shopIntroduce
//    上传头像shopLogUrl
    NSString *url=[NSString stringWithFormat:@"%@/client/act/comsumer/shop/add",LocalHost];
    NSMutableDictionary *md=[[NSMutableDictionary alloc]init];
    [md setValue:txtName.text forKey:@"shopName"];
    [md setValue:txtPeople.text forKey:@"shopPeople"];
    [md setValue:txtTel.text forKey:@"shopTel"];
    [md setValue:txtAddress.text forKey:@"shopAddress"];
    [md setValue:[[adress objectAtIndex:0] objectForKey:@"areaId"]  forKey:@"shopProvince"];
    [md setValue:[[adress objectAtIndex:1] objectForKey:@"areaId"] forKey:@"shopCity"];
    [md setValue:[[adress objectAtIndex:2] objectForKey:@"areaId"] forKey:@"shopArea"];
    [md setValue:txtIntroduce.text forKey:@"shopIntroduce"];
    
    //加入图片文件流
    NSMutableArray *fileData=[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableDictionary *fileDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [fileDic setObject:@"shop.png" forKey:@"fileName"];
    [fileDic setObject:@"image/png" forKey:@"type"];
    [fileDic setObject:@"shopLogUrl" forKey:@"name"];
    [fileDic setObject:UIImagePNGRepresentation(imageViewBack.imageView.image) forKey:@"data"];
    [fileData addObject:fileDic];

    [YunMeiHttpUtils httpRequest:url  pm:md data:fileData withBlock:^(NSDictionary *dict) {
        if([dict objectForKey:@"state"]==1)
        {
        SendAdViewController *controller=[[SendAdViewController alloc]initWithNibName:@"SendAdViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            [self showtips:[dict objectForKey:@"message"]];
        }
    }];
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
    imageViewBack.imageView.image=image;
    [imageViewBack setBackgroundImage: image forState:UIControlStateNormal];

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
