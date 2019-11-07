#import "NSObject+Extend.h"


@implementation NSObject (Extend)
+ (NSString *)className {
    return [[self class] description];
}

@end