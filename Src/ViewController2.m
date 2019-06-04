
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

- (UIView *)return_nav_bar {
    SKNavigationBar *bar = [SKNavigationBar backStyleWithTitle:[NSString stringWithFormat:@"第 %@ 行", self.title]];
    bar.imageUrl = @"nav_back";
    bar.themeColor = UIColor.whiteColor;
    return bar;
}

- (UIView *)return_bottom_bar {
    UIView *view = VIEW_BY_FRAME(0, SCREEN_HEIGHT - BOTTOM_BAR_HEIGHT - 44, SCREEN_WIDTH, BOTTOM_BAR_HEIGHT + 44);
    view.backgroundColor = UIColor.brownColor;
    return view;
}


@end
