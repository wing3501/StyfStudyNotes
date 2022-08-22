//
//  UIView+Ext.h
//  StyfStudyNotes
//
//  Created by styf on 2021/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Ext)
@property (nonatomic) CGFloat cm_x;
@property (nonatomic) CGFloat cm_y;
@property (nonatomic) CGFloat cm_width;
@property (nonatomic) CGFloat cm_height;
@property (nonatomic) CGFloat cm_centerX;
@property (nonatomic) CGFloat cm_centerY;
@property (nonatomic) CGSize  cm_size;
@property (nonatomic) CGPoint cm_origin;

@property (nonatomic) CGFloat cm_left;
@property (nonatomic) CGFloat cm_top;
@property (nonatomic) CGFloat cm_right;
@property (nonatomic) CGFloat cm_bottom;


/**
 获取view所在的控制器

 @return 控制器
 */
- (nonnull UIViewController * )cm_viewController;

/**
 添加tap手势

 @param target target
 @param action action
 @return tap手势
 */
- (nonnull UITapGestureRecognizer *)cm_addSingleTapGestureAtTarget:(nonnull id)target action:(nonnull SEL)action;


/**
 添加swipe手势

 @param target target
 @param action action
 @return swipe手势
 */
- (nonnull UISwipeGestureRecognizer *)cm_addSwipeLeftGestureAtTarget:(nonnull id)target action:(nonnull SEL)action;

/**
 添加long手势
 
 @param target target
 @param action action
 @return swipe手势
 */
- (nonnull UILongPressGestureRecognizer *)cm_addLongGestureAtTarget:(nonnull id)target action:(nonnull SEL)action duration:(NSTimeInterval)duration;

/**
 移除该view上的所有view
 */
- (void)cm_removeAllSubViews;


/**
 通用连接 禁用右上角链接点击
 
 @param newView 传入navigationBar
 */
+ (void)cm_getStatusBarSafariItem:(nonnull UIView *)newView;

@end

NS_ASSUME_NONNULL_END
