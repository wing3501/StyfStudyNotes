//
//  RedShapeDecorator.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "RedShapeDecorator.h"

@implementation RedShapeDecorator

- (instancetype)initWithShape:(Shape *)decoratedShape {
    self = [super init];
    if (self) {
        self.decoratedShape = decoratedShape;
    }
    return self;
}

- (void)draw {
    //适配器增加新功能
    [self setRedBorder];
    [self.decoratedShape draw];
}

- (void)setRedBorder {
    NSLog(@"红色边框");
}

@end
