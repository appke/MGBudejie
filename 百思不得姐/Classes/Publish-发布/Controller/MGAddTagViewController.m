//
//  MGAddTagViewController.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/17.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGAddTagViewController.h"
#import "MGTagButton.h"
#import "MGTagTextField.h"

#import <SVProgressHUD.h>

@interface MGAddTagViewController () <UITextFieldDelegate>
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

#pragma mark - 懒加载
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
        
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.backgroundColor = MGTagBg;
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
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
}

#pragma mark - 懒加载contentView
- (UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

#pragma mark - 懒加载textField
- (UITextField *)textField
{
    if (!_textField) {
        MGTagTextField * textField = [[MGTagTextField alloc] init];
        textField.delegate = self;
        
        __weak typeof(self) weakSelf  = self;
        textField.deleteBlock = ^(){
            if (self.textField.hasText) return;
            [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        };
        
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [textField becomeFirstResponder];
        
        [self.contentView addSubview:textField];
        _textField = textField;
    }
    return _textField;
}


#pragma mark - 初始化
- (void)setupNav
{
    self.title = @"添加标签";
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneItem;
}

- (void)setupTags
{
    if (self.tags.count) {
        for (NSString *tag in self.tags) {
            self.textField.text = tag;
            [self addButtonClick];
        }
        
        self.tags = nil;
    }
}

#pragma mark - 子控件排布
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // contentView的尺寸
    self.contentView.y = 64 + MGTagMargin;
    self.contentView.x = MGTagMargin;
    self.contentView.width = MGScreenW - 2 * self.contentView.x;
    self.contentView.height = MGScreenH;
    
    // textField的尺寸
    self.textField.width = self.contentView.width;
    
    // addButton的尺寸
    self.addButton.width = self.contentView.width;
    self.addButton.height = 30;
    
    [self setupTags];
}

#pragma mark - 返回上一个控制器
- (void)done
{
    // pop之前传递数据给上一个控制器
    NSMutableArray *tags = [self.tagButtons valueForKey:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监听文字改变
- (void)textDidChange
{
    if (self.textField.hasText) { // 有文字
        // 显示"添加标签"的按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + MGTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@", self.textField.text] forState:UIControlStateNormal];
        
        // 获得最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len - 1];
        
        if (([lastLetter isEqualToString:@","]
             || [lastLetter isEqualToString:@"，"]) && len > 1) {
            // 去除逗号
            self.textField.text = [text substringToIndex:len - 1];
            [self addButtonClick];
        }
    } else {
        // 隐藏"添加标签"的按钮
        self.addButton.hidden = YES;
    }
    
    // 更新文本框的frame,输入文字，文本框可换行
    [self updateTextFieldFrame];
}

#pragma mark - 监听按钮点击
- (void)addButtonClick
{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多只能输入5个" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    MGTagButton *tagButton = [[MGTagButton alloc] init];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    
    [self.tagButtons addObject:tagButton];
    [self.contentView addSubview:tagButton];
    
    // 清空textField的文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
    
    // 更新标签按钮的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
}

/**
 *  删除标签
 */
- (void)tagButtonClick:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 搞个动画
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}

#pragma mark - 专门用来更新标签按钮的frame
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
}

- (void)updateTextFieldFrame
{
    // 拿到最后一个按钮
    UIButton *lastButton = [self.tagButtons lastObject];
    
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + MGTagMargin;
    // 更新textFiled的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = lastButton.y;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY([lastButton frame]) + MGTagMargin;
    }
    
    // 更新“添加标签”位置
    self.addButton.y = CGRectGetMaxY(self.textField.frame) + MGTagMargin;
}


/**
 *  返回textView的文字
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    
    // 始终返回一个值过去, 右边的宽度小于40，textFiled就放在下一行
    return MAX(textW, 40);
}


#pragma mark - UITextFieldDelegate
/**
 *  监听按钮右下角点击
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

//- (BOOL)textFieldShouldClear:(UITextField *)textField
//{
//    return YES;
//}

@end
