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

@interface DetailViewController ()

@property (nonatomic, strong) LCHtmlNode *htmlNode;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bottomView = [[DetailBottomView alloc] init];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(65);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.bottomView.backdelegate = self;
    self.bottomView.commentdelegate = self;
    self.bottomView.comCenterDelegate = self;

    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    comContentAPI *contentAPI = [[comContentAPI alloc] init];
    contentAPI.topic_id = self.detailId;
    
    DetailApi *api = [[DetailApi alloc] init];
    api._id = self.detailId;
    
    [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
        self.detailModel = request.responseJSONObject;
        
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
            make.top.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view).with.offset(-65);
        }];
        [self.view addSubnode:self.htmlNode];
        
    } failure:NULL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addnotification:)
                                                 name:@"replyid"
                                               object:nil];
    
    
}

- (void)addnotification:(NSNotification *)notification
{
    ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
    thumAPI.reply_id = notification.object;
    
    PersonalComViewController *personalCom = [[PersonalComViewController alloc] init];
    personalCom.reply_id = notification.object;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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

- (void)comCenterButton:(UIButton *)sender
{
    if ([ControllerManager shareManager].success == 1) {
        ComContentViewContrnt *comContentVC = [[ComContentViewContrnt alloc] init];
        [self.navigationController pushViewController:comContentVC animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请登入"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
