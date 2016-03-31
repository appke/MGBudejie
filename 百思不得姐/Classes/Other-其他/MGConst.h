
#import <UIKit/UIkit.h>

typedef enum {
    MGTopicTypeAll = 1,
    MGTopicTypePicture = 10,
    MGTopicTypeWord = 29,
    MGTopicTypeVoice = 31,
    MGTopicTypeVideo = 41
    
} MGTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const MGTitlesViewH;
/** 精华-顶部标题的Y值 */
UIKIT_EXTERN CGFloat const MGTitlesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const MGTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const MGTopicCellTextY;
/** 精华-cell-底部工具条 */
UIKIT_EXTERN CGFloat const MGTopicCellBottomBarH;

/** 精华-cell-图片帖子显示的最大高度 */
UIKIT_EXTERN CGFloat const MGTopicCellPictureMaxH;
/** 精华-cell-图片帖子超过最大高度,就使用Break */
UIKIT_EXTERN CGFloat const MGTopicCellPictureBreakH;