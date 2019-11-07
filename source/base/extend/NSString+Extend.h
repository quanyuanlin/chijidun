#import <Foundation/Foundation.h>

@interface NSString (Extend)
- (instancetype)trim;

- (instancetype)replace:(NSString *)search to:(NSString *)to;

- (instancetype)pad:(NSUInteger)pad;

- (CGFloat)getWidth:(NSUInteger)fontSize;

- (CGFloat)getHeight:(NSUInteger)fontSize width:(CGFloat)width;

- (NSData *)toData;

- (NSString *)stringWithDateFormat:(NSString *)format;

- (NSDate *)dateWithDateFormat:(NSString *)format;

- (NSDate *)toDate;

- (BOOL)isEmpty;

//格式验证
- (BOOL)isMobile;

-(BOOL)isValidateMail;

- (BOOL)isUrl;

- (NSString *)host;
@end