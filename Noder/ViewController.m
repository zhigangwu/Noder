//
//  ViewController.m
//  Noder
//
//  Created by alienware on 2017/2/10.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ViewController.h"
#import "TopicsApi.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AssesstokenAPI.h"
#import "UIFont+SetFont.h"


@interface ViewController () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *mutabledata;
@property (nonatomic, strong) NSURLConnection *conection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
//        NSLog(@"%@", request.responseJSONObject);
        NSDictionary *dic = request.responseJSONObject;
        self.array = dic[@"data"];
        self.imageArray = [dic valueForKeyPath:@"data.author"];

        [self.tableView reloadData];

    } failure:NULL];
    
    [self.tableView registerClass:[HDTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.title = @"主页";

    self.navigationItem.title = @"我的收藏";
    UIFont *font = [UIFont ZGFontA];
    UIColor *color = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0];
    NSDictionary *dic = @{NSFontAttributeName:font,NSForegroundColorAttributeName:color};
    self.navigationController.navigationBar.titleTextAttributes =dic;

    
    
    AssesstokenAPI *api = [[AssesstokenAPI alloc] init];
    api.requestArgument = @{@"accesstoken" : @"2142324324234234"};
    [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
        //            NSLog(request)
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
//        NSLog(@"%@", error);
    }];


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HDTableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    
    [tableViewCell configWithItem:dictionary];

    return tableViewCell;
    
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.7;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
