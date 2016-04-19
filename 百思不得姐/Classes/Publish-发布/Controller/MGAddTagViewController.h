//
//  MGAddTagViewController.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/17.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGAddTagViewController : UIViewController
/** 获取tags的block */
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);
/** 所有标签 */
@property (nonatomic, strong) NSArray *tags;
@end
