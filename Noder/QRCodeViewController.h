//
//  QRCodeViewController.h
//  Noder
//
//  Created by Mac on 2017/6/21.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SGQRCodeScanManager.h"
#import "SGQRCodeAlbumManager.h"


@interface QRCodeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) NSString *stringValue;

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)myAlbum;

@end
