//
//  MGAddTagToolbarView.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/16.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGAddTagToolbarView.h"
#import "MGAddTagViewController.h"

@interface MGAddTagToolbarView ()
/** 顶部view */
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 标签数组 */
@property (nonatomic, strong) NSMutableArray *tagLabels;

/** 最后-添加按钮 */
@property (nonatomic, weak) UIButton *addButton;
@end

@implementation MGAddTagToolbarView

- (NSMutableArray *)tagLabels {
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib {
    // 添加一个按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = MGTopicCellMargin;

    [self.topView addSubview:addButton];
    _addButton = addButton;

    // 默认标签
    //    [self createTags:@[@"吐槽吐槽吐槽吐槽", @"糗事吐槽吐槽吐槽吐槽", @"搞笑吐槽吐槽"]];
    [self createTags:@[@"吐槽", @"糗事"]];
}

#pragma mark - push到添加标签控制器
- (void)addButtonClick {
    MGAddTagViewController *addTagVc = [[MGAddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [addTagVc setTagsBlock:^(NSArray *tags) {

        [weakSelf createTags:tags];
    }];
    addTagVc.tags = [self.tagLabels valueForKeyPath:@"text"];

    UITabBarController *root = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //    UINavigationController *nav = (UINavigationController *)[root selectedViewController];
    //    UIViewController *topVc = nav.topViewController;
    UINavigationController *postNav = (UINavigationController *)root.presentedViewController;

    [postNav pushViewController:addTagVc animated:YES];

    //    MGLog(@"%@\n%@\n%@", root, nav, topVc);
}

- (void)layoutSubviews {
    [super layoutSubviews];

    for (int i = 0; i < self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        // 排布label
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签按钮
            UILabel *lastTagLabel = self.tagLabels[i - 1];

            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + MGTagMargin;
            // 计算当前行右边的宽度(剩余的宽度)
            CGFloat rightWidth = self.topView.width - leftWidth;

            // 宽度够不够我用
            if (rightWidth >= tagLabel.width) {
                tagLabel.x = leftWidth;
                tagLabel.y = lastTagLabel.y;

            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + MGTagMargin;
            }
        }
    }

    // 拿到最后一个标签
    UILabel *lastLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + MGTagMargin;
    // 更新addButton的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.x = leftWidth;
        self.addButton.y = lastLabel.y;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY([lastLabel frame]) + MGTagMargin;
    }

    // 更新工具条的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 40;
    self.y += oldH - self.height;
}

#pragma mark - 创建标签
- (void)createTags:(NSArray *)tags {
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];

    for (int i = 0; i < tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.text = tags[i];

        tagLabel.font = MGTagFont;
        tagLabel.backgroundColor = MGTagBg;
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.textAlignment = NSTextAlignmentCenter;

        [tagLabel sizeToFit];
        tagLabel.width += 2 * MGTagMargin;
        tagLabel.height = MGTagH;

        [self.tagLabels addObject:tagLabel];
        [self.topView addSubview:tagLabel];
    }

    // 重新布局子控件
    [self setNeedsLayout];
}

@end
