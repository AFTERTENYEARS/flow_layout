
#import "SKRow.h"

@implementation SKRow

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;
        self.alignment = sk_row_top;
        self.sk_row_width = SCREEN_WIDTH;
        self.sk_row_height = 0;
    }
    return self;
}

- (void)setSk_row_width:(double)sk_row_width {
    _sk_row_width = sk_row_width;
    self.frame = CGRectMake(0, 0, sk_row_width, self.sk_row_height);
    self.alignment = _alignment;
}

- (void)setSk_row_height:(double)sk_row_height {
    _sk_row_height = sk_row_height;
    self.frame = CGRectMake(0, 0, self.sk_row_width, sk_row_height);
    self.alignment = _alignment;
}

- (void)setAlignment:(enum SKColumn_alignment)alignment {
    _alignment = alignment;
    switch (alignment) {
        case sk_row_top:
            for (UIView *child_view in self.sk_row_childs) {
                child_view.frame = CGRectMake(VIEW_LEFT(child_view), 0, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
            }
            break;
        case sk_row_bottom:
            for (UIView *child_view in self.sk_row_childs) {
                child_view.frame = CGRectMake(VIEW_LEFT(child_view), VIEW_HEIGHT(self) - VIEW_HEIGHT(child_view), VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
            }
            break;
            
        default:
            for (UIView *child_view in self.sk_row_childs) {
                child_view.frame = CGRectMake(VIEW_LEFT(child_view), (VIEW_HEIGHT(self) - VIEW_HEIGHT(child_view)) / 2.0, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
            }
            break;
    }
}

- (void)setSk_row_childs:(NSArray<UIView *> *)sk_row_childs {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _sk_row_childs = sk_row_childs;
    
    double max_height = 0;
    for (UIView *child_view in sk_row_childs) {
        if (VIEW_HEIGHT(child_view) > max_height) {
            max_height = VIEW_HEIGHT(child_view);
        }
    }
    
    if (self.sk_row_height <= 0) {
        _sk_row_height = max_height;
    }
    
    double childs_total_width = 0;
    for (UIView *child_view in sk_row_childs) {
        
        switch (self.alignment) {
            case sk_row_top:
                child_view.frame = CGRectMake(childs_total_width, 0, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                break;
            case sk_row_bottom:
                child_view.frame = CGRectMake(childs_total_width, self.sk_row_height - VIEW_HEIGHT(child_view), VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                break;
            default:
                child_view.frame = CGRectMake(childs_total_width, (self.sk_row_height - VIEW_HEIGHT(child_view)) / 2.0, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                break;
        }
        [self addSubview:child_view];
        childs_total_width += VIEW_WIDTH(child_view);
    }
    
    self.frame = CGRectMake(0, 0, self.sk_row_width, self.sk_row_height);
}

@end
