//
//  ShapeDecorator.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "ShapeDecorator.h"

@implementation ShapeDecorator

- (void)draw {
    [self.decoratedShape draw];
}

@end
