
#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIView *)return_nav_bar {
    SKNavigationBar *nav = [SKNavigationBar new];
    nav.title = @"主页";
    return nav;
}

- (double)return_foot_safe_height {
    return BOTTOM_BAR_HEIGHT;
}

- (NSArray<UIView *> *)return_flow_view_array {
    return [self views];
}

- (BOOL)return_cell_click_effect {
    return YES;
}

- (Click_method_callback)return_click_method {
    return ^void(NSInteger index) {
        UIViewController *vc = [[ViewController2 alloc] init];
        vc.title = [NSString stringWithFormat:@"%ld", (long)index];
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (NSArray<UIView *> *)views{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 100; i++) {
        if (i % 3 == 0) {
            UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            v1.backgroundColor = UIColor.grayColor;
            [views addObject:v1];
        }
        if (i % 3 == 1) {
            UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
            v2.backgroundColor = UIColor.brownColor;
            [views addObject:v2];
        }
        if (i % 3 == 2) {
            UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
            v3.backgroundColor = UIColor.lightGrayColor;
            [views addObject:v3];
        }
    }
    return views;
}



@end
