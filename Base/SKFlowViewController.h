

//UIView
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define SCREEN_BOUNDS               [UIScreen mainScreen].bounds
#define STATUS_BAR_HEIGHT           (([[UIScreen mainScreen] bounds].size.height == 812.0f || [[UIScreen mainScreen] bounds].size.height == 896.0f) ? 44.0f : 20.0f)
#define BOTTOM_BAR_HEIGHT           (([[UIScreen mainScreen] bounds].size.height == 812.0f || [[UIScreen mainScreen] bounds].size.height == 896.0f) ? 34.0f : 0.0f)

#define NAVIGATIONBAR_HEIGHT        44.0f
#define TABBAR_HEIGHT               49.0f
#define STATUS_NAV_BAR_HEIGHT       (STATUS_BAR_HEIGHT + NAVIGATIONBAR_HEIGHT)

#define VIEW_WIDTH(view)            view.frame.size.width
#define VIEW_HEIGHT(view)           view.frame.size.height
#define VIEW_X(view)                view.frame.origin.x
#define VIEW_Y(view)                view.frame.origin.y
#define VIEW_LEFT(view)             view.frame.origin.x
#define VIEW_TOP(view)              view.frame.origin.y
#define VIEW_BOTTOM(view)           CGRectGetMaxY(view.frame)
#define VIEW_RIGHT(view)            CGRectGetMaxX(view.frame)


//json、model和dic之间的转换
#define JsonFromDic(dic) [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]
#define JsonFromModel(model) [model respondsToSelector:@selector(toDictionary)] ? [NetWork jsonFromDic:[model performSelector:@selector(toDictionary)] == nil ? [[NSDictionary alloc] init] : (NSDictionary *)[model performSelector:@selector(toDictionary)]] : @""
#define DicFromJson(json) [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil]
#define DicFromModel(model) [NSJSONSerialization JSONObjectWithData:[([model respondsToSelector:@selector(toDictionary)] ? [NetWork jsonFromDic:[model performSelector:@selector(toDictionary)] == nil ? [[NSDictionary alloc] init] : (NSDictionary *)[model performSelector:@selector(toDictionary)]] : @"") dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil]

//仅适用于sdWebImage
#define skImage(urlString, defaultName) sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultName]

//color
//#define ColorWithRGBHex(hex)    [UIColor colorWithRGBHex:hex]
#define COLOR_A(HEX, ALPHA) [UIColor colorWithRGBHexString:HEX alpha:ALPHA]
#define COLOR(HEX) COLOR_A(HEX, 1.0)
#define COLOR_RANDOM [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f]

//加载xib
#define VIEW_BY_XIB(xibName) [[[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil] lastObject]
#define VIEWS_BY_XIB(xibName) [[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil]
#define VIEW_INDEX_BY_XIB(xibName, index) [[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil].count > index ? [[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil][index] : [[UIView alloc] init]
#define VIEW_BY_FRAME(x, y, w, h) [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)]
#define SPACE_H(height) [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, height)]
#define SPACE_W(width) [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)]


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

enum flow_status_bar_style {
    flow_status_black,
    flow_status_white
};

typedef void(^Click_method_callback)(NSInteger index);

typedef void (^AlertActionCallback)(void);

#pragma mark - SKFlowViewController

@interface SKFlowViewController : UIViewController

//刷新flow_TableView (必须调用此方法)
- (void)flowReload;

//获取nav_bar
- (UIView *)return_nav_bar;

//获取bottom_bar
- (UIView *)return_bottom_bar;

//获取flow_tableView_frame（默认全屏，有nav、bottom、safe_height时会自动调整）
- (CGRect)return_flow_tableView_frame;

//获取cell_click_effect(cell点击效果默认无点击效果)
- (BOOL)return_cell_click_effect;

//获取click_method(默认为空)
- (Click_method_callback)return_click_method;

//获取flow_view_array(默认为空)
- (NSArray<UIView *> *)return_flow_view_array;

//获取flow_cellHeight_array(默认自动获取)
- (NSArray<NSNumber *> *)return_flow_cellHeight_array;

//获取foot_safe_height(默认为0)
- (double)return_foot_safe_height;

//是否可滑动(默认可滑动)
- (BOOL)return_scroll_enabled;

//禁用返回手势(默认不禁用)
- (BOOL)return_back_from_gesture;

//background_color(默认白色)
- (UIColor *)return_background_color;

//status_bar_style(默认黑色)
- (enum flow_status_bar_style)return_status_bar_style;

//消息提示
- (void)toast:(NSString *_Nullable)msg;

//弹出选择框
- (void)alertWithTitle:(NSString * _Nonnull)title
               msg:(NSString *_Nonnull)msg
            left:(NSString * _Nonnull)left
          leftCallback:(AlertActionCallback _Nonnull)leftCallback
           right:(NSString * _Nonnull)right
     rightCallback:(AlertActionCallback _Nonnull)rightCallback;
@end



#pragma mark - SKNav
@interface SKNav : UIView

//title
@property (nonatomic, strong) NSString *title;

//titleColor
@property (nonatomic, strong) UIColor *themeColor;

//fontSize
@property (nonatomic, assign) NSInteger fontSize;

//backImage
@property (nonatomic, strong) NSString *imageUrl;

//left_items
@property (nonatomic, strong) NSArray<UIButton *> *left_items;

//right_items
@property (nonatomic, strong) NSArray<UIButton *> *right_items;

- (instancetype)init;

+ (SKNav *)backStyleWithTitle:(NSString *)title;

@end



#pragma mark - SKAlertView

@interface SKAlertView : UIView

typedef void (^AlertActionCallback)(void);

+ (void)alertWithTitle:(NSString * _Nonnull)title
                   msg:(NSString *_Nonnull)msg
                  left:(NSString * _Nonnull)left
          leftCallback:(AlertActionCallback _Nonnull)leftCallback
                 right:(NSString * _Nonnull)right
         rightCallback:(AlertActionCallback _Nonnull)rightCallback;

@end

NS_ASSUME_NONNULL_END


@interface UIColor (TFT)
//生成color
+ (UIColor *_Nullable)colorWithRGBHexString:(NSString *_Nullable)hexString alpha:(CGFloat)alpha;
@end

@interface UIButton (colorImage)
//根据颜色设置背景
- (void)defaultColor: (UIColor *_Nullable)defaultColor highlightedColor: (UIColor *_Nullable)highlightedColor;

@end

#pragma mark - SKColumn

enum SKColumn_alignment {
    sk_column_left,
    sk_column_center,
    sk_column_right
};

#import <UIKit/UIKit.h>

@interface SKColumn : UIView

//默认屏宽
@property (nonatomic, assign) double sk_column_width;
//默认左对齐
@property (nonatomic, assign) enum SKColumn_alignment alignment;
//默认为空
@property (nonatomic, strong) NSArray<UIView *> * _Nullable sk_column_childs;

- (instancetype _Nullable )init;

@end

#pragma mark - SKRow

enum SKRow_alignment {
    sk_row_top,
    sk_row_center,
    sk_row_bottom
};

enum SKRow_direction {
    start,
    end
};

#import <UIKit/UIKit.h>

@interface SKRow : UIView

//默认为屏宽
@property (nonatomic, assign) double sk_row_width;
//默认为最高的子viewh高度
@property (nonatomic, assign) double sk_row_height;
//默认上对齐
@property (nonatomic, assign) enum SKRow_alignment alignment;
//默认从左开始
@property (nonatomic, assign) enum SKRow_direction direction;
//默认为空
@property (nonatomic, strong) NSArray<UIView *> * _Nullable sk_row_childs;

- (instancetype _Nullable )init;

@end



