

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Click_method_callback)(NSInteger index);

#pragma mark - SKFlowViewController

@interface SKFlowViewController : UIViewController
//刷新flow_TableView (必须调用此方法)
- (void)flowReload;

//获取flow_nav_bar
- (UIView *)return_flow_nav_bar;

//获取flow_bottom_bar
- (UIView *)return_flow_bottom_bar;

//获取flow_TableView_frame
- (CGRect)return_flow_TableView_frame;

//获取cell_click_effect
- (BOOL)return_cell_click_effect;

//获取click_method
- (Click_method_callback)return_click_method;

//获取flow_viewArray
- (NSArray<UIView *> *)return_flow_view_array;

//获取flow_cellHeightArray
- (NSArray<NSNumber *> *)return_flow_cellHeight_array;

//获取flow_foot_safe_height
- (double)return_flow_foot_safe_height;

//是否可滑动
- (BOOL)return_flow_scroll_enabled;

//消息提示
- (void)toast:(NSString *_Nullable)msg;

@end



#pragma mark - SKNavigationBar
@interface SKNavigationBar : UIView

//title
@property (nonatomic, copy) NSString *title;

//titleColor
@property (nonatomic, copy) UIColor *titleColor;

//fontSize
@property (nonatomic, assign) NSInteger fontSize;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END


@interface UIColor (TFT)
//生成color
+ (UIColor *_Nullable)colorWithRGBHexString:(NSString *_Nullable)hexString alpha:(CGFloat)alpha;
@end


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
#define DicFromModel(json) [NSJSONSerialization JSONObjectWithData:[([model respondsToSelector:@selector(toDictionary)] ? [NetWork jsonFromDic:[model performSelector:@selector(toDictionary)] == nil ? [[NSDictionary alloc] init] : (NSDictionary *)[model performSelector:@selector(toDictionary)]] : @"") dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil]

//仅适用于sdWebImage
#define skImage(urlString, defaultName) sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultName]

//color
//#define ColorWithRGBHex(hex)    [UIColor colorWithRGBHex:hex]
#define COLOR_A(HEX, ALPHA) [UIColor colorWithRGBHexString:HEX alpha:ALPHA]
#define COLOR(HEX) COLOR_A(HEX, 1.0)
#define COLOR_RANDOM [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f]

//加载xib
#define VIEW_BY_XIB(xibName) [[[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil] lastObject]
#define VIEW_SET_FRAME(view, x, y, w, h) view.frame = CGRectMake(x, y, w, h)
#define VIEW_BY_FRAME(x, y, w, h) [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)]
