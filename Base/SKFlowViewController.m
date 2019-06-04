

#pragma mark - SKFlowViewController

@interface SKFlowViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *nav_bar;
@property (nonatomic, strong) UITableView *flow_TableView;
@property (nonatomic, strong) UIView *bottom_bar;
@property (nonatomic, assign) double foot_safe_height;


@property (nonatomic, copy) Click_method_callback click_method;
@property (nonatomic, copy) NSArray<UIView *> *flow_view_array;
@property (nonatomic, copy) NSArray<NSNumber *> *flow_cellHeight_array;

@property (nonatomic, assign) CGRect flow_tableView_frame;
@property (nonatomic, assign) BOOL cell_click_effect;
@property (nonatomic, assign) BOOL scroll_enabled;
@property (nonatomic, assign) BOOL can_back_from_gesture;
@property (nonatomic, strong) UIColor *background_color;


@end

@implementation SKFlowViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    // 是否禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = self.can_back_from_gesture ? YES : NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.nav_bar) {
        [self.view addSubview:self.nav_bar];
    }
    [self.view addSubview:self.flow_TableView];
    if (self.bottom_bar) {
        [self.view addSubview:self.bottom_bar];
    }
    self.view.backgroundColor = self.background_color;
    
    [self flowReload];
}

//刷新flow_TableView
- (void)flowReload {
    //frame
    _nav_bar.frame = CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT(self.nav_bar));
    _flow_TableView.frame = CGRectMake(0, VIEW_HEIGHT(self.nav_bar), SCREEN_WIDTH, SCREEN_HEIGHT - VIEW_HEIGHT(self.nav_bar) - VIEW_HEIGHT(self.bottom_bar));
    _bottom_bar.frame = CGRectMake(0, SCREEN_HEIGHT - VIEW_HEIGHT(self.bottom_bar), SCREEN_WIDTH, VIEW_HEIGHT(self.bottom_bar));
    //foot_safe_height
    if (self.foot_safe_height > 0) {
       _flow_TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.foot_safe_height)];
    } else {
        _flow_TableView.tableFooterView = [UIView new];
    }
    
    //cell点击效果（默认为NO）
    _cell_click_effect = self.cell_click_effect;
    //是否可滑动
    _flow_TableView.scrollEnabled = self.scroll_enabled;
    //views
    _flow_view_array = self.flow_view_array;
    //cell高度数组默认自动获取
    _flow_cellHeight_array = self.flow_cellHeight_array;
    
    [self.flow_TableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _flow_view_array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _flow_cellHeight_array[indexPath.row].doubleValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *flowTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"FlowTableViewCell"];
    flowTableViewCell.selectionStyle = _cell_click_effect ? UITableViewCellSelectionStyleDefault: UITableViewCellSelectionStyleNone;
    [flowTableViewCell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [flowTableViewCell addSubview:_flow_view_array[indexPath.row]];
    flowTableViewCell.selected = NO;
    return flowTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.flow_TableView) {
        if (self.click_method) {
            self.click_method(indexPath.row);
        }
    }
}

//获取flow_tableView_frame
- (CGRect)flow_tableView_frame {
    return self.return_flow_tableView_frame;
}

- (CGRect)return_flow_tableView_frame {
    return CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

//获取cell_click_effect
- (BOOL)cell_click_effect {
    return self.return_cell_click_effect;
}

- (BOOL)return_cell_click_effect {
    return NO;
}

//获取click_method
- (Click_method_callback)click_method {
    return self.return_click_method;
}

- (Click_method_callback)return_click_method {
    return ^(NSInteger index) {
        
    };
}

//获取flow_view_array
- (NSArray<UIView *> *)flow_view_array {
    return self.return_flow_view_array;
}

- (NSArray<UIView *> *)return_flow_view_array {
    return @[];
}

//获取flow_cellHeight_array
- (NSArray<NSNumber *> *)flow_cellHeight_array {
    return self.return_flow_cellHeight_array;
}

- (NSArray<NSNumber *> *)return_flow_cellHeight_array {
    NSMutableArray<NSNumber *> *array = [[NSMutableArray alloc] init];
    for (UIView *view in self.flow_view_array) {
        [array addObject:@(VIEW_HEIGHT(view))];
    }
    return array;
}

//是否可滑动
- (BOOL)scroll_enabled {
    return self.return_scroll_enabled;
}

- (BOOL)return_scroll_enabled {
    return YES;
}

//获取nav_bar
- (UIView *)nav_bar {
    return self.return_nav_bar;
}

- (UIView *)return_nav_bar {
    return [UIView new];
}

//获取bottom_bar
- (UIView *)bottom_bar {
    return self.return_bottom_bar;
}

- (UIView *)return_bottom_bar {
    return [UIView new];
}

//获取foot_safe_height
- (double)foot_safe_height {
    return self.return_foot_safe_height;
}

- (double)return_foot_safe_height {
    return 0;
}

//获取can_back_from_gesture
- (BOOL)can_back_from_gesture {
    return self.return_back_from_gesture;
}

- (BOOL)return_back_from_gesture {
    return YES;
}

//background_color
- (UIColor *)background_color {
    return self.return_background_color;
}

- (UIColor *)return_background_color {
    return UIColor.whiteColor;
}

//获取flow_TableView
- (UITableView *)flow_TableView {
    if (_flow_TableView) {
        return _flow_TableView;
    }
    _flow_TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [_flow_TableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FlowTableViewCell"];
    _flow_TableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
#ifdef __IPHONE_11_0
    if ([_flow_TableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            _flow_TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
#endif
    _flow_TableView.showsHorizontalScrollIndicator = NO;
    _flow_TableView.showsVerticalScrollIndicator = YES;
    _flow_TableView.delegate = self;
    _flow_TableView.dataSource = self;
    _flow_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _flow_TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _flow_TableView.backgroundColor = [UIColor clearColor];
    return _flow_TableView;
}

- (void)toast:(NSString *_Nullable)msg{
    if (msg.length <= 0) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 4.0f;
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = msg;
    CGSize size = [msg boundingRectWithSize:CGSizeMake(window.bounds.size.width - 48, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size;
    label.frame = CGRectMake((window.bounds.size.width - size.width) / 2 - 12, (window.bounds.size.height - size.height) / 2 - 12, size.width + 24, size.height + 24);
    [window addSubview:label];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}

@end


#pragma mark - SKNavigationBar

@interface SKNavigationBar ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SKNavigationBar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAV_BAR_HEIGHT);
        [self addSubview:self.backImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

+ (SKNavigationBar *)backStyleWithTitle:(NSString *)title {
    SKNavigationBar *backNav = [[SKNavigationBar alloc] init];
    backNav.backgroundColor = UIColor.whiteColor;
    backNav.title = title;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage new] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 44, 44);
    [backButton setTitle:@"←" forState:UIControlStateNormal];
    [backButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [backButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateHighlighted];
    backButton.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backNav addSubview:backButton];
    return backNav;
}

+ (void)back {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    [currentVC.navigationController popViewControllerAnimated:YES];
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setFont:(NSInteger)fontSize {
    _fontSize = fontSize;
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    if (imageUrl.length > 0) {
        self.backImageView.image = [UIImage imageNamed:imageUrl];
    }
}

- (UIImageView *)backImageView {
    if (_backImageView) {
        return _backImageView;
    }
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAV_BAR_HEIGHT)];
    _backImageView.backgroundColor = UIColor.clearColor;
    _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    return _backImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    _titleLabel.textColor = UIColor.blackColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    return _titleLabel;
}

@end

#pragma mark - SKColor

CGFloat const MAX_VAL = 255.0f;
NSString *const HEX_CHAR_SET = @"abcdefABCDEF1234567890";
@implementation UIColor (TFT)

+ (NSString *)cleanHexString:(NSString *)hexString expectedLength:(int)expectedLength {
    NSMutableString *mutableHexString = [hexString mutableCopy];
    if ([hexString hasPrefix:@"#"]) {
        [mutableHexString deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    else if ([hexString hasPrefix:@"0x"] ||
             [hexString hasPrefix:@"0X"]) {
        [mutableHexString deleteCharactersInRange:NSMakeRange(0, 2)];
    }
    //Check for Special Characters. Truncate the string from first special character.
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:HEX_CHAR_SET] invertedSet];
    NSUInteger firstInvalidChar = [hexString rangeOfCharacterFromSet:characterSet].location;
    if (firstInvalidChar != NSNotFound) {
        [mutableHexString deleteCharactersInRange:NSMakeRange(firstInvalidChar, mutableHexString.length - firstInvalidChar)];
    }
    //Repeat each hex digit if length is half
    if (mutableHexString.length == expectedLength/2) {
        for (int i = 0; i < expectedLength/2; ++i) {
            [mutableHexString insertString:[mutableHexString  substringWithRange:NSMakeRange(i*2, 1)] atIndex:i*2];
        }
    }
    //Append zeros if the length is less than the expected length
    else if (mutableHexString.length < expectedLength) {
        while (mutableHexString.length != expectedLength) {
            [mutableHexString insertString:@"0" atIndex:0];
        }
    }
    //Truncate the excess string if length is greater than expected length
    else if(mutableHexString.length > expectedLength) {
        [mutableHexString deleteCharactersInRange:NSMakeRange(expectedLength, hexString.length - expectedLength)];
    }
    return mutableHexString;
}

+ (NSUInteger)hexValueFromHexString:(NSString *)hexString {
    unsigned hexValue = 0;
    [[NSScanner scannerWithString:hexString] scanHexInt:&hexValue];
    return hexValue;
}

+ (UIColor *)colorWithRGBHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *cleanedHexString = [UIColor cleanHexString:hexString expectedLength:6];
    return [UIColor colorWithRGBHexValue:[self hexValueFromHexString:cleanedHexString] alpha:alpha];
}
+ (UIColor *)colorWithRGBHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0f
                           green:(((hexValue & 0xFF00) >> 8))/255.0f
                            blue:((hexValue & 0xFF))/255.0f alpha:1.0f];
}

@end
