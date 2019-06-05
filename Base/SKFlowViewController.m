
#pragma mark - SKFlowViewController

@interface SKFlowViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *nav_bar;
@property (nonatomic, strong) UITableView *flow_TableView;
@property (nonatomic, strong) UIView *bottom_bar;
@property (nonatomic, assign) double foot_safe_height;


@property (nonatomic, copy) Click_method_callback click_method;
@property (nonatomic, strong) NSArray<UIView *> *flow_view_array;
@property (nonatomic, strong) NSArray<NSNumber *> *flow_cellHeight_array;

@property (nonatomic, assign) CGRect flow_tableView_frame;
@property (nonatomic, assign) BOOL cell_click_effect;
@property (nonatomic, assign) BOOL scroll_enabled;
@property (nonatomic, assign) BOOL can_back_from_gesture;
@property (nonatomic, strong) UIColor *background_color;
@property (nonatomic, assign) enum flow_status_bar_style status_bar_style;


@end

@implementation SKFlowViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    // 是否禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = self.can_back_from_gesture ? YES : NO;
    }
    
    //状态栏颜色
    self.navigationController.navigationBar.barStyle = self.status_bar_style == flow_status_black ? UIBarStyleDefault : UIBarStyleBlack;
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
    UIView *get_bar = self.return_bottom_bar;
    get_bar.frame = CGRectMake(0, SCREEN_HEIGHT - VIEW_HEIGHT(get_bar), SCREEN_WIDTH, VIEW_HEIGHT(get_bar));
    return get_bar;
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

//status_bar_style
- (enum flow_status_bar_style)status_bar_style {
    return self.return_status_bar_style;
}

- (enum flow_status_bar_style)return_status_bar_style {
    return flow_status_black;
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

- (void)AlertWithTitle:(NSString * _Nonnull)title
                   msg:(NSString *_Nonnull)msg
                  left:(NSString * _Nonnull)left
          leftCallback:(AlertActionCallback _Nonnull)leftCallback
                 right:(NSString * _Nonnull)right
         rightCallback:(AlertActionCallback _Nonnull)rightCallback{
    SKAlertView *alertView = [[SKAlertView alloc] init];
    [alertView putUpWithTitle:title message:msg leftButton:left leftCallback:leftCallback rightButton:right rightCallback:rightCallback];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

@end


#pragma mark - SKNav

@interface SKNav ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *backItem;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *left_items_view;
@property (nonatomic, strong) UIView *right_items_view;

@end

@implementation SKNav

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAV_BAR_HEIGHT);
        self.backgroundColor = UIColor.whiteColor;
        self.clipsToBounds = YES;
        [self addSubview:self.backImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.left_items_view];
        [self addSubview:self.right_items_view];
        [self addSubview:self.backItem];
        
    }
    return self;
}

+ (SKNav *)backStyleWithTitle:(NSString *)title {
    SKNav *backNav = [[SKNav alloc] init];
    backNav.title = title;
    backNav.backItem.hidden = NO;
    return backNav;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    self.titleLabel.textColor = themeColor;
    [self.backItem setTitleColor:themeColor forState:UIControlStateNormal];
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

- (void)setLeft_items:(NSArray<UIButton *> *)left_items {
    if (left_items.count > 0 && self.backItem.hidden == NO) {
        self.backItem.hidden = YES;
    }
    _left_items = left_items;
    for (UIView *subView in self.left_items_view.subviews) {
        [subView removeFromSuperview];
    }
    for (NSInteger i = 0; i < left_items.count; i++) {
        UIButton *item = left_items[i];
        CGFloat width = 16;
        for (NSInteger j = 0; j < i; j++) {
            UIButton *addWidthItem = left_items[j];
            width += VIEW_WIDTH(addWidthItem);
            width += 16;
        }
        UIView *buttonContainer = [[UIView alloc] initWithFrame:CGRectMake(width, 0, VIEW_WIDTH(item), NAVIGATIONBAR_HEIGHT)];
        item.frame = CGRectMake(0, (NAVIGATIONBAR_HEIGHT - VIEW_HEIGHT(item)) / 2.0, VIEW_WIDTH(item), VIEW_HEIGHT(item));
        [buttonContainer addSubview:item];
        [self.left_items_view addSubview:buttonContainer];
    }
}

- (void)setRight_items:(NSArray<UIButton *> *)right_items {
    NSMutableArray * tmp_items = [NSMutableArray arrayWithArray:right_items];
    NSArray *reverse_items = [[tmp_items reverseObjectEnumerator] allObjects];
    _right_items = reverse_items;
    for (UIView *subView in self.right_items_view.subviews) {
        [subView removeFromSuperview];
    }
    for (NSInteger i = 0; i < reverse_items.count; i++) {
        UIButton *item = reverse_items[i];
        CGFloat width = 16;
        for (NSInteger j = 0; j < i; j++) {
            UIButton *addWidthItem = reverse_items[j];
            width += VIEW_WIDTH(addWidthItem);
            width += 16;
        }
        width += VIEW_WIDTH(item);
        UIView *buttonContainer = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH(self.right_items_view) - width, 0, VIEW_WIDTH(item), NAVIGATIONBAR_HEIGHT)];
        item.frame = CGRectMake(0, (NAVIGATIONBAR_HEIGHT - VIEW_HEIGHT(item)) / 2.0, VIEW_WIDTH(item), VIEW_HEIGHT(item));
        [buttonContainer addSubview:item];
        [self.right_items_view addSubview:buttonContainer];
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

- (UIButton *)backItem {
    if (_backItem) {
        return _backItem;
    }
    _backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backItem setImage:[UIImage new] forState:UIControlStateNormal];
    _backItem.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 44, 44);
    [_backItem setTitle:@"←" forState:UIControlStateNormal];
    [_backItem setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_backItem setTitleColor:UIColor.lightGrayColor forState:UIControlStateHighlighted];
    _backItem.titleLabel.font = [UIFont systemFontOfSize:22];
    [_backItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    _backItem.hidden = YES;
    return _backItem;
}

- (void)back {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    [currentVC.navigationController popViewControllerAnimated:YES];
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
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

- (UIView *)left_items_view {
    if (_left_items_view) {
        return _left_items_view;
    }
    _left_items_view = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH / 2.0, NAVIGATIONBAR_HEIGHT)];
    return _left_items_view;
}

- (UIView *)right_items_view {
    if (_right_items_view) {
        return _right_items_view;
    }
    _right_items_view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0, STATUS_BAR_HEIGHT, SCREEN_WIDTH / 2.0, NAVIGATIONBAR_HEIGHT)];
    return _right_items_view;
}

@end



#pragma mark - SKAlert

@implementation SKAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self addSubview:self.alertWrapper];
        [self.alertWrapper addSubview:self.titlelabel];
        [self.alertWrapper addSubview:self.messageLabel];
        [self.alertWrapper addSubview:self.horizontalLine];
        [self.alertWrapper addSubview:self.verticalLine];
        [self.alertWrapper addSubview:self.leftButton];
        [self.alertWrapper addSubview:self.rightButton];
    }
    return self;
}

- (void)putUpWithTitle:(NSString * _Nonnull)title message:(NSString * _Nonnull)message leftButton:(NSString * _Nonnull)leftButton leftCallback:(AlertActionCallback _Nonnull)leftCallback rightButton:(NSString * _Nonnull)rightButton rightCallback:(AlertActionCallback _Nonnull)rightCallback{
    self.alertWrapper.hidden = YES;
    
    //预设wrapper
    self.alertWrapper.frame = CGRectMake(47.5, (SCREEN_HEIGHT - 168.0) / 2.0, SCREEN_WIDTH - 47.5 * 2, 168.0);
    
    //计算messge高度
    CGSize messageSize = [message boundingRectWithSize:CGSizeMake(self.alertWrapper.frame.size.width - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    
    //设置wrapper frame
    CGFloat wrapperHeight = 20.0 + 35.0 + 5.0 + messageSize.height + 15.0 + 50.0;
    self.alertWrapper.frame = CGRectMake(47.5, (SCREEN_HEIGHT - wrapperHeight) / 2.0, SCREEN_WIDTH - 47.5 * 2, wrapperHeight);
    
    //设置title
    self.titlelabel.frame = CGRectMake(0, 20.0, self.alertWrapper.frame.size.width, 35.0);
    self.titlelabel.text = title;
    
    //设置message
    self.messageLabel.frame = CGRectMake(35.0, 20.0 + 35.0 + 5.0, self.alertWrapper.frame.size.width - 35.0 - 35.0, messageSize.height);
    self.messageLabel.text = message;
    
    //设置横线
    self.horizontalLine.frame = CGRectMake(0, self.alertWrapper.frame.size.height - 50.0, self.alertWrapper.frame.size.width, 0.5);
    //设置竖线
    self.verticalLine.frame = CGRectMake(self.alertWrapper.frame.size.width / 2.0, self.alertWrapper.frame.size.height - 49.5, 0.5, 49.5);
    
    //设置左按钮
    self.leftButton.frame = CGRectMake(0, self.alertWrapper.frame.size.height - 49.5, self.alertWrapper.frame.size.width / 2.0 - 0.5, 49.5);
    [self.leftButton setTitle:leftButton forState:UIControlStateNormal];
    self.leftCallback = leftCallback;
    
    //设置右按钮
    self.rightButton.frame = CGRectMake(self.alertWrapper.frame.size.width / 2.0 + 0.5, self.alertWrapper.frame.size.height - 49.5, self.alertWrapper.frame.size.width / 2.0 - 0.5, 49.5);
    [self.rightButton setTitle:rightButton forState:UIControlStateNormal];
    self.rightCallback = rightCallback;
    
    self.alertWrapper.hidden = NO;
    
    // 先缩小
    self.alertWrapper.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        self.alertWrapper.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

- (void)leftButtonClicked:(UIButton *)leftButton{
    [self removeFromSuperview];
    self.leftCallback();
}

- (void)rightButtonClicked:(UIButton *)rightButton{
    [self removeFromSuperview];
    self.rightCallback();
}

#pragma mark - lazyLoad
- (UIView *)alertWrapper{
    if (_alertWrapper) {
        return _alertWrapper;
    }
    _alertWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _alertWrapper.backgroundColor = [UIColor whiteColor];
    _alertWrapper.layer.masksToBounds = YES;
    _alertWrapper.layer.cornerRadius = 4.0f;
    return _alertWrapper;
}

- (UILabel *)titlelabel{
    if (_titlelabel) {
        return _titlelabel;
    }
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _titlelabel.font = [UIFont systemFontOfSize:18];
    _titlelabel.textColor = [UIColor colorWithRed:49.0 / 255.0 green:56.0 / 255.0 blue:63.0 / 255.0 alpha:1];
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    return _titlelabel;
}

- (UILabel *)messageLabel{
    if (_messageLabel) {
        return _messageLabel;
    }
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _messageLabel.font = [UIFont systemFontOfSize:15];
    _messageLabel.textColor = [UIColor colorWithRed:165.0 / 255.0 green:171.0 / 255.0 blue:180.0 / 255.0 alpha:1];
    _messageLabel.textAlignment = 1;
    _messageLabel.numberOfLines = 0;
    return _messageLabel;
}

- (UIView *)horizontalLine{
    if (_horizontalLine) {
        return _horizontalLine;
    }
    _horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _horizontalLine.backgroundColor = [UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1];
    return _horizontalLine;
}

- (UIView *)verticalLine{
    if (_verticalLine) {
        return _verticalLine;
    }
    _verticalLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _verticalLine.backgroundColor = [UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1];
    return _verticalLine;
}

- (UIButton *)leftButton{
    if (_leftButton) {
        return _leftButton;
    }
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(0, 0, 1, 1);
    [_leftButton setTitleColor:[UIColor colorWithRed:146.0 / 255.0 green:154.0 / 255.0 blue:165.0 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:[self imageWithColor:UIColor.whiteColor size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:202.0 / 255.0 green:202.0 / 255.0 blue:202.0 / 255.0 alpha:1] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [_leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return _leftButton;
}

- (UIButton *)rightButton{
    if (_rightButton) {
        return _rightButton;
    }
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 1, 1);
    [_rightButton setTitleColor:[UIColor colorWithRed:73.0 / 255.0 green:161.0 / 255.0 blue:219.0 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[self imageWithColor:UIColor.whiteColor size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:202.0 / 255.0 green:202.0 / 255.0 blue:202.0 / 255.0 alpha:1] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [_rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return _rightButton;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
