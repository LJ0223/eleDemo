//
//  TableClassVC.m
//  eleDemo
//
//  Created by 罗金 on 16/3/9.
//  Copyright © 2016年 罗金. All rights reserved.
//

#import "TableClassVC.h"
#import "ClassCell.h"
#import "ClassView.h"

#define BOUNDS [[UIScreen mainScreen] bounds]

@interface TableClassVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *eleTable;
@property (nonatomic, strong) ClassView *classView;
@property (nonatomic, assign) NSIndexPath *lastIndexPath;
@property (nonatomic, strong) NSMutableArray *sourceData;

@end

@implementation TableClassVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0] ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"eleDemo";
    
    [self sourceData];
    [self eleTable];
    [self classView];
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
        _classView.indexArray = _sourceData[indexPath.row];
        
        // 将上一个选中的cell的背景色变为未选中状态
        ClassCell *lastCell = (ClassCell *)[tableView cellForRowAtIndexPath:self.lastIndexPath];
        lastCell.backgroundColor = [UIColor whiteColor];
        
        // 改变选中cell的背景色为选中状态
        ClassCell *cell = (ClassCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor cyanColor];
        
        self.lastIndexPath = indexPath;
    }
}

#pragma mark - LayoutUI
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

#pragma mark 自定义视图，此处自定义的是TableView，也可以自定义其他视图
- (ClassView *)classView
{
    if (!_classView) {
        _classView = [[ClassView alloc]initWithFrame:CGRectMake(_eleTable.frame.size.width, 64,  BOUNDS.size.width-_eleTable.frame.size.width, BOUNDS.size.height-64)];
        _classView.indexArray = _sourceData[0];
        _classView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_classView];
    }
    return _classView;
}

#pragma mark - 数据源，模拟数据
- (NSMutableArray *)sourceData
{
    if (!_sourceData) {
        self.sourceData = [[NSMutableArray alloc] init];
        
        NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:@"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", nil];
        [_sourceData addObject:arr1];
        
        NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:@"千军万马🐴", @"千军万马🐴🐴", @"千军万马🐴🐴🐴", @"千军万马🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴🐴", nil];
        [_sourceData addObject:arr2];
        
        NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:@"猴赛雷🐵", @"猴赛雷🐵🐵", @"猴赛雷🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵",nil];
        [_sourceData addObject:arr3];
        
        NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:@"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", @"小明👦", nil];
        [_sourceData addObject:arr4];
        
        NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:@"千军万马🐴", @"千军万马🐴🐴", @"千军万马🐴🐴🐴", @"千军万马🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴", @"千军万马🐴🐴", @"千军万马🐴🐴🐴", @"千军万马🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴", @"千军万马🐴🐴", @"千军万马🐴🐴🐴", @"千军万马🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴", @"千军万马🐴🐴", @"千军万马🐴🐴🐴", @"千军万马🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴", @"千军万马🐴🐴", @"千军万马🐴🐴🐴", @"千军万马🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴", @"千军万马🐴🐴🐴🐴🐴🐴🐴🐴🐴", nil];
        [_sourceData addObject:arr5];
        
        NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:@"猴赛雷🐵", @"猴赛雷🐵🐵", @"猴赛雷🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵", @"猴赛雷🐵🐵", @"猴赛雷🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵", @"猴赛雷🐵🐵", @"猴赛雷🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵", @"猴赛雷🐵🐵", @"猴赛雷🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵", @"猴赛雷🐵🐵", @"猴赛雷🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵", @"猴赛雷🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵🐵",nil];
        [_sourceData addObject:arr6];
    }
    return _sourceData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
