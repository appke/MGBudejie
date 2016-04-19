//
//  MGTableViewHeaderFooterView.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/10.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGCommentHeaderView.h"
@interface MGCommentHeaderView ()
/** 内部label */
@property (nonatomic, weak) UILabel *label;
@end

@implementation MGCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = MGGlobalBg;
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        _label = label;
        label.textColor = MGRGBColor(67, 67, 67);
        label.font = [UIFont systemFontOfSize:15];
        label.width = 200;
        label.x = MGTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        [self.contentView addSubview:label];
    }
    return self;
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    MGCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) { // 缓存池中没有,自己创建
        header = [[MGCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}
@end
