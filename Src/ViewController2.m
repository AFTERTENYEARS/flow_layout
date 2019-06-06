
#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIColor *)return_background_color {
    return UIColor.whiteColor;
}

- (enum flow_status_bar_style)return_status_bar_style {
    return flow_status_white;
}

- (UIView *)return_nav_bar {
    SKNav *nav = [SKNav backStyleWithTitle:[NSString stringWithFormat:@"第 %@ 行", self.title]];
    nav.imageUrl = @"nav_back_image";
    nav.themeColor = UIColor.whiteColor;
    
    UIButton *button0 = VIEWS_BY_XIB(@"Views")[0];
    UIButton *button1 = VIEWS_BY_XIB(@"Views")[1];
    [button1 addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    nav.right_items = @[button0, button1];
    
    return nav;
}

- (void)alert {
    [self alertWithTitle:@"title" msg:@"msg" left:@"left" leftCallback:^{
        [self toast:@"leftButtonClicked"];
    } right:@"right" rightCallback:^{
        [self toast:@"rightButtonClicked"];
    }];
}

- (NSArray<UIView *> *)return_flow_view_array {
    
    //添加一个column
    SKColumn *column = [[SKColumn alloc] init];
    column.sk_column_childs = @[VIEWS_BY_XIB(@"Views")[2],
                                SPACE_H(10),
                                VIEWS_BY_XIB(@"Views")[3],
                                SPACE_H(10),
                                VIEWS_BY_XIB(@"Views")[4]];
    column.alignment = sk_column_right;
    
    //添加一个row
    SKRow *row = [[SKRow alloc] init];
    row.sk_row_childs = @[VIEWS_BY_XIB(@"Views")[5],
                          SPACE_W(15),
                          VIEWS_BY_XIB(@"Views")[6],
                          SPACE_W(15),
                          VIEWS_BY_XIB(@"Views")[7],
                          SPACE_W(15),
                          VIEWS_BY_XIB(@"Views")[8]];
    row.alignment = sk_row_bottom;
    
    return @[column, row];
}

- (UIView *)return_bottom_bar {
    UIView *view = VIEW_BY_FRAME(0, 0, SCREEN_WIDTH, BOTTOM_BAR_HEIGHT + 44);
    view.backgroundColor = UIColor.brownColor;
    return view;
}


@end
