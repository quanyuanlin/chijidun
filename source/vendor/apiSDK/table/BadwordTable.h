/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface BadwordTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *badword;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *replaceword;
@property(strong, nonatomic) NSString *word_type;

@end