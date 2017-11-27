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

@interface DetailViewController ()

@property (nonatomic, strong) LCHtmlNode *htmlNode;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                                   target:self
                                                                                   action:@selector(reply)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                                    target:self
                                                                                    action:@selector(comment)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    comContentAPI *contentAPI = [[comContentAPI alloc] init];
    contentAPI.topic_id = self.detailId;
    
    self.view.backgroundColor = [UIColor whiteColor];
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
        
        LCHtmlNode *htmlNode = [[LCHtmlNode alloc] initWithNodes:div.childNodes];
        htmlNode.frame = self.view.bounds;
        [self.view addSubnode:htmlNode];
        self.htmlNode = htmlNode;
        
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reply
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)comment
{
    if (self.detailModel.reply_count.boolValue == 0) {
        ComContentViewContrnt *com = [[ComContentViewContrnt alloc] init];
        [self.navigationController pushViewController:com animated:YES];
    }else {
        CommentPageViewController *comment = [[CommentPageViewController alloc] init];
//        comment.array = self.detailModel.replies;
        comment.reply_id = self.replies.id;
        comment.topic_id = self.detailModel.id;
        [self.navigationController pushViewController:comment animated:YES];
    }

}



@end
