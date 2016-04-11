//
//  UIImageView+MGExtension.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/11.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "UIImageView+MGExtension.h"
#import <UIImageView+WebCache.h>


@implementation UIImageView (MGExtension)

- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.image = image ? [image circleImage] : placeholder;
    }];
}
@end
