//UIView
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define SCREEN_BOUNDS               [UIScreen mainScreen].bounds
#define STATUS_BAR_HEIGHT           (([[UIScreen mainScreen] bounds].size.height == 812.0f || [[UIScreen mainScreen] bounds].size.height == 896.0f) ? 44.0f : 20.0f)
#define BOTTOM_BAR_HEIGHT           (([[UIScreen mainScreen] bounds].size.height == 812.0f || [[UIScreen mainScreen] bounds].size.height == 896.0f) ? 34.0f : 0.0f)

#define NAVIGATIONBAR_HEIGHT        44.0f
#define TABBAR_HEIGHT               49.0f
#define STATUS_NAV_BAR_HEIGHT       (STATUS_BAR_HEIGHT + NAVIGATIONBAR_HEIGHT)

#define VIEW_WIDTH(view)            view.frame.size.width
#define VIEW_HEIGHT(view)           view.frame.size.height
#define VIEW_X(view)                view.frame.origin.x
#define VIEW_Y(view)                view.frame.origin.y
#define VIEW_LEFT(view)             view.frame.origin.x
#define VIEW_TOP(view)              view.frame.origin.y
#define VIEW_BOTTOM(view)           CGRectGetMaxY(view.frame)
#define VIEW_RIGHT(view)            CGRectGetMaxX(view.frame)


enum SKRow_alignment {
    sk_row_top,
    sk_row_center,
    sk_row_bottom
};

enum SKRow_direction {
    start,
    end
};

#import <UIKit/UIKit.h>

@interface SKRow : UIView

//默认为屏宽
@property (nonatomic, assign) double sk_row_width;
//默认为最高的子viewh高度
@property (nonatomic, assign) double sk_row_height;
//默认上对齐
@property (nonatomic, assign) enum SKRow_alignment alignment;
//默认从左开始
@property (nonatomic, assign) enum SKRow_direction direction;
//默认为空
@property (nonatomic, strong) NSArray<UIView *> *sk_row_childs;

- (instancetype)init;

@end
