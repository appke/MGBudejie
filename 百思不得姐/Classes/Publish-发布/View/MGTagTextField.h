//
//  MGTagTextField.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTagTextField : UITextField
/** 按了删除键后的回调,没有返回值,也没有参数 */
@property (nonatomic, copy) void (^deleteBlock)(void);
@end
