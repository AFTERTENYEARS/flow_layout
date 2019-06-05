
#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIColor *)return_background_color {
    return UIColor.lightGrayColor;
}

- (enum flow_status_bar_style)return_status_bar_style {
    return flow_status_white;
}

- (UIView *)return_nav_bar {
    SKNavigationBar *nav = [SKNavigationBar backStyleWithTitle:[NSString stringWithFormat:@"第 %@ 行", self.title]];
    nav.imageUrl = @"nav_back";
    nav.themeColor = UIColor.whiteColor;
    return nav;
}

- (UIView *)return_bottom_bar {
    UIView *view = VIEW_BY_FRAME(0, 0, SCREEN_WIDTH, BOTTOM_BAR_HEIGHT + 44);
    view.backgroundColor = UIColor.brownColor;
    return view;
}


@end
