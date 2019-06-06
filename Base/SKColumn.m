
#import "SKColumn.h"

@implementation SKColumn

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;
        self.alignment = sk_column_left;
        self.sk_column_width = SCREEN_WIDTH;
    }
    return self;
}

- (void)setSk_column_width:(double)sk_column_width {
    _sk_column_width = sk_column_width;
    self.frame = CGRectMake(0, 0, sk_column_width, VIEW_HEIGHT(self));
    self.alignment = _alignment;
}

- (void)setAlignment:(enum SKColumn_alignment)alignment {
    _alignment = alignment;
    switch (alignment) {
        case sk_column_left:
            for (UIView *child_view in self.sk_column_childs) {
                child_view.frame = CGRectMake(0, VIEW_TOP(child_view), VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
            }
            break;
        case sk_column_right:
            for (UIView *child_view in self.sk_column_childs) {
                child_view.frame = CGRectMake(VIEW_WIDTH(self) - VIEW_WIDTH(child_view), VIEW_TOP(child_view), VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
            }
            break;
            
        default:
            for (UIView *child_view in self.sk_column_childs) {
                child_view.frame = CGRectMake((VIEW_WIDTH(self) - VIEW_WIDTH(child_view)) / 2.0, VIEW_TOP(child_view), VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
            }
            break;
    }
}

- (void)setSk_column_childs:(NSArray<UIView *> *)sk_column_childs {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _sk_column_childs = sk_column_childs;
    double childs_total_height = 0;
    for (UIView *child_view in sk_column_childs) {
        
        switch (self.alignment) {
            case sk_column_left:
                child_view.frame = CGRectMake(0, childs_total_height, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                break;
            case sk_column_right:
                child_view.frame = CGRectMake(VIEW_WIDTH(self) - VIEW_WIDTH(child_view), childs_total_height, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                break;
            default:
                child_view.frame = CGRectMake((VIEW_WIDTH(self) - VIEW_WIDTH(child_view)) / 2.0, childs_total_height, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                break;
        }
        [self addSubview:child_view];
        childs_total_height += VIEW_HEIGHT(child_view);
    }
    
    self.frame = CGRectMake(0, 0, VIEW_WIDTH(self), childs_total_height);
}



@end
