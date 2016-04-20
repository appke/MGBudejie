//
//  MGSettingViewController.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/20.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGSettingViewController.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

@interface MGSettingViewController ()

@end

@implementation MGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.view.backgroundColor = MGGlobalBg;
    
    // 图片缓存
    NSUInteger cacheSize = [SDImageCache sharedImageCache].getSize;
//    MGLog(@"%zd, %@", cacheSize, NSTemporaryDirectory());
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    [fileManager contentsOfDirectoryAtPath:diskCachePath error:nil];
//    [fileManager subpathsAtPath:diskCachePath];
}

- (NSUInteger)getCacheSize
{
    // 获取SDWebImage缓存路径,diskCachePath是它的私有属性
    NSString *diskCachePath = [[SDImageCache sharedImageCache] valueForKey:@"_diskCachePath"];
    // 存储图片的文件夹名称
//    NSString *diskCachePathComponent = [diskCachePath lastPathComponent];
//    MGLog(@"%@", diskCachePathComponent);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSUInteger size = 0;
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:diskCachePath];
    
    for (NSString *fileName in fileEnumerator) {
        
        NSString *filePath = [diskCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        
        if ([[attrs fileType] isEqualToString:@"NSFileTypeDirectory"]) continue;
        
        [attrs fileSize];
        size += [attrs[NSFileSize] integerValue];
    }
    return size;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    CGFloat size = [self getCacheSize] / 1000.0 / 1000.0;
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(已使用%.2fMB)", size];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [[NSFileManager defaultManager] removeItemAtPath:diskCachePath error:nil];}|
    [[SDImageCache sharedImageCache] clearDisk];
    
    [SVProgressHUD showWithStatus:@"正在清除缓存" maskType:SVProgressHUDMaskTypeBlack];
}

@end
