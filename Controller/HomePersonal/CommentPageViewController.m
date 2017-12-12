//
//  CommentPageTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "CommentPageViewController.h"
#import "Masonry.h"
#import "ComContentViewContrnt.h"
#import "ControllerManager.h"
#import "PersonalComViewController.h"
#import "MJRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJExtension.h"
#import "comContentAPI.h"
#import "UIColor+tableBackground.h"
#import "DetailApi.h"
#import "UIFont+SetFont.h"

@interface CommentPageViewController ()

@property (nonatomic, assign) float height;

@end

@implementation CommentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
    //去掉返回按钮中的back
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconGrayComment"]
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(comCenterButton:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
//  点击tableview可以收起键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:recognizer];
    
    self.tableview = [[UITableView alloc] init];
    self.bottomView = [[CommentBottomView alloc] init];
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.bottomView];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.tableview.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    
    self.tableview.delegate = self;
    self.tableview.dataSource =self;
    [self.tableview registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"CommentTableViewCell"];
    //  cell自适应高度 注:需要把cell上的控件自上而下加好约束
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 200;
    //    cell分割线全屏
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableview.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableview.layoutMargins = UIEdgeInsetsZero;
    }
    
    self.bottomView.backgroundColor = [UIColor greenColor];
    self.bottomView.contentTextView.delegate = self;
    [self.bottomView.releaseButton addTarget:self action:@selector(reless:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([ControllerManager shareManager].success == false) {
        self.rightButton.hidden = YES;
    }
    
    [self setupRefresh];
    
    DetailApi *detailAPI = [[DetailApi alloc] init];
    detailAPI._id = self.topic_id;
    [detailAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.detailModel = request.responseJSONObject;
        self.array = self.detailModel.replies;
        [self.tableview reloadData];
    } failure:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)setupRefresh
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableview addSubview:refresh];
    
    [refresh beginRefreshing];
    
    [self refreshStateChange:refresh];
}

- (void)refreshStateChange:(UIRefreshControl *)refresh
{
    [self.tableview reloadData];
    [refresh endRefreshing];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableview reloadData];
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



- (void)comcontent
{
    
}

-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
//    NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.bottomView setFrame:CGRectMake(self.bottomView.frame.origin.x, self.bottomView.frame.origin.y+deltaY, self.view.frame.size.width,56)];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    [self.view addSubview:self.bottomView];// 不add无效
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.tableview.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    [UIView commitAnimations];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reless:(UIButton *)sender
{
    
    comContentAPI *comconAPI = [[comContentAPI alloc] init];
    comconAPI.topic_id = [ControllerManager shareManager].reply_ID;

    if ([ControllerManager shareManager].string && [ControllerManager shareManager].reply_ID && self.bottomView.contentTextView.text != nil) {
        comconAPI.requestArgument = @{@"accesstoken" : [ControllerManager shareManager].string,
                                      @"content" : self.bottomView.contentTextView.text,
                                      @"reply_id" : [ControllerManager shareManager].reply_ID,
                                      };
        [comconAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
//            NSDictionary *dictionary = request.responseJSONObject;
            NSLog(@"dictionary 个人 = %@",request.responseJSONObject);
            
            [self.bottomView.contentTextView resignFirstResponder];
            
            DetailApi *detailAPI = [[DetailApi alloc] init];
            detailAPI._id = self.topic_id;
            [detailAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
                self.detailModel = request.responseJSONObject;
                self.array = self.detailModel.replies;
                [self.tableview reloadData];
            } failure:nil];

        } failure:NULL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.LikeupButtonDelegate = self;
    cell.LikedupButtonDelegate = self;
    cell.PersonalCommentDelegate = self;
    cell.floorLabel.text = [NSString stringWithFormat:@"%ld楼",indexPath.row + 1];
    
    self.reply = [self.array objectAtIndex:indexPath.row];
    [cell configWithItem:self.reply];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    return cell;
}

- (void)evaluation:(id)sender
{
    PersonalComViewController *personal = [[PersonalComViewController alloc] init];
    personal.reply_id = self.detailModel.id;
    [self.navigationController pushViewController:personal animated:YES];
}

- (void)likedupButton:(UIButton *)sender
{
    if ([ControllerManager shareManager].success == true) {
        CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
        NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
        self.reply = [self.array objectAtIndex:indexPath.row];

        ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
        thumAPI.reply_id = self.reply.id;
        NSString *access = [ControllerManager shareManager].string;
        if (access != nil) {
            thumAPI.requestArgument = @{@"accesstoken" : access};
            [thumAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
                self.thumbsModel = request.responseJSONObject;
                sender.hidden = YES;
                cell.ZGlikeupButton.hidden = NO;
                [cell.ZGlikeupButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
                [cell.ZGlikeupButton addTarget:self action:@selector(likeupButton:) forControlEvents:UIControlEventTouchUpInside];
            } failure:NULL];
        }
    } else {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请登入"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil, nil];
        [alertview show];
    }
}

- (void)likeupButton:(UIButton *)sender
{
    if ([ControllerManager shareManager].success == true) {
        CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
        NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
        self.reply = [self.array objectAtIndex:indexPath.row];
        
        ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
        thumAPI.reply_id = self.reply.id;
        NSString *access = [ControllerManager shareManager].string;
        if (access != nil) {
            thumAPI.requestArgument = @{@"accesstoken" : access};
            [thumAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
                self.thumbsModel = request.responseJSONObject;
                sender.hidden = YES;
                cell.ZGlikedupButton.hidden = NO;
                [cell.ZGlikedupButton setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
                [cell.ZGlikedupButton addTarget:self action:@selector(likedupButton:) forControlEvents:UIControlEventTouchUpInside];
            } failure:NULL];
        }
    } else {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请登入"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil, nil];
        [alertview show];
    }
}


- (void)personalComButton:(UIButton *)sender
{
    CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    self.reply = [self.array objectAtIndex:indexPath.row];
    [self.bottomView.contentTextView becomeFirstResponder];
    [self.bottomView.contentTextView setText:[NSString stringWithFormat:@"@%@:",self.reply.author.loginname]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableview endEditing:YES];
}

- (void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    CGRect frame = textView.frame;
//    self.height = [self heightForTextView:textView WithText:textView.text];
//    frame.size.height = self.height;
//    [UIView animateWithDuration:0.5 animations:^{
//        textView.frame = frame;
//    } completion:nil];
//    return YES;
//}
//
//// 计算输入文字高度的方法,之所以返回的高度值加22是因为UITextView有一个初始的高度值40，但是输入第一行文字的时候文字高度只有18，所以UITextView的高度会发生变化
//- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
//    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
//    CGRect size = [strText boundingRectWithSize:constraint
//                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}
//                                        context:nil];
//    float textHeight = size.size.height + 22.0;
//    return textHeight;
//}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length] == 0)
    {
        textView.text = @"填写评论…";
        textView.textColor = [UIColor lightGrayColor];
        textView.tag = 0;
    }
}


	
@end
