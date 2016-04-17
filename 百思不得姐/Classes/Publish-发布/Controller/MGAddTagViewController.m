//
//  MGAddTagViewController.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/17.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGAddTagViewController.h"

@interface MGAddTagViewController ()
/** 文本输入框 */
@property (nonatomic, weak) UITextField *textField;
/** 存放标签的容器 */
@property (nonatomic, weak) UIView *contentView;

/** 添加标签的按钮 */
@property (nonatomic, weak) UIButton *addButton;

/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation MGAddTagViewController


- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}


- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [[UIButton alloc] init];
        
        addButton.width = self.contentView.width;
        addButton.height = 30;
        
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.backgroundColor = MGTagBg;
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
//        addButton.titleLabel.backgroundColor = [UIColor magentaColor];
//        addButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        // 让按钮内部的图片和文字左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, MGTagMargin, 0, MGTagMargin);
        [self.contentView addSubview:addButton];
        _addButton = addButton;
        
    }
    return _addButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextFile];
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.y = 64 + MGTagMargin;
    contentView.x = MGTagMargin;
    contentView.width = MGScreenW - 2 * contentView.x;
    // 高度多少关系
    contentView.height = MGScreenH;
//    contentView.backgroundColor = [UIColor magentaColor];
    
    [self.view addSubview:contentView];
    _contentView = contentView;
}

- (void)setupTextFile
{
    UITextField * textField = [[UITextField alloc] init];
    textField.placeholder = @"多个标签用逗号或换行隔开";
    textField.width = MGScreenW;
    textField.height = 25;
//    textField.delegate = self;
    textField.font = [UIFont systemFontOfSize:14];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [textField becomeFirstResponder];
    
    [self.contentView addSubview:textField];
    _textField = textField;
}

- (void)setupNav
{
    self.title = @"添加标签";
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneItem;
}

- (void)done
{
    MGLogFunc;
}

/**
 *  监听文字改变
 */
- (void)textDidChange
{
    if (self.textField.hasText) { // 有文字
        // 显示"添加标签"的按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + MGTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@", self.textField.text] forState:UIControlStateNormal];
        
    } else {
        // 隐藏"添加标签"的按钮
        self.addButton.hidden = YES;
    }
    
    // 输入文字，文本框可换行
    [self updateTagButtonFrame];
}

/**
 *  监听"添加标签"按钮点击
 */
- (void)addButtonClick
{
    UIButton *tagButton = [[UIButton alloc] init];
    tagButton.backgroundColor = MGTagBg;
    tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [tagButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 真强大
    [tagButton sizeToFit];
    [self.tagButtons addObject:tagButton];
    [self.contentView addSubview:tagButton];
    
    // 清空textField的文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
    
    // 更新标签按钮的frame
    [self updateTagButtonFrame];
}

/**
 *  专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    for (int i = 0; i < self.tagButtons.count; i++) {
        
        UIButton *tagButton = self.tagButtons[i];
        if (i == 0) { // 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
            
        } else { // 其他标签按钮
            UIButton *lastTagButton = self.tagButtons[i-1];
            
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + MGTagMargin;
            // 计算当前行右边的宽度(剩余的宽度)
            CGFloat rightWidth = self.contentView.width - leftWidth;
            
            // 宽度够不够我用
            if (rightWidth >= tagButton.width) {
                tagButton.x = leftWidth;
                tagButton.y = lastTagButton.y;
                
            } else { // 按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + MGTagMargin;
            }
        }
    }
    
    // 更新textFiled的frame
//    self.textField.x = 0;
//    self.textField.y = CGRectGetMaxY([[self.tagButtons lastObject] frame]) + MGTagMargin;
    
    // 拿到最后一个按钮
    UIButton *lastButton = [self.tagButtons lastObject];
    
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + MGTagMargin;
    // 更新textFiled的frame
//    if (self.contentView.width - leftWidth >= 100) {
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = lastButton.y;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY([lastButton frame]) + MGTagMargin;
    }
}

- (void)tagButtonClick:(UIButton *)tagButton
{
    
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 搞个动画
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
}

- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    
    // 始终返回一个值过去, 右边的宽度小于40，textFiled就放在下一行
    return MAX(textW, 40);
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    MGLogFunc;
//    return YES;
//}


@end
