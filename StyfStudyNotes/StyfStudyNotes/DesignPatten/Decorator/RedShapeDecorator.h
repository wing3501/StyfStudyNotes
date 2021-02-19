//
//  RedShapeDecorator.h
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "ShapeDecorator.h"

NS_ASSUME_NONNULL_BEGIN

@interface RedShapeDecorator : ShapeDecorator
- (instancetype)initWithShape:(Shape *)decoratedShape;
@end

NS_ASSUME_NONNULL_END
