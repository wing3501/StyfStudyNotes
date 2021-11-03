//
//  UIViewController+KVO.h
//  StyfStudyNotes
//
//  Created by styf on 2021/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KVO)
- (void)swizzleVCinitMethod;
@end

NS_ASSUME_NONNULL_END
