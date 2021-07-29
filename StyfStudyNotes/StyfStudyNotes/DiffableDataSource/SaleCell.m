//
//  SaleCell.m
//  StyfStudyNotes
//
//  Created by styf on 2021/7/23.
//

#import "SaleCell.h"

@implementation SaleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SaleModel *)model {
    _model = model;
    self.textLabel.text = model.name;
}

@end
