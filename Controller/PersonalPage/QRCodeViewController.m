//
//  QRCodeViewController.m
//  Noder
//
//  Created by Mac on 2017/6/21.
//  Copyright © 2017年 Apress. All rights reserved.
//

// 真机测试打印
//#ifdef DEBUG
//#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#else
//#define NSLog(format, ...)
//#endif

#import "QRCodeViewController.h"
#import "Masonry.h"
#import "CoreImage/CoreImage.h"
#import "HomePageController.h"
#import "AssesstokenAPI.h"
#import "NETWorkRequest.h"
#import "NETWorkConnection.h"
#import "ControllerManager.h"
#import "UIFont+SetFont.h"

#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
#define widthRate DeviceMaxWidth/320

#define contentTitleColorStr @"666666" //正文颜色较深

@interface QRCodeViewController ()

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIImagePickerController *imagePicker;


@end

@implementation QRCodeViewController

- (void)viewDidLoad
{
    self.navigationItem.title = @"二维码/条码";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;

    UIBarButtonItem *navRightButton = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(choicePhoto)];
    self.navigationItem.rightBarButtonItem = navRightButton;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_output setRectOfInterest:CGRectMake(0.35, 0.3, 0.65, 0.7)];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = self.view.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [self.session startRunning];
    [self instanceDevice];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        self.stringValue = [metadataObject stringValue];
        NSLog(@"stringValue = %@",self.stringValue);
        
        [ControllerManager shareManager].string = self.stringValue;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"zongzi" object:self.stringValue];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
//    NSDictionary *dictionary = [ControllerManager shareManager].dictionary;
//    NSString *success = dictionary[@"success"];
//    NSLog(@"success = %@",success);
//    if (success.boolValue == true) {
//        [self.navigationController popViewControllerAnimated:YES];
//        //        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
//                                                                       message:self.stringValue
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    
}

#pragma mark - 从相册识别二维码
- (void)choicePhoto{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImagePNGRepresentation(image);
    CIImage *ciImage = [CIImage imageWithData:imageData];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    NSArray *feature = [detector featuresInImage:ciImage];
    
    for (CIQRCodeFeature *result in feature) {
        self.stringValue = result.messageString;
        [ControllerManager shareManager].string = self.stringValue;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"zongzi" object:self.stringValue];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

     [self.navigationController popViewControllerAnimated:YES];
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

- (AVCaptureDevice *)device
{
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input
{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

- (AVCaptureSession *)session
{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}


- (AVCaptureMetadataOutput *)output
{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc] init];
    }
    return _output;
}

- (void)instanceDevice
{
    UIImage *scanImage = [UIImage imageNamed:@"scanscanBg"];
    UIImageView *scanImageView = [[UIImageView alloc] init];
    scanImageView.backgroundColor = [UIColor clearColor];
    scanImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    scanImageView.layer.borderWidth = 2.5;
    scanImageView.image = scanImage;
    
    CGRect imageRect = CGRectMake(60*widthRate, (DeviceMaxHeight - 200*widthRate)/3, 200*widthRate, 200*widthRate);
    [scanImageView setFrame:imageRect];
    CGRect scanRect = [self getScanCrop:imageRect readerViewBounds:self.view.frame];
    [self.view addSubview:scanImageView];
    self.output.rectOfInterest = scanRect;
    
    [self setOverlayPickerView:self];
}

- (void)setOverlayPickerView:(QRCodeViewController *)reader
{
    CGFloat wid = 60*widthRate;
    CGFloat heih = (DeviceMaxHeight-200*widthRate)/3;
    
    //最上部view
    CGFloat alpha = 0.6;
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, heih)];
    upView.alpha = alpha;
    upView.backgroundColor = [self colorFromHexRGB:contentTitleColorStr];
    [reader.view addSubview:upView];
    
    //左侧的view
    UIView * cLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, heih, wid, 200*widthRate)];
    cLeftView.alpha = alpha;
    cLeftView.backgroundColor = [self colorFromHexRGB:contentTitleColorStr];
    [reader.view addSubview:cLeftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(DeviceMaxWidth-wid, heih, wid, 200*widthRate)];
    rightView.alpha = alpha;
    rightView.backgroundColor = [self colorFromHexRGB:contentTitleColorStr];
    [reader.view addSubview:rightView];
    
    //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, heih+200*widthRate, DeviceMaxWidth, DeviceMaxHeight - heih-200*widthRate)];
    downView.alpha = alpha;
    downView.backgroundColor = [self colorFromHexRGB:contentTitleColorStr];
    [reader.view addSubview:downView];
    
    //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(0, 64+(heih-64-50*widthRate)/2, DeviceMaxWidth, 50*widthRate);
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"请扫描二维码";
    [upView addSubview:labIntroudction];
}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
}

//- (void)loopDrawLine
//{
//    _is_AnmotionFinished = NO;
//    CGRect rect = CGRectMake(60*widthRate, (DeviceMaxHeight-200*widthRate)/3, 200*widthRate, 2);
//    if (self.readLineView) {
//        self.readLineView.alpha = 1;
//        self.readLineView.frame = rect;
//    } else {
//        self.readLineView = [[UIImageView alloc] initWithFrame:rect];
//        [self.readLineView setImage:[UIImage imageNamed:@"scanLine"]];
//        [self.view addSubview:self.readLineView];
//    }
//    
//    [UIView animateWithDuration:1.5 animations:^{
//        self.readLineView.frame = CGRectMake(60*widthRate, (DeviceMaxHeight-200*widthRate)/3+200*widthRate-5, 200*widthRate, 2);
//    } completion:^(BOOL finished){
//        if (!_is_Anmotion) {
//            [self loopDrawLine];
//        }
//        _is_AnmotionFinished = YES;
//    }];
//}

#pragma mark - 颜色
//获取颜色
- (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}




@end
