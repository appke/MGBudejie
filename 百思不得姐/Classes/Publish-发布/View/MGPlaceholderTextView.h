//
//  MGPlaceholderTextView.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/15.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
