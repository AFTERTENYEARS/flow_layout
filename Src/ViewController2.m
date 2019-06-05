
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
    SKNav *nav = [SKNav backStyleWithTitle:[NSString stringWithFormat:@"第 %@ 行", self.title]];
    nav.imageUrl = @"nav_back";
    nav.themeColor = UIColor.whiteColor;
    
    UIButton *button = VIEWS_BY_XIB(@"Views")[1];
    [button addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    nav.right_items = @[VIEWS_BY_XIB(@"Views")[0], button];
    return nav;
}

- (void)alert {
    [self AlertWithTitle:@"title" msg:@"msg" left:@"left" leftCallback:^{
        [self toast:@"left"];
    } right:@"right" rightCallback:^{
        [self toast:@"right"];
    }];
}

- (UIView *)return_bottom_bar {
    UIView *view = VIEW_BY_FRAME(0, 0, SCREEN_WIDTH, BOTTOM_BAR_HEIGHT + 44);
    view.backgroundColor = UIColor.brownColor;
    return view;
}


@end
