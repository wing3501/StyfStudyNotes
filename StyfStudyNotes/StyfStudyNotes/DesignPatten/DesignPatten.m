//
//  DesignPatten.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "DesignPatten.h"
#import "Circle.h"
#import "Rectangle.h"
#import "RedShapeDecorator.h"

@interface DesignPatten ()

@end

@implementation DesignPatten

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self decoratorTest];
}

- (void)decoratorTest {
    Circle *circle = [Circle new];
    [circle draw];
    
    RedShapeDecorator *redCircle = [[RedShapeDecorator alloc]initWithShape:[Circle new]];
    RedShapeDecorator *redRectangle = [[RedShapeDecorator alloc]initWithShape:[Rectangle new]];
    
    [redCircle draw];
    [redRectangle draw];
}

@end
