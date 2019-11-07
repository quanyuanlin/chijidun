#import "ApiBase.h"

@implementation ApiBase {

}

- (NSMutableArray *)arrayFormat:(id)data {
    NSMutableArray *result = [NSMutableArray new];
    if (![data isEqual:@""] && data != nil) {
        [result addObjectsFromArray:(NSMutableArray *) data];
    }
    return result;
}

- (NSString *)stringFormat:(id)data {
    return data == nil ? @"" : [[NSString alloc] initWithFormat:@"%@", data];
}

- (NSString *)JSONItemFormat:(NSString *)format data:(NSString *)data {
    if(data==nil){
        data=@"";
    }
    data = [data stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    data = [data stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\n"];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    data = [data stringByReplacingOccurrencesOfString:@"\r" withString:@"\\n"];
    return [NSString stringWithFormat:format, data];
}

@end
