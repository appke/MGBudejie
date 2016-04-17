
#import <UIKit/UIkit.h>

/** 精华-顶部标题的高度 */
CGFloat const MGTitlesViewH = 35;
/** 精华-顶部标题的Y值 */
CGFloat const MGTitlesViewY = 64;

/** 精华-cell-间距 */
CGFloat const MGTopicCellMargin = 10;
/** 精华-cell-文字内容的Y值 */
CGFloat const MGTopicCellTextY = 55;
/** 精华-cell-底部工具条 */
CGFloat const MGTopicCellBottomBarH = 35;

/** 精华-cell-图片帖子显示的最大高度 */
CGFloat const MGTopicCellPictureMaxH = 1000;
/** 精华-cell-图片帖子超过最大高度,就使用Break */
CGFloat const MGTopicCellPictureBreakH = 250;

/** MGUser模型-性别属性值 */
NSString *const MGUserSexMale = @"m";
NSString *const MGUserSexFemale = @"f";

/** 精华-cell-"最热评论"标题的高度 */
CGFloat const MGTopicCellTopCmtTitleH = 20;

/** tabBar被选中的通知名称 */
NSString *const MGTabBarDidSelectNotification = @"MGTabBarDidSelectNotification";
/** tabBar被选中的通知 - 被选中控制器的索引 */
NSString *const MGSelectedControllerIndexKey = @"MGSelectedControllerIndexKey";
/** tabBar被选中的通知名称 - 被选中控制器 */
NSString *const MGSelectedControllerKey = @"MGSelectedControllerKey";

/** 标签-间距 */
CGFloat const MGTagMargin = 5;