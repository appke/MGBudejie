//
//  MGPushGuideView.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/18.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPushGuideView : UIView
/**
 *  直接从类中加载，屏蔽加载过程
 */
+ (instancetype)guideView;
/**
 *  显示推送引导
 */
+ (void)show;
@end
