//
//  UIView+Ext.m
//  StyfStudyNotes
//
//  Created by styf on 2021/6/16.
//

#import "UIView+Ext.h"

@implementation UIView (Ext)

- (void)setCm_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setCm_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)cm_x
{
    return self.frame.origin.x;
}

- (CGFloat)cm_y
{
    return self.frame.origin.y;
}

- (void)setCm_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)cm_centerX
{
    return self.center.x;
}

- (void)setCm_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)cm_centerY
{
    return self.center.y;
}

- (void)setCm_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setCm_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)cm_height
{
    return self.frame.size.height;
}

- (CGFloat)cm_width
{
    return self.frame.size.width;
}

- (void)setCm_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)cm_size
{
    return self.frame.size;
}

- (void)setCm_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)cm_origin
{
    return self.frame.origin;
}

- (CGFloat)cm_left {
    return self.frame.origin.x;
}

- (void)setCm_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)cm_top {
    return self.frame.origin.y;
}

- (void)setCm_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)cm_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setCm_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)cm_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCm_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (nonnull UIViewController * )cm_viewController {
    UIResponder *next = self.nextResponder;
    do {
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}

- (nonnull UITapGestureRecognizer *)cm_addSingleTapGestureAtTarget:(nonnull id)target action:(nonnull SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    [self setUserInteractionEnabled:YES];
    return tap;
}

- (nonnull UISwipeGestureRecognizer *)cm_addSwipeLeftGestureAtTarget:(nonnull id)target action:(nonnull SEL)action {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipe];
    [self setUserInteractionEnabled:YES];
    return swipe;
}

- (nonnull UILongPressGestureRecognizer *)cm_addLongGestureAtTarget:(nonnull id)target action:(nonnull SEL)action duration:(NSTimeInterval)duration {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    longPress.minimumPressDuration = duration;
    [self addGestureRecognizer:longPress];
    [self setUserInteractionEnabled:YES];
    return longPress;
}

- (void)cm_removeAllSubViews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}


+ (void)cm_getStatusBarSafariItem:(nonnull UIView *)newView {
    for (UIView *view in newView.subviews) {
        if ([view.class.description isEqualToString:@"UIStatusBarOpenInSafariItemView"]) {
            view.userInteractionEnabled = NO;
            return;
        }
        [UIView cm_getStatusBarSafariItem:view];
    }
}
@end
