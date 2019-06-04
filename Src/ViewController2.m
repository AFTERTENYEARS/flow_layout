
#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (UIView *)return_flow_nav_bar {
    return [SKNavigationBar backStyleWithTitle:[NSString stringWithFormat:@"第 %@ 行", self.title]];
}

- (UIView *)return_flow_bottom_bar {
    UIView *view = VIEW_BY_FRAME(0, SCREEN_HEIGHT - BOTTOM_BAR_HEIGHT - 44, SCREEN_WIDTH, BOTTOM_BAR_HEIGHT + 44);
    view.backgroundColor = UIColor.brownColor;
    return view;
}


@end
