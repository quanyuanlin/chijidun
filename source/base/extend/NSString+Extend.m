@implementation NSString (Extend)
- (instancetype)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (instancetype)replace:(NSString *)search to:(NSString *)to {
    return [self stringByReplacingOccurrencesOfString:search withString:to];
}

- (instancetype)pad:(NSUInteger)pad {
    NSMutableString *format_prefix = [NSMutableString new];
    for (NSUInteger i = 0; i < pad; i++) {
        [format_prefix appendString:@" "];
    }
    return [[NSString alloc] initWithFormat:@"%@%@%@", format_prefix, self, format_prefix];
}

- (CGFloat)getWidth:(NSUInteger)fontSize {
    return [self sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}].width;
}

- (CGFloat)getHeight:(NSUInteger)fontSize width:(CGFloat)width {
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                              context:nil].size.height;
}

- (NSData *)toData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)stringWithDateFormat:(NSString *)format {
    NSDate *date = [self dateWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

- (NSDate *)toDate {
    return [self dateWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSDate *)dateWithDateFormat:(NSString *)format {
    NSDate *date;
    @try {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = format;
        date = [dateFormatter dateFromString:self];
    } @catch (NSException *e) {

    }
    if (date == nil) {
        date = [NSDate new];
    }
    return date;
}

- (BOOL)isMobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
-(BOOL)isValidateMail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
- (BOOL)isUrl {
    NSURL *url = [NSURL URLWithString:self];
    NSArray *schemes = @[@"http", @"https", @"ftp"];
    for (int i = 0; i < schemes.count; ++i) {
        if ([url.scheme isEqualToString:schemes[i]]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)host {
    if (![self isUrl])return nil;
    return [NSURL URLWithString:self].host;
}

- (BOOL)isEmpty {
    if ([self length] == 0) {
        return YES;
    }
    return ![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length];

}

@end