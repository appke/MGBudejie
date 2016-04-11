//
//  MGRecommendCategoryCell.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGRecommendCategoryCell.h"
#import "MGRecommendCategory.h"
@interface MGRecommendCategoryCell ()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation MGRecommendCategoryCell

- (void)awakeFromNib {
    // Initialization code
    
    // 选中时的背景色，为文字的颜色
    self.backgroundColor = MGRGBColor(244, 244, 244);
    
    self.selectedIndicator.backgroundColor = MGRGBColor(219, 21, 26);
//    self.textLabel.textColor = MGRGBColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = MGRGBColor(219, 21, 26);
    
//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bg;

}


- (void)setCategory:(MGRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

/**
 *  监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ?self.selectedIndicator.backgroundColor : MGRGBColor(78, 78, 78);
}

@end
