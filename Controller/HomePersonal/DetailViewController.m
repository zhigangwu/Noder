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
#import "CollectAPI.h"
#import "De_collectAPI.h"

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
    
    self.bottomView.commentdelegate = self;
    [self.bottomView.refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    comContentAPI *contentAPI = [[comContentAPI alloc] init];
    contentAPI.topic_id = self.detailId;
    
    DetailApi *api = [[DetailApi alloc] init];
    api._id = self.detailId;
    
    [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
        self.detailModel = request.responseJSONObject;
        
        CollectionAPI *collectionAPI = [[CollectionAPI alloc] init];
        collectionAPI.loginname = [ControllerManager shareManager].loginname;
        [collectionAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            NSArray *array = request.responseJSONObject;
            NSArray *arrayID = [array valueForKey:@"id"];
 
            if ([arrayID containsObject:self.detailModel.id]) {
                [self.bottomView.brightButton setImage:[UIImage imageNamed:@"Shape Copy"] forState:UIControlStateNormal];
                [self.bottomView.brightButton addTarget:self action:@selector(brightcollectButton:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [self.bottomView.grayButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
                [self.bottomView.grayButton addTarget:self action:@selector(graycollectButton:)
                                     forControlEvents:UIControlEventTouchUpInside];
            }
        }failure:NULL];
        
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

- (void)brightcollectButton:(UIButton *)sender //取消收藏
{
    De_collectAPI *de_collectAPI = [[De_collectAPI alloc] init];
    de_collectAPI.requestArgument = @{@"accesstoken" : [ControllerManager shareManager].string,
                                   @"topic_id" : self.detailModel.id,
                                   };
    if ([ControllerManager shareManager].string != nil) {
        [de_collectAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
//            NSDictionary *dictionary = request.responseJSONObject;
            sender.hidden = YES;
            self.bottomView.grayButton.hidden = NO;
            [self.bottomView.grayButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
            [self.bottomView.grayButton addTarget:self action:@selector(graycollectButton:)
                                 forControlEvents:UIControlEventTouchUpInside];
        } failure:nil];
    }
}

- (void)graycollectButton:(UIButton *)sender // 收藏
{
    CollectAPI *collectAPI = [[CollectAPI alloc] init];
    collectAPI.requestArgument = @{@"accesstoken" : [ControllerManager shareManager].string,
                                   @"topic_id" : self.detailModel.id,
                                   };
    if ([ControllerManager shareManager].string != nil) {
        [collectAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
//            NSDictionary *dictionary = request.responseJSONObject;
            sender.hidden = YES;
            self.bottomView.brightButton.hidden = NO;
            [self.bottomView.brightButton setImage:[UIImage imageNamed:@"Shape Copy"] forState:UIControlStateNormal];
            [self.bottomView.brightButton addTarget:self action:@selector(brightcollectButton:) forControlEvents:UIControlEventTouchUpInside];
        } failure:nil];
    }
}

- (void)commentButton:(UIButton *)sender
{
    CommentPageViewController *comment = [[CommentPageViewController alloc] init];
    comment.reply_id = self.replies.id;
    comment.topic_id = self.detailModel.id;
    [self.navigationController pushViewController:comment animated:YES];
}

- (void)refresh:(UIButton *)sender
{
    [self viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
