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


@interface QRCodeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSString *stringValue;

//@property (nonatomic,copy)UIImageView * readLineView;
//@property (nonatomic,assign)BOOL is_Anmotion;
//@property (nonatomic,assign)BOOL is_AnmotionFinished;
//- (void)loopDrawLine;

@end
