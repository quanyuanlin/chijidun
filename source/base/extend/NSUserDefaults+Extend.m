@implementation NSUserDefaults (Extend)
+ (void)saveJsonForKey:(NSString *)key data:(NSString *)data {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSMutableDictionary *)getJsonForKey:(NSString *)key {
    NSError *error = nil;
    NSString *dataStr = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (dataStr == nil) {
        return [NSMutableDictionary new];
    } else {
        return [NSJSONSerialization
                JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding]
                           options:NSJSONReadingMutableContainers
                             error:&error];
    }

}

+ (void)saveDataForKey:(NSString *)key data:(id)data {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSMutableDictionary *)getDataForKey:(NSString *)key {
    return [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:key]];
}

@end