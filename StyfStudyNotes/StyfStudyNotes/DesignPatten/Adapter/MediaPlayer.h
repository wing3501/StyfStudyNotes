//
//  MediaPlayer.h
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaPlayer : NSObject
- (void)playWithType:(NSString *)audioType fileName:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
