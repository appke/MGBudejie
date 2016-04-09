//
//  MGCommentCell.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/10.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGComment;
@interface MGCommentCell : UITableViewCell

/** 数据模型 */
@property (nonatomic, strong) MGComment *comment;
@end
