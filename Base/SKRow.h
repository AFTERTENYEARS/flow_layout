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

#import <UIKit/UIKit.h>

@interface SKRow : UIView

@property (nonatomic, assign) double sk_row_width;
@property (nonatomic, assign) double sk_row_height;
@property (nonatomic, assign) enum SKColumn_alignment alignment;
@property (nonatomic, strong) NSArray<UIView *> *sk_row_childs;

- (instancetype)init;

@end
