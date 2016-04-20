//
//  MGShowPictureViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/25.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGShowPictureViewController.h"
#import "MGTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "MGProgressView.h"

@interface MGShowPictureViewController ()
/** 显示的图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 放在可滚动的scrollView中 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MGProgressView *progressView;

@end

@implementation MGShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    // 点击图片 返回
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 显示宽度 xx
    // 图片宽度 图片高度
     
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    // 图片显示高度超过 一个屏幕 需要滚动显示
    if (pictureH > screenH) { // 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
//    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    // 马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    
    // 下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        [self.progressView setProgress:1.0*receivedSize/expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
    }];
}


#pragma mark - 保存图片
- (IBAction)save {

    // 没下载完
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没下载完!"];
        return;
    }
    
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showSuccessWithStatus:@"图片保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功!"];
    }
    
}
- (void)saveSuccess
{
    [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 返回 IBAction就是void
- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
