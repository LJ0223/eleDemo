//
//  ViewController.m
//  eleDemo
//
//  Created by 罗金 on 15/9/19.
//  Copyright (c) 2015年 罗金. All rights reserved.
//

#import "ViewController.h"
#import "ClassCell.h"

#define BOUNDS [[UIScreen mainScreen] bounds]

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) UITableView *eleTable;
@property (nonatomic, strong) UIImageView *showImage;
@property (nonatomic, assign) NSIndexPath *lastIndexPath;
@property (nonatomic, strong) UIWebView *myWeb;
@property (nonatomic, strong) NSMutableArray *sourceData;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        self.lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0] ;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"eleDemo";
    
    [self sourceData];
    [self eleTable];
    [self setupWebView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceData.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"class"];
    
    cell.titleLable.text = [NSString stringWithFormat:@"分类%ld", indexPath.row+1];
    // 默认第一个cell是选中状态
    if (indexPath == self.lastIndexPath) {
        cell.backgroundColor = [UIColor cyanColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 改变右侧展示布局
    //    [self changeShowImageWithIndex:indexPath.row];
    [self changeWebViewWithIndex:indexPath.row];
    
    if (indexPath != self.lastIndexPath) {
        // 将上一个选中的cell的背景色变为未选中状态
        ClassCell *lastCell = (ClassCell *)[tableView cellForRowAtIndexPath:self.lastIndexPath];
        lastCell.backgroundColor = [UIColor whiteColor];
        
        // 改变选中cell的背景色为选中状态
        ClassCell *cell = (ClassCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor cyanColor];
        
        self.lastIndexPath = indexPath;
    }
}

// 改变cell右侧显示WebView布局
- (void)changeWebViewWithIndex:(NSInteger)index
{
    NSString *urlStr = [[_sourceData objectAtIndex:index] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_myWeb loadRequest:request];
}

// 改变cell右侧显示图片图片
- (void)changeShowImageWithIndex:(NSInteger)index
{
    _showImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", index]];
}

//cell的分割线通栏
-(void)viewDidLayoutSubviews {
    
    if ([_eleTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [_eleTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_eleTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [_eleTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableView *)eleTable
{
    if (!_eleTable) {
        self.eleTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, BOUNDS.size.height) style:UITableViewStylePlain];
        _eleTable.dataSource = self;
        _eleTable.delegate = self;
        _eleTable.showsVerticalScrollIndicator = FALSE;
        [_eleTable registerClass:[ClassCell class] forCellReuseIdentifier:@"class"];
        [self.view addSubview:_eleTable];
    }
    return _eleTable;
}

- (NSMutableArray *)sourceData
{
    if (!_sourceData) {
        self.sourceData = [NSMutableArray array];
        [_sourceData addObject:@"http://huaban.com/pins/506077162/"];
        [_sourceData addObject:@"http://huaban.com/pins/506076282/"];
        [_sourceData addObject:@"http://huaban.com/pins/506074911/"];
        [_sourceData addObject:@"http://huaban.com/pins/506074519/"];
        [_sourceData addObject:@"http://huaban.com/pins/506073129/"];
        [_sourceData addObject:@"http://huaban.com/pins/404104812/"];
        [_sourceData addObject:@"http://huaban.com/pins/503482014/"];
        [_sourceData addObject:@"http://huaban.com/pins/411953278/"];
        [_sourceData addObject:@"http://huaban.com/pins/502591644/"];
        [_sourceData addObject:@"http://huaban.com/pins/500634090/"];
        [_sourceData addObject:@"http://huaban.com/pins/492370666/"];
        [_sourceData addObject:@"http://huaban.com/pins/492328209/"];
        [_sourceData addObject:@"http://huaban.com/pins/492327869/"];
        [_sourceData addObject:@"http://huaban.com/pins/406038046/"];
        [_sourceData addObject:@"http://huaban.com/pins/492327660/"];
        [_sourceData addObject:@"http://huaban.com/pins/492325652/"];
        [_sourceData addObject:@"http://huaban.com/pins/504787659/"];
        [_sourceData addObject:@"http://huaban.com/pins/504786047/"];
        [_sourceData addObject:@"http://huaban.com/pins/498375414/"];
        [_sourceData addObject:@"http://huaban.com/pins/489168104/"];
    }
    return _sourceData;
}

- (UIWebView *)setupWebView
{
    if (!_myWeb) {
        _myWeb = [[UIWebView alloc]initWithFrame:CGRectMake(_eleTable.frame.size.width+10, BOUNDS.origin.y+10,  BOUNDS.size.width-_eleTable.frame.size.width-20, BOUNDS.size.height-20)];
        _myWeb.delegate = self;
        _myWeb.backgroundColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1.0];
        NSString *urlStr = [[_sourceData objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_myWeb loadRequest:request];
        [self.view addSubview:_myWeb];
    }
    return _myWeb;
}

- (UIImageView *)showImage
{
    if (!_showImage) {
        self.showImage = [[UIImageView alloc] initWithFrame:CGRectMake(_eleTable.frame.size.width+5, 74, BOUNDS.size.width-_eleTable.frame.size.width-10, BOUNDS.size.height-84)];
        [self.view addSubview:_showImage];
        _showImage.image = [UIImage imageNamed:@"0.jpg"];
    }
    return _showImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
