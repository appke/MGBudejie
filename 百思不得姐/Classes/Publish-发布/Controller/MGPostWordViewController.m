//
//  MGPostWordViewController.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/14.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGPostWordViewController.h"
#import "MGPlaceholderTextView.h"
#import "MGAddTagToolbarView.h"



@interface MGPostWordViewController () <UITextViewDelegate>
/** 文本输入框 */
@property (nonatomic, weak) MGPlaceholderTextView *textView;

/** 工具条 */
@property (nonatomic, weak) MGAddTagToolbarView *toolbar;

@end

@implementation MGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
}

- (void)setupToolbar
{
    // 添加工具条
    MGAddTagToolbarView *toolbar = [MGAddTagToolbarView viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
//    MGLog(@"--%@", NSStringFromCGRect(toolbar.frame));
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/** 监听键盘的显示和隐藏 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 动画时间
    NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
//    MGLog(@"%f", keyboardF.origin.y - MGScreenH);
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y - MGScreenH);
    }];
}

/**
 *  初始化- 占位文字的textView
 */
- (void)setupTextView
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    MGPlaceholderTextView *textView = [[MGPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
//    textView.placeholderColor = [UIColor redColor];
    textView.backgroundColor = [UIColor yellowColor];
    
    textView.delegate = self;
    
//    textView.inputAccessoryView = [MGAddTagToolbarView viewFromXib];
    
    _textView = textView;
    [self.view addSubview:textView];
}

/**
 *  初始化导航栏
 */
- (void)setupNav
{
    self.title = @"发段子";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 强制刷新
//    [self.navigationController.navigationBar layoutIfNeeded];
    
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    //    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
}


- (void)cancel
{
//    self.textView.placeholderColor = [UIColor blueColor];
//    self.textView.placeholder = @"hahaha";
//    self.textView.font = [UIFont systemFontOfSize:20];
//    self.textView.text = @"代码修改文字不发通知哦";
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    MGLogFunc;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

@end
