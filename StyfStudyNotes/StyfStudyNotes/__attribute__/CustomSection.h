//
//  CustomSection.h
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

#import <Foundation/Foundation.h>

#define _STRINGIZE(x)  #x
#define _STRINGIZE2(x)  _STRINGIZE(x)
#define OCNSSTRING(x) @_STRINGIZE2(x)

#define _CUSTOM_SEGMENT "__CS_SEGMENT"

typedef struct {
    
}_string_pair;


NS_ASSUME_NONNULL_BEGIN

@interface CustomSection : NSObject

@end

NS_ASSUME_NONNULL_END
