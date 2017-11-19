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
#import "UIColor+textColor.h"

#import "ControllerManager.h"


@interface NewPageTableViewController ()

@end

@implementation NewPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pickLabel = [[UILabel alloc] init];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                                target:self
                                                                                action:@selector(cancelandback)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:@selector(reless:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    self.navigationController.navigationBar.translucent = NO; //半透明
    self.navigationItem.title = @"发布帖子";
    
    self.array = [NSArray arrayWithObjects:@"ask",@"share",@"job",@"dev", nil];
    
    self.choseView = [[UIView alloc] init];
    self.choseButton = [[UIButton alloc] init];
    self.choseLabel = [[UILabel alloc] init];
    self.imageview = [[UIImageView alloc] init];
    self.TitleView = [[UITextView alloc] init];
    self.ContentView = [[UITextView alloc] init];
    UIImageView *imageViewA = [[UIImageView alloc] init];
    UIImageView *imageViewB = [[UIImageView alloc] init];
    [self.view addSubview:imageViewA];
    [self.view addSubview:imageViewB];
    [self.view addSubview:self.choseView];
    [self.choseView addSubview:self.choseButton];
    [self.choseView addSubview:self.choseLabel];
    [self.choseView addSubview:self.imageview];
    [self.view addSubview:self.TitleView];
    [self.view addSubview:self.ContentView];
    
    [self.TitleView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view).with.offset(17.5);
        make.right.equalTo(self.view).with.offset(-18.5);
        make.height.mas_equalTo(58);
    }];
    
    [imageViewA mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.TitleView.mas_bottom);
        make.left.equalTo(self.view).with.offset(17.5);
        make.right.equalTo(self.view).with.offset(-18.5);
        make.height.mas_equalTo(3);
    }];
    
    [self.choseView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(imageViewA.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.choseButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.choseView);
        make.left.equalTo(self.choseView);
        make.right.equalTo(self.choseView);
        make.bottom.equalTo(self.choseView);
    }];
    
    [self.choseLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.choseView);
        make.left.equalTo(self.choseView).with.offset(17.5);
        make.right.equalTo(self.imageview.mas_left);
        make.height.mas_equalTo(22);
    }];
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.choseView);
        make.right.equalTo(self.choseView).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(12, 6));
    }];
    
    
    [imageViewB mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.choseView.mas_bottom);
        make.left.equalTo(self.view).with.offset(17.5);
        make.right.equalTo(self.view).with.offset(-18.5);
        make.height.mas_equalTo(3);
    }];
    
    [self.ContentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(imageViewB.mas_bottom);
        make.left.equalTo(self.view).with.offset(17.5);
        make.right.equalTo(self.view).with.offset(-18.5);
        make.bottom.equalTo(self.view);
    }];
    
    [self.TitleView setTextAlignment:NSTextAlignmentLeft];
    self.TitleView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _TitleView.delegate = self;
    self.TitleView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    self.TitleView.textColor = [UIColor titleColor];
    self.TitleView.text = @"输入标题";

    imageViewA.image = [UIImage imageNamed:@"Line"];
    imageViewB.image = [UIImage imageNamed:@"Line"];
    
    self.choseLabel.text = @"选择板块";
    self.choseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.choseLabel.textColor = [UIColor titleColor];
    [self.choseButton addTarget:self action:@selector(plateSelection:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imageview.image = [UIImage imageNamed:@"Rectangle 2"];
    
    self.ContentView.delegate = self;
    self.TitleView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _ContentView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.ContentView.textColor = [UIColor titleColor];
    self.ContentView.text = @"输入内容";
    
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    
    [topView setItems:buttonsArray];
    [self.ContentView setInputAccessoryView:topView];
    [self.TitleView  setInputAccessoryView:topView];
    
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
    self.choseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.choseLabel.textColor = [UIColor textColor];
    self.choseLabel.text = notification.object;
    self.pickLabel.text = @"share";
}

- (void)ask:(NSNotification *)notification
{
    self.choseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.choseLabel.textColor = [UIColor textColor];
    self.choseLabel.text = notification.object;
    self.pickLabel.text = @"ask";
}

- (void)job:(NSNotification *)notification
{
    self.choseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.choseLabel.textColor = [UIColor textColor];
    self.choseLabel.text = notification.object;
    self.pickLabel.text = @"job";
}

- (void)dev:(NSNotification *)notification
{
    self.choseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.choseLabel.textColor = [UIColor textColor];
    self.choseLabel.text = notification.object;
    self.pickLabel.text = @"dev";
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void) dismissKeyBoard{
    [self.ContentView resignFirstResponder];
    [self.TitleView resignFirstResponder];
}

- (void)plateSelection:(UIButton *)sender
{
    PlateSelectionViewController *plateSelection = [[PlateSelectionViewController alloc] init];
    self.definesPresentationContext = YES;
    plateSelection.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    plateSelection.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:plateSelection animated:YES completion:nil];
}

- (void)cancelandback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.TitleView.text isEqualToString:@"输入标题"] ) {
        self.TitleView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
        self.TitleView.textColor = [UIColor textColor];
        self.TitleView.text = @"";
    } else if ([self.ContentView.text isEqualToString:@"输入内容"]){
        self.ContentView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.ContentView.textColor = [UIColor textColor];
        self.ContentView.text = @"";
    }
}

- (void)reless:(id)sender
{
    NSLog(@"%@",sender);
    NSString *accessToken = [ControllerManager shareManager].string;
    NewpageAPI *newAPI = [[NewpageAPI alloc] init];
    
    if (accessToken != nil) {
        if ((self.TitleView.text.length) && (self.ContentView.text.length) >= 5){
            newAPI.requestArgument = @{@"accesstoken": accessToken,
                                       @"title": self.TitleView.text,
                                       @"tab": self.pickLabel.text,
                                       @"content": self.ContentView.text};
            
            
            NSLog(@"newAPI.requestArgument = %@", newAPI.requestArgument);
            
            [newAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
                NSDictionary *dictionary = request.responseJSONObject;
                NSLog(@"dictionary = %@", dictionary);
//                [self.navigationController popViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
            } failure:NULL];
        } else
            NSLog(@"请登入！");
    }
    
}




@end
