//
//  ShapeDecorator.h
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "Shape.h"

NS_ASSUME_NONNULL_BEGIN
//https://www.runoob.com/design-pattern/decorator-pattern.html
//装饰器模式
//装饰器模式（Decorator Pattern）允许向一个现有的对象添加新的功能，同时又不改变其结构。
@interface ShapeDecorator : Shape
/// 被装饰的类
@property (nonatomic, strong) Shape *decoratedShape;
@end

NS_ASSUME_NONNULL_END
