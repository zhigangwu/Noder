//
//  NewPageTableViewController.m
//  Noder
//
//  Created by Mac on 2017/8/31.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "NewPageTableViewController.h"
#import "Masonry.h"
#import "QRCodeViewController.h"
#import "AssesstokenAPI.h"
#import "NewpageAPI.h"
#import "PlateSelectionViewController.h"
#import "UIColor+TitleColor.h"
#import "UIFont+SetFont.h"

#import "ControllerManager.h"
#import "NewPageView.h"


@interface NewPageTableViewController ()

@property (nonatomic, strong) NewPageView *newview;

@end

@implementation NewPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(cancel:)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor textColor]];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"PingFangSC-Regular" size:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"发布"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(reless:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor textColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"PingFangSC-Regular" size:15],NSFontAttributeName, nil] forState:UIControlStateNormal];

    self.navigationController.navigationBar.translucent = NO; //半透明
    self.navigationItem.title = @"发布帖子";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
    self.array = [NSArray arrayWithObjects:@"ask",@"share",@"job",@"dev", nil];
    
    self.newview = [[NewPageView alloc] init];
    [self.view addSubview:self.newview];
    [self.newview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.newview.TitleView.delegate = self;
    self.newview.ContentView.delegate = self;
    [self.newview.choseButton addTarget:self action:@selector(plateSelection:) forControlEvents:UIControlEventTouchUpInside];
    
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    
    [topView setItems:buttonsArray];
    [self.newview.ContentView setInputAccessoryView:topView];
    [self.newview.TitleView  setInputAccessoryView:topView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(share:)
                                                 name:@"share"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ask:)
                                                 name:@"ask"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(job:)
                                                 name:@"job"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dev:)
                                                 name:@"dev"
                                               object:nil];
}

- (void)share:(NSNotification *)notification
{
    self.newview.choseLabel.text = @"share";
    self.newview.choseLabel.hidden = YES;
    self.newview.pickLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.newview.pickLabel.textColor = [UIColor textColor];
    self.newview.pickLabel.text = notification.object;
    self.newview.pickLabel.text = @"分享";
}

- (void)ask:(NSNotification *)notification
{
    self.newview.choseLabel.text = @"ask";
    self.newview.choseLabel.hidden = YES;
    self.newview.pickLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.newview.pickLabel.textColor = [UIColor textColor];
    self.newview.pickLabel.text = notification.object;
    self.newview.pickLabel.text = @"问答";
}

- (void)job:(NSNotification *)notification
{
    self.newview.choseLabel.text = @"job";
    self.newview.choseLabel.hidden = YES;
    self.newview.pickLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.newview.pickLabel.textColor = [UIColor textColor];
    self.newview.pickLabel.text = notification.object;
    self.newview.pickLabel.text = @"招聘";
}

- (void)dev:(NSNotification *)notification
{
    self.newview.choseLabel.text = @"dev";
    self.newview.choseLabel.hidden = YES;
    self.newview.pickLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.newview.pickLabel.textColor = [UIColor textColor];
    self.newview.pickLabel.text = notification.object;
    self.newview.pickLabel.text = @"测试";
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void) dismissKeyBoard{
    [self.newview.ContentView resignFirstResponder];
    [self.newview.TitleView resignFirstResponder];
}

- (void)plateSelection:(UIButton *)sender
{
    PlateSelectionViewController *plateSelection = [[PlateSelectionViewController alloc] init];
    self.definesPresentationContext = YES;
    plateSelection.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:plateSelection animated:YES completion:nil];
}

- (void)cancel:(UIButton *)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.newview.TitleView.text isEqualToString:@"输入标题"] ) {
        self.newview.TitleView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
        self.newview.TitleView.textColor = [UIColor textColor];
        self.newview.TitleView.text = @"";
    } else if ([self.newview.ContentView.text isEqualToString:@"输入内容"]){
        self.newview.ContentView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.newview.ContentView.textColor = [UIColor textColor];
        self.newview.ContentView.text = @"";
    }
}

// 发布
- (void)reless:(id)sender
{
    NewpageAPI *newAPI = [[NewpageAPI alloc] init];
    
    if ([ControllerManager shareManager].string != nil) {
        if ((self.newview.TitleView.text.length) && (self.newview.ContentView.text.length) >= 5){
            newAPI.requestArgument = @{@"accesstoken": [ControllerManager shareManager].string,
                                       @"title": self.newview.TitleView.text,
                                       @"tab": self.newview.choseLabel.text,
                                       @"content": self.newview.ContentView.text};
            
            NSLog(@"newAPI.requestArgument = %@", newAPI.requestArgument);
            
            [newAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
                NSDictionary *dictionary = request.responseJSONObject;
                NSLog(@"dictionary = %@", dictionary);
                [self dismissViewControllerAnimated:YES completion:nil];
            } failure:NULL];
        }
    }                 else {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请登入"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil, nil];
        [alertview show];
    }

}




@end
