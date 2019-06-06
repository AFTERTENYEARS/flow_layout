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


enum SKColumn_alignment {
    sk_column_left,
    sk_column_center,
    sk_column_right
};

#import <UIKit/UIKit.h>

@interface SKColumn : UIView

//默认屏宽
@property (nonatomic, assign) double sk_column_width;
//默认左对齐
@property (nonatomic, assign) enum SKColumn_alignment alignment;
//默认为空
@property (nonatomic, strong) NSArray<UIView *> *sk_column_childs;

- (instancetype)init;

@end
