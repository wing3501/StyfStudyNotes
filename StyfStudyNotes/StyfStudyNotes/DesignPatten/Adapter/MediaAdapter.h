//
//  MediaAdapter.h
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "MediaPlayer.h"
#import "AdvancedMediaPlayer.h"

NS_ASSUME_NONNULL_BEGIN
//适配器基类
@interface MediaAdapter : MediaPlayer
/// <#name#>
@property (nonatomic, strong) AdvancedMediaPlayer *advancedMusicPlayer;
@end

NS_ASSUME_NONNULL_END
