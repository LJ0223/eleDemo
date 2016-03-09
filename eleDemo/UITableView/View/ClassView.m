//
//  ClassView.m
//  eleDemo
//
//  Created by 罗金 on 16/3/9.
//  Copyright © 2016年 罗金. All rights reserved.
//

#import "ClassView.h"

@interface ClassView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *classTable;

@end

@implementation ClassView

@synthesize indexArray = _indexArray;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self classTable];
    }
    return self;
}

#pragma mark - tableView Delegate && DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _indexArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Identyfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _indexArray[indexPath.row]];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell显示内容：%@", _indexArray[indexPath.row]);
}

#pragma mark- getter && setter 方法，可在这两个方法中做文章，在给某个属性复制的同时改变页面布局，此处是给属性indexArray赋值是刷新tableView的数据源，也可以做其他的操作

- (NSMutableArray *)indexArray
{
    return _indexArray;
}

- (void)setIndexArray:(NSMutableArray *)indexArray
{
    _indexArray = [NSMutableArray arrayWithArray:indexArray];
    
    // 刷新classTable的数据源
    [self.classTable reloadData];
}

#pragma mark- LayoutUI
- (UITableView *)classTable
{
    if (!_classTable) {
        _classTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _classTable.delegate = self;
        _classTable.dataSource = self;
        _classTable.tableFooterView = [[UIView alloc] init];
        _classTable.backgroundColor = [UIColor clearColor];
        _classTable.separatorStyle = NO;
        [self addSubview:_classTable];
    }
    return _classTable;
}

@end
