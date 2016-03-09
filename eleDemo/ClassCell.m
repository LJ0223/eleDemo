//
//  ClassCell.m
//  eleDemo
//
//  Created by 罗金 on 15/9/19.
//  Copyright (c) 2015年 罗金. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
        
        self.selectionStyle = NO;
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _titleLable.textColor = [UIColor orangeColor];
        _titleLable.font = [UIFont systemFontOfSize:11];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLable];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
