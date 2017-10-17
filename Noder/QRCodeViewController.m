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
    UIBarButtonItem *navRightButton = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(choicePhoto)];
    self.navigationItem.rightBarButtonItem = navRightButton;
    self.navigationItem.title = @"二维码/条码";
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
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
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        self.stringValue = [metadataObject stringValue];
        
        [ControllerManager shareManager].string = self.stringValue;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"zongzi" object:self.stringValue];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 从相册识别二维码
- (void)choicePhoto{
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





@end
