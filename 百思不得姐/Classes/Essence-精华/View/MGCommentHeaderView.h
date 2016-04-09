//
//  MGTableViewHeaderFooterView.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/10.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGTopic;

@interface MGCommentHeaderView : UITableViewHeaderFooterView

/** 组头部显示文字 */
@property (nonatomic, strong) NSString *title;

/** 快速返回一个headerView */
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
