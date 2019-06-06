
#import "SKRow.h"

@implementation SKRow

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = YES;
        self.alignment = sk_row_top;
        self.direction = start;
        self.sk_row_width = SCREEN_WIDTH;
        self.sk_row_height = 0;
    }
    return self;
}

- (void)setSk_row_width:(double)sk_row_width {
    _sk_row_width = sk_row_width;
    self.frame = CGRectMake(0, 0, sk_row_width, self.sk_row_height);
    [self skRowLayout];
}

- (void)setSk_row_height:(double)sk_row_height {
    _sk_row_height = sk_row_height;
    self.frame = CGRectMake(0, 0, self.sk_row_width, sk_row_height);
    [self skRowLayout];
}

- (void)setAlignment:(enum SKRow_alignment)alignment {
    _alignment = alignment;
    [self skRowLayout];
}

- (void)setDirection:(enum SKRow_direction)direction {
    _direction = direction;
    [self skRowLayout];
}

- (void)setSk_row_childs:(NSArray<UIView *> *)sk_row_childs {
    _sk_row_childs = sk_row_childs;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    double max_height = 0;
    for (UIView *child_view in sk_row_childs) {
        if (VIEW_HEIGHT(child_view) > max_height) {
            max_height = VIEW_HEIGHT(child_view);
        }
    }
    
    if (self.sk_row_height <= 0) {
        _sk_row_height = max_height;
    }
    
    for (UIView *child_view in sk_row_childs) {
        [self addSubview:child_view];
    }
    self.frame = CGRectMake(0, 0, self.sk_row_width, self.sk_row_height);
    [self skRowLayout];
}

- (void)skRowLayout {
    double leftWidth = self.sk_row_width;
    for (UIView *child_view in self.sk_row_childs) {
        leftWidth -= VIEW_WIDTH(child_view);
    }
    if (leftWidth < 0) {
        leftWidth = 0;
    }
    
    double childs_total_width = 0;
    
    for (UIView *child_view in self.sk_row_childs) {
        switch (self.alignment) {
            case sk_row_top:
                if (_direction == start) {
                    child_view.frame = CGRectMake(childs_total_width, 0, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                } else {
                    child_view.frame = CGRectMake(leftWidth + childs_total_width, 0, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                }
                break;
            case sk_row_bottom:
                if (_direction == start) {
                    child_view.frame = CGRectMake(childs_total_width, _sk_row_height - VIEW_HEIGHT(child_view), VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                } else {
                    child_view.frame = CGRectMake(leftWidth + childs_total_width, _sk_row_height - VIEW_HEIGHT(child_view), VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                }
                break;
            default:
                if (_direction == start) {
                    child_view.frame = CGRectMake(childs_total_width, (_sk_row_height - VIEW_HEIGHT(child_view)) / 2.0, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                } else {
                    child_view.frame = CGRectMake(leftWidth + childs_total_width, (_sk_row_height - VIEW_HEIGHT(child_view)) / 2.0, VIEW_WIDTH(child_view), VIEW_HEIGHT(child_view));
                }
                break;
        }
        childs_total_width += VIEW_WIDTH(child_view);
    }
}

@end
