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

@interface DetailViewController ()

@property (nonatomic, strong) LCHtmlNode *htmlNode;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *commentButton = [[UIButton alloc] init];
    commentButton.frame = CGRectMake(0, 0, 40, 40);
    [self.view addSubview:commentButton];
    [commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:commentButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    DetailApi *api = [[DetailApi alloc] init];
    api._id = self.detailId;
    
    comContentAPI *contentAPI = [[comContentAPI alloc] init];
    contentAPI.topic_id = self.detailId;
    
    [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
        self.dic = request.responseJSONObject;
        NSArray *arrayData = self.dic[@"data"];
        
        _reply_count = [arrayData valueForKey:@"reply_count"];
        
        NSArray *arrayReply = [arrayData valueForKey:@"replies"];
        _ZGreply_id = [arrayReply valueForKey:@"reply_id"];
        ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
        thumAPI.reply_id = _ZGreply_id;
        
        NSString *content = [[request.responseJSONObject objectForKey:@"data"] objectForKey:@"content"];
        HTMLDocument *document = [HTMLDocument documentWithString:content];
        HTMLElement *body = document.body;
        HTMLElement *div = (HTMLElement *)body.firstChild;
        
        LCHtmlNode *htmlNode = [[LCHtmlNode alloc] initWithNodes:div.childNodes];
        htmlNode.frame = self.view.bounds;
        [self.view addSubnode:htmlNode];
        self.htmlNode = htmlNode;
        
    } failure:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)comment
{
    if (self.reply_count.integerValue == 0) {
        ComContentViewContrnt *com = [[ComContentViewContrnt alloc] init];
        [self.navigationController pushViewController:com animated:YES];
        
    }else {
        CommentPageViewController *comment = [[CommentPageViewController alloc] init];
        comment.dictionary = self.dic;
        comment.topic_id = self.detailId;
        [self.navigationController pushViewController:comment animated:YES];
    }

}



@end
