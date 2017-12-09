//
//  PlateSelectionViewController.m
//  Noder
//
//  Created by Mac on 2017/9/27.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "PlateSelectionViewController.h"
#import "PlateSelectionCell.h"
#import "Masonry.h"
#import "PlateSelectionView.h"

@interface PlateSelectionViewController ()

@property (nonatomic, strong) PlateSelectionView *selectionView;

@end

@implementation PlateSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4/1.0];
    self.selectionView = [[PlateSelectionView alloc] init];
    [self.view addSubview:self.selectionView];
    [self.selectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];

    if ([self.selectionView.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        self.selectionView.tableview.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.selectionView.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        self.selectionView.tableview.layoutMargins = UIEdgeInsetsZero;
    }
    
    self.selectionView.tableview.separatorColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4/1.0];
    self.selectionView.tableview.bounces = NO;
    self.selectionView.tableview.delegate = self;
    self.selectionView.tableview.dataSource = self;
    [self.selectionView.tableview registerClass:[PlateSelectionCell class] forCellReuseIdentifier:@"cell"];

    [self.selectionView.cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)cancel:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlateSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.label.font = [UIFont fontWithName:@".AppleSystemUIFont" size:13];
        cell.label.textColor = [UIColor colorWithRed:143/255.0 green:142/255.0 blue:148/255.0 alpha:1/1.0];
        cell.label.text = @"选择板块";
    }
    if (indexPath.row == 1){
        cell.label.text = @"分享";
    }
    if (indexPath.row == 2){
        cell.label.text = @"问答";
    }
    if (indexPath.row == 3){
        cell.label.text = @"招聘";
    }
    if (indexPath.row == 4){
        cell.label.text = @"客户端测试";
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 46;
    }
    if (indexPath.row == 1){
        return 58;
    }
    if (indexPath.row == 2){
        return 58;
    }
    if (indexPath.row == 3){
        return 58;
    }
    if (indexPath.row == 4){
        return 58;
    }
    return indexPath.row;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlateSelectionCell *cell = [[PlateSelectionCell alloc] init];
    
        if (indexPath.row == 1) {

            [[NSNotificationCenter defaultCenter] postNotificationName:@"share" object:cell.label.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        if (indexPath.row == 2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ask" object:cell.label.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        if (indexPath.row == 3) {

            [[NSNotificationCenter defaultCenter] postNotificationName:@"job" object:cell.label.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        if (indexPath.row == 4) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dev" object:cell.label.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 圆角弧度半径
    CGFloat cornerRadius = 6.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = UIColor.clearColor;
//    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4/1.0];

    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 10, 0);

    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标

    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行

    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    if (indexPath.row == 0) {
        // 初始起点为cell的左下角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));

    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        // 初始起点为cell的左上角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        // 添加cell的rectangle信息到path中（不包括圆角）
        CGPathAddRect(pathRef, nil, bounds);
    }
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;

    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
//    roundView.backgroundColor = UIColor.clearColor;
    roundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4/1.0];
    // cell的背景view
    cell.backgroundView = roundView;

    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
//    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
//    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
//    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
//    selectedBackgroundView.backgroundColor = UIColor.clearColor;
//    cell.selectedBackgroundView = selectedBackgroundView;

}



@end
