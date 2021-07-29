//
//  SaleHeaderFooterView.m
//  StyfStudyNotes
//
//  Created by styf on 2021/7/23.
//

#import "SaleHeaderFooterView.h"
#import <Masonry/Masonry.h>
@interface SaleHeaderFooterView()
/// 
@property (nonatomic, strong) UILabel *label;
@end

@implementation SaleHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc]init];
        _label.textColor = UIColor.redColor;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setIsHeader:(BOOL)isHeader {
    _isHeader = isHeader;
}

- (void)setNumber:(NSInteger)number {
    _number = number;
    _label.text = [NSString stringWithFormat:@"%@-%ld",_isHeader ? @"Header" : @"Footer",(long)number];
}

@end
