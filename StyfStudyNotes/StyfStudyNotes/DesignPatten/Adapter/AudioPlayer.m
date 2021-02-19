//
//  AudioPlayer.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "AudioPlayer.h"

@interface AudioPlayer ()
/// 适配器
@property (nonatomic, strong) MediaAdapter *mediaAdapter;
@end

@implementation AudioPlayer
- (void)playWithType:(NSString *)audioType fileName:(NSString *)fileName {
    if ([audioType.lowercaseString isEqualToString:@"vlc"] || [audioType.lowercaseString isEqualToString:@"mp4"]) {
        [self.mediaAdapter playWithType:audioType fileName:fileName];
    }else {
        [super playWithType:audioType fileName:fileName];
    }
}
@end
