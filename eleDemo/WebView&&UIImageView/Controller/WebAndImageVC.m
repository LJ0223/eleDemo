//
//  WebAndImageVC.m
//  eleDemo
//
//  Created by 罗金 on 16/3/9.
//  Copyright © 2016年 罗金. All rights reserved.
//

#import "WebAndImageVC.h"
#import "ClassCell.h"

#define BOUNDS [[UIScreen mainScreen] bounds]

@interface WebAndImageVC ()<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) UITableView *eleTable;
@property (nonatomic, strong) UIImageView *showImage;
@property (nonatomic, strong) UIWebView *myWeb;
@property (nonatomic, strong) NSMutableArray *sourceData;

@property (nonatomic, assign) NSIndexPath *lastIndexPath; // 标记上一次的选中状态

@end

@implementation WebAndImageVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 初始坐标{0，0}
        self.lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0] ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"侧面菜单栏，右侧是WebView";
    
    [self sourceData];
    [self eleTable];
    [self myWeb];
}

#pragma mark - tableView Delegate && DataSource
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
    
    if (indexPath != self.lastIndexPath) {
        // 改变右侧展示布局
        //    [self changeShowImageWithIndex:indexPath.row];
        [self changeWebViewWithIndex:indexPath.row];
        
        
        // 将上一个选中的cell的背景色变为未选中状态
        ClassCell *lastCell = (ClassCell *)[tableView cellForRowAtIndexPath:self.lastIndexPath];
        lastCell.backgroundColor = [UIColor whiteColor];
        
        // 改变选中cell的背景色为选中状态
        ClassCell *cell = (ClassCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor cyanColor];
        
        self.lastIndexPath = indexPath;
    }
}

// 改变cell右侧显示WebView布局，根据下标取到数据源中的WebView的URL，然后重新赋值并刷新页面
- (void)changeWebViewWithIndex:(NSInteger)index
{
    NSString *urlStr = [[_sourceData objectAtIndex:index] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_myWeb loadRequest:request];
}

// 改变cell右侧显示图片图片，根据下标取到数据源中对应下标的图片，并给右侧的UIImageView赋值该图片
- (void)changeShowImageWithIndex:(NSInteger)index
{
    _showImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", index]];
}

#pragma mark- LayoutUI
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

- (UIWebView *)myWeb
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

#pragma mark - 数据源，模拟数据
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
