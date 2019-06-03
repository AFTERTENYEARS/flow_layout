//
//  ViewController.m
//  SKbase
//
//  Created by mac book pro on 2019/5/31.
//  Copyright © 2019 com.SKbase.www. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (UIView *)return_flow_nav_bar {
    SKNavigationBar *nav = [SKNavigationBar new];
    nav.title = @"主页";
    return nav;
}

- (double)return_flow_foot_bar_height {
    return BOTTOM_BAR_HEIGHT;
}

- (NSArray<UIView *> *)return_flow_view_array {
    return [self views];
}

- (BOOL)return_cell_click_effect {
    return YES;
}

- (Click_method_callback)return_click_method {
    return ^(NSInteger index) {
        [self toast:[NSString stringWithFormat:@"%ld", (long)index]];
    };
}

- (NSArray<UIView *> *)views{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 30; i++) {
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