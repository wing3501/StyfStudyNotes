//
//  MediaAdapter.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "MediaAdapter.h"
#import "Mp4Player.h"
#import "VlcPlayer.h"

@implementation MediaAdapter
- (instancetype)initWithAudioType:(NSString *)audioType {
    self = [super init];
    if (self) {
        if ([audioType.lowercaseString isEqualToString:@"vlc"]) {
            self.advancedMusicPlayer = [VlcPlayer new];
        }else if ([audioType.lowercaseString isEqualToString:@"mp4"]) {
            self.advancedMusicPlayer = [Mp4Player new];
        }
    }
    return self;
}

- (void)playWithType:(NSString *)audioType fileName:(NSString *)fileName {
    if ([audioType.lowercaseString isEqualToString:@"vlc"]) {
        [self.advancedMusicPlayer playVlcWithFileName:fileName];
    }else if ([audioType.lowercaseString isEqualToString:@"mp4"]) {
        [self.advancedMusicPlayer playMp4WithFileName:fileName];
    }
}

@end
