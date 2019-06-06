
#import "ViewController2.h"

@interface ViewController2 ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self flowReload];
}

- (UIColor *)return_background_color {
    return UIColor.whiteColor;
}

- (enum flow_status_bar_style)return_status_bar_style {
    return flow_status_white;
}

- (UIView *)return_nav_bar {
    SKNav *nav = [SKNav backStyleWithTitle:[NSString stringWithFormat:@"第 %ld 行", self.count]];
    nav.imageUrl = @"nav_back_image";
    nav.themeColor = UIColor.whiteColor;
    UIButton *button0 = VIEWS_BY_XIB(@"Views")[0];
    [button0 addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button1 = VIEWS_BY_XIB(@"Views")[1];
    [button1 addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    nav.right_items = @[button0, button1];
    
    return nav;
}

- (void)change {
    self.count += 1;
    [self flowReload];
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
    column.sk_column_childs = @[VIEW_INDEX_BY_XIB(@"Views", 2),
                                SPACE_H(10),
                                VIEW_INDEX_BY_XIB(@"Views", 3),
                                SPACE_H(10),
                                VIEW_INDEX_BY_XIB(@"Views", 4)];
    column.alignment = sk_column_right;
    
    //添加一个row
    SKRow *row = [[SKRow alloc] init];
    row.sk_row_childs = @[VIEW_INDEX_BY_XIB(@"Views", 5),
                          SPACE_W(15),
                          VIEW_INDEX_BY_XIB(@"Views", 6),
                          SPACE_W(15),
                          VIEW_INDEX_BY_XIB(@"Views", 7),
                          SPACE_W(15),
                          VIEW_INDEX_BY_XIB(@"Views", 8)];
    row.alignment = sk_row_bottom;
    
    if (self.count % 2 == 0) {
        return @[row, column];
    }
    
    return @[column, row];
}

- (UIView *)return_bottom_bar {
    UIView *view = VIEW_BY_FRAME(0, 0, SCREEN_WIDTH, BOTTOM_BAR_HEIGHT + 44);
    view.backgroundColor = COLOR_RANDOM;
    return view;
}


@end
