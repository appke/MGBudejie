//
//  MGAddTagToolbarView.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/16.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGAddTagToolbarView.h"

@interface MGAddTagToolbarView ()
/** 顶部view */
@property (weak, nonatomic) IBOutlet UIView *topView;


@end

@implementation MGAddTagToolbarView

- (void)awakeFromNib
{
    // 添加一个按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    
    
    
    [self.topView addSubview:addButton];
}

@end
