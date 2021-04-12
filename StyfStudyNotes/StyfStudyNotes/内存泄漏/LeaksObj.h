//
//  LeaksObj.h
//  StyfStudyNotes
//
//  Created by styf on 2021/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeaksObj : NSObject
@property (nonatomic, copy) void(^block1)(void);
@end

NS_ASSUME_NONNULL_END
