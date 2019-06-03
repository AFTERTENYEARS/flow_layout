//
//  ViewController2.m
//  SKbase
//
//  Created by 李书康 on 2019/6/3.
//  Copyright © 2019 com.SKbase.www. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (UIView *)return_flow_nav_bar {
    SKNavigationBar *nav = [[SKNavigationBar alloc] init];
    nav.title = [NSString stringWithFormat:@"第 %@ 行", self.title];
    return nav;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
