//
//  MGRecommendCategory.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//推荐类别

#import <Foundation/Foundation.h>

@interface MGRecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 总数 */
@property (nonatomic, assign) NSInteger count;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;

/** 当前页码(自定义) */
@property (nonatomic, assign) NSInteger currentPage;
/** 总的用户数 */
@property (nonatomic, assign) NSInteger total;

/** 总数 */
//@property (nonatomic, assign) NSInteger total_page;
/** 下一页 */
//@property (nonatomic, assign) NSInteger next_page;
@end
