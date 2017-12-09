//
//  DetailViewController.m
//  Noder
//
//  Created by bawn on 15/06/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailApi.h"
#import "LCHtmlNode.h"
#import <HTMLKit.h>
#import "Masonry.h"
#import "CommentPageViewController.h"
#import "comContentAPI.h"
#import "ThumbsUpAPI.h"
#import "ComContentViewContrnt.h"
#import "ThumbsUpAPI.h"
#import "PersonalComViewController.h"
#import "ControllerManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+TimeAgo.h"
#import "UIFont+SetFont.h"

@interface DetailViewController ()

@property (nonatomic, strong) LCHtmlNode *htmlNode;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"帖子详情";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
    //去掉返回按钮中的back
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    self.topView = [[DetailTopView alloc] init];
    self.bottomView = [[DetailBottomView alloc] init];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(56);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(74);
    }];
    
    self.bottomView.backdelegate = self;
    self.bottomView.commentdelegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    comContentAPI *contentAPI = [[comContentAPI alloc] init];
    contentAPI.topic_id = self.detailId;
    
    DetailApi *api = [[DetailApi alloc] init];
    api._id = self.detailId;
    
    [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
        self.detailModel = request.responseJSONObject;
//        NSLog(@"detailModel = %@",self.detailModel.id);
        [ControllerManager shareManager].reply_ID = self.detailModel.id;
        
        [self.topView.imageview sd_setImageWithURL:self.detailModel.author.avatar_url];
        self.topView.loginnameLabel.text = self.detailModel.author.loginname;
        self.topView.postedLabel.text = self.detailModel.create_at;
        self.topView.watchLabel.text = [NSString stringWithFormat:@"%@",self.detailModel.visit_count];
        self.topView.messageLabel.text = [NSString stringWithFormat:@"%@",self.detailModel.reply_count];
        
        ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
        thumAPI.reply_id = self.replies.reply_id;
        
        NSString *content = self.detailModel.content;
        HTMLDocument *document = [HTMLDocument documentWithString:content];
        HTMLElement *body = document.body;
        HTMLElement *div = (HTMLElement *)body.firstChild;
        
        self.htmlNode = [[LCHtmlNode alloc] initWithNodes:div.childNodes];
        self.htmlNode.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.htmlNode.view];
        [self.htmlNode.view mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.view).with.offset(74);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view).with.offset(-65);
        }];
        [self.view addSubnode:self.htmlNode];
    } failure:NULL];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)backview:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commentButton:(UIButton *)sender
{
    if (self.detailModel.reply_count.boolValue == 0) {
        ComContentViewContrnt *com = [[ComContentViewContrnt alloc] init];
        [self.navigationController pushViewController:com animated:YES];
    }else {
        CommentPageViewController *comment = [[CommentPageViewController alloc] init];
        comment.reply_id = self.replies.id;
        comment.topic_id = self.detailModel.id;
        
        [self.navigationController pushViewController:comment animated:YES];
    }
}

- (void)refreshButton:(UIButton *)sender
{
//    comContentAPI *contentAPI = [[comContentAPI alloc] init];
//    contentAPI.topic_id = self.detailId;
//
//    DetailApi *api = [[DetailApi alloc] init];
//    api._id = self.detailId;
//
//    [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
//        self.detailModel = request.responseJSONObject;
////
////        [self.topView.imageview sd_setImageWithURL:self.detailModel.author.avatar_url];
////        self.topView.loginnameLabel.text = self.detailModel.author.loginname;
////        self.topView.postedLabel.text = self.detailModel.create_at;
////        self.topView.watchLabel.text = [NSString stringWithFormat:@"%@",self.detailModel.visit_count];
////        self.topView.messageLabel.text = [NSString stringWithFormat:@"%@",self.detailModel.reply_count];
//
//        ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
//        thumAPI.reply_id = self.replies.reply_id;
//
//        NSString *content = self.detailModel.content;
//        HTMLDocument *document = [HTMLDocument documentWithString:content];
//        HTMLElement *body = document.body;
//        HTMLElement *div = (HTMLElement *)body.firstChild;
//
//        self.htmlNode = [[LCHtmlNode alloc] initWithNodes:div.childNodes];
//        self.htmlNode.view.backgroundColor = [UIColor whiteColor];
////        [self.view addSubview:self.htmlNode.view];
////        [self.htmlNode.view mas_makeConstraints:^(MASConstraintMaker *make){
////            make.top.equalTo(self.view).with.offset(74);
////            make.left.equalTo(self.view);
////            make.right.equalTo(self.view);
////            make.bottom.equalTo(self.view).with.offset(-65);
////        }];
//        [self.view addSubnode:self.htmlNode];
//
//    } failure:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
