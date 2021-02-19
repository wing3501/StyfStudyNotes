//
//  AdvancedMediaPlayer.h
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdvancedMediaPlayer : NSObject
- (void)playVlcWithFileName:(NSString *)fileName;
- (void)playMp4WithFileName:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
