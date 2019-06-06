
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
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    //添加一个column
    SKColumn *column = [[SKColumn alloc] init];
    UIView *v11 = VIEWS_BY_XIB(@"Views")[2];
    UIView *v22 = VIEWS_BY_XIB(@"Views")[3];
    UIView *v33 = VIEWS_BY_XIB(@"Views")[4];
    
    column.sk_column_childs = @[v11, v22, v33];
    column.alignment = sk_column_right;
    
    [views addObject:column];
    
    //添加一个row
    SKRow *row = [[SKRow alloc] init];
    UIView *v44 = VIEWS_BY_XIB(@"Views")[5];
    UIView *v55 = VIEWS_BY_XIB(@"Views")[6];
    UIView *v66 = VIEWS_BY_XIB(@"Views")[7];
    UIView *v77 = VIEWS_BY_XIB(@"Views")[8];
    
    row.sk_row_childs = @[v44, v55, v66, v77];
    row.alignment = sk_row_bottom;
    
    [views addObject:row];
    
    return views;
}

- (UIView *)return_bottom_bar {
    UIView *view = VIEW_BY_FRAME(0, 0, SCREEN_WIDTH, BOTTOM_BAR_HEIGHT + 44);
    view.backgroundColor = UIColor.brownColor;
    return view;
}


@end
